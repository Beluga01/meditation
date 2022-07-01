import 'package:flutter/material.dart';
import 'package:meditation/generated/l10n.dart';
import 'package:meditation/view/home/home_screen.dart';
import 'package:meditation/view_models/main_view_model.dart';
import 'package:provider/provider.dart';

class LevelSettingDialog extends StatelessWidget {
  const LevelSettingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 8.0,
        ),
        Text(S.of(context).selectLevel),
        SizedBox(
          height: 8.0,
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: levels.length,
          itemBuilder: (context, int index) => ListTile(
            title: Center(child: Text(levels[index].levelName)),
            subtitle: Center(child: Text(levels[index].explanation)),
            onTap: () {
              _setLevel(context, index);
              Navigator.pop(context);
            },
          ),
        ),
      ],
    );
  }

  void _setLevel(BuildContext context, int index) {
    final viewModel = context.read<MainViewModel>();
    viewModel.setLevel(index);
  }
}
