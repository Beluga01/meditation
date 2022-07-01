import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:meditation/data_models/level.dart';
import 'package:meditation/data_models/meiso_theme.dart';
import 'package:meditation/data_models/meiso_time.dart';
import 'package:meditation/data_models/user_settings.dart';
import 'package:meditation/models/managers/ad_manager.dart';
import 'package:meditation/view/home/components/decorated_background.dart';
import 'package:meditation/view/home/components/header_part.dart';
import 'package:meditation/view/home/components/play_buttons_part.dart';
import 'package:meditation/view/home/components/speed_dial_part.dart';
import 'package:meditation/view/home/components/status_display_part.dart';
import 'package:meditation/view/home/components/volume_slider_part.dart';
import 'package:meditation/view_models/main_view_model.dart';
import '../../../generated/l10n.dart';
import 'package:provider/provider.dart';

List<Level> levels = [];
List<MeisoTheme> meisoThemes = [];
List<MeisoTime> meisoTimes = [];

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    levels = setLevels(context);
    meisoThemes = setMeisoThemes(context);
    meisoTimes = setMeisoTimes(context);

    Future(() {
      final viewModel = context.read<MainViewModel>();
      viewModel
        ..getUserSettings()
        ..loadBannerAd();
    });

    return SafeArea(
      child: Scaffold(
        floatingActionButton: SpeedDialPart(),
        body: Selector<MainViewModel, UserSettings?>(
          selector: (context, viewModel) => viewModel.userSettings,
          builder: (context, userSettings, child) {
            return userSettings == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Stack(
                    fit: StackFit.expand,
                    children: [
                      DecoratedBackGround(
                        theme: meisoThemes[userSettings.themeId],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            HeaderPart(
                              userSettings: userSettings,
                            ),
                            StatusDisplayPart(),
                            PlayButtonsPart(),
                            VolumeSliderPart(),
                          ],
                        ),
                      ),
                      Selector<MainViewModel, AdManager>(
                        builder: (context, adManager, child) {
                          final bannerAd = adManager.bannerAd;
                          //aaa
                          return Positioned(
                            bottom: 8.0,
                            left: 20.0,
                            right: 20.0,
                            child: (bannerAd == null)
                                ? Container(
                                    height: 0.0,
                                    width: 0.0,
                                  )
                                : Container(
                                    width: bannerAd.size.width.toDouble(),
                                    height: bannerAd.size.height.toDouble(),
                                    child: AdWidget(
                                      ad: bannerAd,
                                    ),
                                  ),
                          );
                        },
                        selector: (context, viewModel) => viewModel.adManager,
                      )
                    ],
                  );
          },
        ),
      ),
    );
  }

  List<Level> setLevels(BuildContext context) {
    return [
      Level(
        levelId: LEVEL_ID_EASY,
        levelName: S.of(context).levelEasy,
        explanation: S.of(context).levelSelectEasy,
        bellPath: "assets/sounds/bells_easy.mp3",
        totalInterval: 12,
        inhaleInterval: 4,
        holdInterval: 4,
        exhaleInterval: 4,
      ),
      Level(
        levelId: LEVEL_ID_NORMAL,
        levelName: S.of(context).levelNormal,
        explanation: S.of(context).levelSelectNormal,
        bellPath: "assets/sounds/bells_normal.mp3",
        totalInterval: 16,
        inhaleInterval: 4,
        holdInterval: 4,
        exhaleInterval: 8,
      ),
      Level(
        levelId: LEVEL_ID_MID,
        levelName: S.of(context).levelMid,
        explanation: S.of(context).levelSelectMid,
        bellPath: "assets/sounds/bells_mid.mp3",
        totalInterval: 20,
        inhaleInterval: 4,
        holdInterval: 8,
        exhaleInterval: 8,
      ),
      Level(
        levelId: LEVEL_ID_HIGH,
        levelName: S.of(context).levelHigh,
        explanation: S.of(context).levelSelectHigh,
        bellPath: "assets/sounds/bells_advanced.mp3",
        totalInterval: 28,
        inhaleInterval: 4,
        holdInterval: 16,
        exhaleInterval: 8,
      ),
    ];
  }

  List<MeisoTheme> setMeisoThemes(BuildContext context) {
    return [
      MeisoTheme(
        themeId: THEME_ID_SILENCE,
        themeName: S.of(context).themeSilence,
        imagePath: "assets/images/silence.jpg",
        soundPath: null,
      ),
      MeisoTheme(
        themeId: THEME_ID_CAVE,
        themeName: S.of(context).themeCave,
        imagePath: "assets/images/cave.jpg",
        soundPath: "assets/sounds/bgm_cave.mp3",
      ),
      MeisoTheme(
        themeId: THEME_ID_SPRING,
        themeName: S.of(context).themeSpring,
        imagePath: "assets/images/spring.jpg",
        soundPath: "assets/sounds/bgm_spring.mp3",
      ),
      MeisoTheme(
        themeId: THEME_ID_SUMMER,
        themeName: S.of(context).themeSummer,
        imagePath: "assets/images/summer.jpg",
        soundPath: "assets/sounds/bgm_summer.mp3",
      ),
      MeisoTheme(
        themeId: THEME_ID_AUTUMN,
        themeName: S.of(context).themeAutumn,
        imagePath: "assets/images/autumn.jpg",
        soundPath: "assets/sounds/bgm_autumn.mp3",
      ),
      MeisoTheme(
        themeId: THEME_ID_STREAM,
        themeName: S.of(context).themeStream,
        imagePath: "assets/images/stream.jpg",
        soundPath: "assets/sounds/bgm_stream.mp3",
      ),
      MeisoTheme(
        themeId: THEME_ID_WIND_BELLS,
        themeName: S.of(context).themeWindBell,
        imagePath: "assets/images/wind_bell.jpg",
        soundPath: "assets/sounds/bgm_wind_bell.mp3",
      ),
      MeisoTheme(
        themeId: THEME_ID_BONFIRE,
        themeName: S.of(context).themeBonfire,
        imagePath: "assets/images/bonfire.jpg",
        soundPath: "assets/sounds/bgm_bonfire.mp3",
      ),
    ];
  }

  List<MeisoTime> setMeisoTimes(BuildContext context) {
    return [
      MeisoTime(
        timeDisplayString: S.of(context).min5,
        timeMinutes: 5,
      ),
      MeisoTime(
        timeDisplayString: S.of(context).min10,
        timeMinutes: 10,
      ),
      MeisoTime(
        timeDisplayString: S.of(context).min15,
        timeMinutes: 15,
      ),
      MeisoTime(
        timeDisplayString: S.of(context).min20,
        timeMinutes: 20,
      ),
      MeisoTime(
        timeDisplayString: S.of(context).min30,
        timeMinutes: 30,
      ),
      MeisoTime(
        timeDisplayString: S.of(context).min60,
        timeMinutes: 60,
      ),
    ];
  }
}
