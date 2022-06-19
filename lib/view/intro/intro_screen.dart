import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:meditation/generated/l10n.dart';
import 'package:meditation/models/repositories/shared_prefs_repository.dart';
import 'package:meditation/view/common/show_modal_dialog.dart';
import 'package:meditation/view/home/home_screen.dart';
import 'package:meditation/view/intro/skip_intro_dialog.dart';
import 'package:meditation/view_models/main_view_model.dart';
import 'package:provider/provider.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      slides: _createSlides(context),
      onDonePress: () => _openHomeScreen(context),
      onSkipPress: () => showModalDialog(
        context: context,
        dialogWidget: SkipIntroDialog(onSkipped: () => _skipIntro(context)),
        isScrollable: false,
      ),
    );
  }

  _createSlides(BuildContext context) {
    final appTheme = Theme.of(context);
    return [
      Slide(
        title: S.of(context).introTitle1,
        description: S.of(context).introDesc1,
        pathImage: "assets/images/intro_image01.png",
        backgroundColor: appTheme.primaryColorDark,
      ),
      Slide(
        title: S.of(context).introTitle2,
        description: S.of(context).introDesc2,
        pathImage: "assets/images/intro_image02.png",
        backgroundColor: appTheme.primaryColor,
      ),
      Slide(
        title: S.of(context).introTitle3,
        description: S.of(context).introDesc3,
        pathImage: "assets/images/intro_image03.png",
        backgroundColor: appTheme.primaryColorLight,
      ),
      Slide(
        title: S.of(context).introTitle4,
        description: S.of(context).introDesc4,
        pathImage: "assets/images/meiso_logo.png",
        backgroundColor: appTheme.primaryColor,
      ),
    ];
  }

  _openHomeScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ),
    );
  }

  // 二度とイントロ画面を表示させない設定
  _skipIntro(BuildContext context) async{
    final viewModel = context.read<MainViewModel>();
    await viewModel.skipIntro();
    _openHomeScreen(context);
  }
}
