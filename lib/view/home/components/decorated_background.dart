import 'package:flutter/material.dart';
import 'package:meditation/data_models/meiso_theme.dart';

class DecoratedBackGround extends StatelessWidget {
  final MeisoTheme theme;

  const DecoratedBackGround({Key? key, required this.theme}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black87,
            Colors.black26,
          ],
        ),
      ),
      position: DecorationPosition.foreground,
      child: Image.asset(
        theme.imagePath,
        fit: BoxFit.cover,
      ),
    );
  }
}
