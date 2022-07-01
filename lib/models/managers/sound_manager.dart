import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class SoundManager {
  AudioPlayer _bellPlayer = AudioPlayer();
  AudioPlayer _bgmPlayer = AudioPlayer();
  AudioPlayer _soundGongPlayer = AudioPlayer();

  double bellVolume = 0.2;

  Future<void> prepareSounds(
      String bellPath, String? bgmPath, bool isNeedBgm) async {
    await _bellPlayer.setAsset(bellPath);
    await _bellPlayer.setLoopMode(LoopMode.one);
    await _bellPlayer.setVolume(bellVolume);

    if (isNeedBgm) {
      await _bgmPlayer.setAsset(bgmPath!);
      await _bgmPlayer.setLoopMode(LoopMode.one);
      await _bgmPlayer.setVolume(bellVolume);
    }
  }

  startBgm(String bellPath, String? bgmPath, bool isNeedBgm) {
    _bellPlayer.setVolume(bellVolume);
    _bellPlayer
      ..seek(Duration.zero)
      ..play();
    _bgmPlayer
      ..seek(Duration.zero)
      ..play();
  }

  void stopBgm(bool isNeedBgm) {
    _bellPlayer.stop();
    if (isNeedBgm) _bgmPlayer.stop();
  }

  void ringFinalGong() async {
    await _soundGongPlayer.setAsset("assets/sounds/gong_sound.mp3");
    await _soundGongPlayer.setVolume(bellVolume);
    _soundGongPlayer.play();
  }

  void changeVolume(double newVolume) {
    bellVolume = newVolume / 100;
    _bellPlayer.setVolume(bellVolume);
    _soundGongPlayer.setVolume(bellVolume);
  }

  void dispose() {
    _bellPlayer.dispose();
    _bgmPlayer.dispose();
    _soundGongPlayer.dispose();
  }
}
