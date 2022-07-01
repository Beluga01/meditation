import 'package:flutter/material.dart';
import 'package:meditation/view/styles.dart';

class RippleWidget extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;

  const RippleWidget({
    Key? key,
    required this.child,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: touchFeedbackColor,
        child: child,
        onTap: onTap,
      ),
    );
  }
}
