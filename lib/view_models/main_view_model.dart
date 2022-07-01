import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meditation/data_models/meiso_theme.dart';
import 'package:meditation/data_models/user_settings.dart';
import 'package:meditation/models/managers/ad_manager.dart';
import 'package:meditation/models/managers/in_app_purchase_manager.dart';
import 'package:meditation/models/managers/sound_manager.dart';
import 'package:meditation/models/repositories/shared_prefs_repository.dart';
import 'package:meditation/utils/constants.dart';
import 'package:meditation/utils/functions.dart';
import 'package:meditation/view/home/home_screen.dart';

class MainViewModel extends ChangeNotifier {
  final SharedPrefsRepository sharedPrefsRepository;
  final SoundManager soundManager;
  final AdManager adManager;
  final InAppPurchaseManager inAppPurchaseManager;
  UserSettings? userSettings;

  RunningStatus runningStatus = RunningStatus.BEFORE_START;

  int remainingTimeSeconds = 0;

  String get remainingTimeString => convertTimeFormat(remainingTimeSeconds);

  int intervalRemainingSeconds = INITIAL_INTERVAL;

  int timeElapsedInOneCycle = 0;

  bool isTimerCanceled = true;

  double get volume => soundManager.bellVolume * 100;

  MainViewModel(
      {required this.sharedPrefsRepository,
      required this.soundManager,
      required this.adManager,
      required this.inAppPurchaseManager}){
    adManager..initAdmob()..initBannerAd();
  }

  Future<void> skipIntro() async {
    await sharedPrefsRepository.skipIntro();
  }

  Future<bool> isSkipIntroScreen() async {
    return await sharedPrefsRepository.isSkipIntroScreen();
  }

  Future<void> getUserSettings() async {
    userSettings = await sharedPrefsRepository.getUserSettings();
    remainingTimeSeconds = userSettings!.timeMinutes * 60;
    print(remainingTimeString);
    notifyListeners();
  }

  Future<void> setLevel(int index) async {
    await sharedPrefsRepository.setLevel(index);
    getUserSettings();
  }

  Future<void> setTime(int timeMinutes) async {
    await sharedPrefsRepository.setTime(timeMinutes);
    getUserSettings();
  }

  Future<void> setTheme(int index) async {
    await sharedPrefsRepository.setTheme(index);
    getUserSettings();
  }

  void startMeditation() {
    runningStatus = RunningStatus.ON_START;
    notifyListeners();

    intervalRemainingSeconds = INITIAL_INTERVAL;
    int cnt = 0;
    Timer.periodic(
      Duration(seconds: 1),
      (timer) async {
        cnt += 1;
        intervalRemainingSeconds = INITIAL_INTERVAL - cnt;

        if (intervalRemainingSeconds <= 0) {
          timer.cancel();
          await _prepareSounds();
          _startMeditationTimer();
        } else if (runningStatus == RunningStatus.PAUSE) {
          timer.cancel();
          resetMeditation();
        }
        notifyListeners();
      },
    );
  }

  Future<void> _prepareSounds() async {
    final levelId = userSettings!.levelId;
    final themeId = userSettings!.themeId;

    final isNeedBgm = themeId != THEME_ID_SILENCE;
    final bgmPath = isNeedBgm ? meisoThemes[themeId].soundPath : null;
    final bellPath = levels[levelId].bellPath;

    await soundManager.prepareSounds(bellPath, bgmPath, isNeedBgm);
  }

  void _startBgm() async {
    final levelId = userSettings!.levelId;
    final themeId = userSettings!.themeId;

    final isNeedBgm = themeId != THEME_ID_SILENCE;
    final bgmPath = isNeedBgm ? meisoThemes[themeId].soundPath : null;
    final bellPath = levels[levelId].bellPath;

    await soundManager.startBgm(bellPath, bgmPath, isNeedBgm);
  }

  void _stopBgm() {
    final themeId = userSettings!.themeId;
    final isNeedBgm = themeId != THEME_ID_SILENCE;
    soundManager.stopBgm(isNeedBgm);
  }

  void resumeMeditation() {
    _startMeditationTimer();
  }

  void resetMeditation() {
    runningStatus = RunningStatus.BEFORE_START;
    intervalRemainingSeconds = INITIAL_INTERVAL;
    remainingTimeSeconds = userSettings!.timeMinutes * 60;
    timeElapsedInOneCycle = 0;
    notifyListeners();
  }

  void pauseMeditation() {
    isTimerCanceled = false;
    runningStatus = RunningStatus.PAUSE;
    notifyListeners();
  }

  //TODO 音量調整
  void changeVolume(double newVolume) {
    soundManager.changeVolume(newVolume);
    notifyListeners();
  }

  //TODO 瞑想処理
  void _startMeditationTimer() {
    remainingTimeSeconds = _adjustMeditationTime(remainingTimeSeconds);
    notifyListeners();

    timeElapsedInOneCycle = 0;
    _evaluateStatus();
    _startBgm();

    Timer.periodic(Duration(seconds: 1), (timer) {
      isTimerCanceled = false;
      remainingTimeSeconds -= 1;
      if (runningStatus != RunningStatus.BEFORE_START &&
          runningStatus != RunningStatus.ON_START &&
          runningStatus != RunningStatus.PAUSE) {
        _evaluateStatus();
      }

      if (runningStatus == RunningStatus.PAUSE) {
        timer.cancel();
        isTimerCanceled = true;
        _stopBgm();
      } else if (runningStatus == RunningStatus.FINISHED) {
        timer.cancel();
        isTimerCanceled = true;
        _stopBgm();
        _ringFinalGong();
      }

      notifyListeners();
    });
  }

  int _adjustMeditationTime(int remainingTimeSeconds) {
    final totalInterval = levels[userSettings!.levelId].totalInterval;
    final remainder = remainingTimeSeconds.remainder(totalInterval);
    if (remainder > (totalInterval / 2)) {
      return remainingTimeSeconds + (totalInterval - remainder);
    } else {
      return remainingTimeSeconds - remainder;
    }
  }

  void _evaluateStatus() {
    if (remainingTimeSeconds <= 0) {
      runningStatus = RunningStatus.FINISHED;
      return;
    }
    final inhaleInterval = levels[userSettings!.levelId].inhaleInterval;
    final holdInterval = levels[userSettings!.levelId].holdInterval;
    final totalInterval = levels[userSettings!.levelId].totalInterval;

    if (timeElapsedInOneCycle >= 0 && timeElapsedInOneCycle < inhaleInterval) {
      runningStatus = RunningStatus.INHALE;
      intervalRemainingSeconds = inhaleInterval - timeElapsedInOneCycle;
    } else if (timeElapsedInOneCycle < inhaleInterval + holdInterval) {
      runningStatus = RunningStatus.HOLD;
      intervalRemainingSeconds =
          (inhaleInterval + holdInterval) - timeElapsedInOneCycle;
    } else if (timeElapsedInOneCycle < totalInterval) {
      runningStatus = RunningStatus.EXHALE;
      intervalRemainingSeconds = totalInterval - timeElapsedInOneCycle;
    }
    timeElapsedInOneCycle = (timeElapsedInOneCycle >= totalInterval - 1)
        ? 0
        : timeElapsedInOneCycle + 1;
  }

  void _ringFinalGong() {
    soundManager.ringFinalGong();
  }

  @override
  void dispose() {
    super.dispose();
    soundManager.dispose();
    adManager.dispose();
  }

  loadBannerAd() {
    adManager.loadBannerAd();
  }
}
