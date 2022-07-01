import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meditation/generated/l10n.dart';
import 'package:meditation/utils/constants.dart';
import 'package:meditation/view/styles.dart';
import 'package:meditation/view_models/main_view_model.dart';
import 'package:provider/provider.dart';

class SpeedDialPart extends StatelessWidget {
  const SpeedDialPart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final runningStatus = context.select<MainViewModel, RunningStatus>(
        (viewModel) => viewModel.runningStatus);
    final iconTheme = Theme.of(context).iconTheme;

    return (runningStatus != RunningStatus.BEFORE_START)
        ? Container()
        : SpeedDial(
            animatedIcon: AnimatedIcons.menu_close,
            backgroundColor: iconTheme.color,
            overlayColor: dialogBackgroundColor,
            children: [
              SpeedDialChild(
                child: FaIcon(FontAwesomeIcons.donate),
                label: S.of(context).donation,
                labelBackgroundColor: speedDialLabelBackgroundColor,
                onTap: () => _donate(context),
              ),
              SpeedDialChild(
                child: FaIcon(FontAwesomeIcons.ad),
                label: S.of(context).deleteAd,
                labelBackgroundColor: speedDialLabelBackgroundColor,
                onTap: () => _deletead(context),
              ),
              SpeedDialChild(
                child: FaIcon(FontAwesomeIcons.subscript),
                label: S.of(context).subscription,
                labelBackgroundColor: speedDialLabelBackgroundColor,
                onTap: () => _subscribe(context),
              ),
              SpeedDialChild(
                child: FaIcon(FontAwesomeIcons.undo),
                label: S.of(context).recoverPurchase,
                labelBackgroundColor: speedDialLabelBackgroundColor,
                onTap: () => _recoverPurchase(context),
              ),
            ],
          );
  }

  //TODO 寄付をする（アプリ内課金）
  _donate(BuildContext context) {}

  //TODO 広告を消す（アプリ内課金）
  _deletead(BuildContext context) {}

  //TODO サブスクする（アプリ内課金）
  _subscribe(BuildContext context) {}

  //TODO 購入の復元（アプリ内課金）
  _recoverPurchase(BuildContext context) {}
}
