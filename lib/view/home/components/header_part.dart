import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meditation/data_models/user_settings.dart';
import 'package:meditation/generated/l10n.dart';
import 'package:meditation/utils/constants.dart';
import 'package:meditation/view/common/ripple_widget.dart';
import 'package:meditation/view/common/show_modal_dialog.dart';
import 'package:meditation/view/home/components/dialog/level_setting_dialog.dart';
import 'package:meditation/view/home/components/dialog/theme_setting_dialog.dart';
import 'package:meditation/view/home/components/dialog/time_setting_dialog.dart';
import 'package:meditation/view/home/home_screen.dart';
import 'package:meditation/view/styles.dart';
import 'package:meditation/view_models/main_view_model.dart';
import 'package:provider/provider.dart';

class HeaderPart extends StatelessWidget {
  final UserSettings userSettings;

  const HeaderPart({Key? key, required this.userSettings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child:
                _createItem(context, userSettings.levelId, HeaderType.LEVEL)),
        Expanded(
            child:
                _createItem(context, userSettings.themeId, HeaderType.THEME)),
        Expanded(
            child: _createItem(
                context, userSettings.timeMinutes, HeaderType.TIME)),
      ],
    );
  }

  Widget _createItem(BuildContext context, int id, HeaderType headerType) {
    return Selector<MainViewModel, RunningStatus>(
      selector: (context, MainViewModel viewModel) => viewModel.runningStatus,
      builder: (context, runningStatus, child) => RippleWidget(
        onTap: (runningStatus != RunningStatus.BEFORE_START &&
                runningStatus != RunningStatus.FINISHED)
            ? () => Fluttertoast.showToast(
                msg: S.of(context).showSettingsAgain,
                backgroundColor: dialogBackgroundColor,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM)
            : () => _openSettingDialog(context, headerType),
        child: Column(
          children: [
            _createItemIcon(headerType),
            SizedBox(
              height: 8.0,
            ),
            _displayItemText(context, id, headerType),
          ],
        ),
      ),
    );
  }

  Widget _createItemIcon(HeaderType headerType) {
    Widget icon;
    switch (headerType) {
      case HeaderType.LEVEL:
        icon = FaIcon(FontAwesomeIcons.mountain);
        break;
      case HeaderType.THEME:
        icon = FaIcon(FontAwesomeIcons.images);
        break;
      case HeaderType.TIME:
        icon = FaIcon(FontAwesomeIcons.stopwatch);
        break;
    }
    return icon;
  }

  Widget _displayItemText(BuildContext context, int id, HeaderType headerType) {
    Widget displayTextWidget;
    switch (headerType) {
      case HeaderType.LEVEL:
        displayTextWidget = Text(levels[id].levelName);
        break;
      case HeaderType.THEME:
        displayTextWidget = Text(meisoThemes[id].themeName);
        break;
      case HeaderType.TIME:
        displayTextWidget = Selector<MainViewModel, String>(
          selector: (context, viewModel) => viewModel.remainingTimeString,
          builder: (context, timeString, child) =>
              displayTextWidget = Text(timeString),
        );
        break;
    }
    return displayTextWidget;
  }

  _openSettingDialog(BuildContext context, HeaderType headerType) {
    switch (headerType) {
      case HeaderType.LEVEL:
        showModalDialog(
            context: context,
            dialogWidget: LevelSettingDialog(),
            isScrollable: false);
        break;
      case HeaderType.THEME:
        showModalDialog(
            context: context,
            dialogWidget: ThemeSettingDialog(),
            isScrollable: true);
        break;
      case HeaderType.TIME:
        showModalDialog(
            context: context,
            dialogWidget: TimeSettingDialog(),
            isScrollable: false);
        break;
    }
  }
}
