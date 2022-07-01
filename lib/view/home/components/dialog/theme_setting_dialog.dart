import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meditation/generated/l10n.dart';
import 'package:meditation/view/common/ripple_widget.dart';
import 'package:meditation/view/home/home_screen.dart';
import 'package:meditation/view_models/main_view_model.dart';
import 'package:provider/provider.dart';

class ThemeSettingDialog extends StatelessWidget {
  const ThemeSettingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 8.0,
              ),
              Text(S.of(context).selectTheme),
              SizedBox(
                height: 8.0,
              ),
              Expanded(
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  children: List.generate(
                    meisoThemes.length,
                    (int index) => RippleWidget(
                      onTap: () {
                        _setTheme(context, index);
                        Navigator.pop(context);
                      },
                      child: GridTile(
                        child: Image.asset(
                          meisoThemes[index].imagePath,
                          fit: BoxFit.fill,
                        ),
                        footer: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              Center(child: Text(meisoThemes[index].themeName)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 8.0,
            right: 8.0,
            child: RippleWidget(
              child: FaIcon(FontAwesomeIcons.windowClose),
              onTap: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }

  void _setTheme(BuildContext context, int index) {
    final viewModel = context.read<MainViewModel>();
    viewModel.setTheme(index);
  }
}
