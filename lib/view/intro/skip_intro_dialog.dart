import 'package:flutter/material.dart';
import 'package:meditation/generated/l10n.dart';

class SkipIntroDialog extends StatelessWidget {
  final VoidCallback onSkipped;

  const SkipIntroDialog({Key? key, required this.onSkipped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120.0,
      child: Column(
        children: [
          SizedBox(
            height: 8.0,
          ),
          Center(
            child: Text(
              S.of(context).skipIntroConfirm,
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: onSkipped,
                child: Text(S.of(context).yes),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(S.of(context).no),
              ),
            ],
          )
        ],
      ),
    );
  }
}
