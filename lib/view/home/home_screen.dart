import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(S.of(context).introTitle1),
        ),
      ),
    );
  }
}
