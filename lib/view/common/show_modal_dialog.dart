import 'package:flutter/material.dart';
import 'package:meditation/view/styles.dart';

showModalDialog({
  required BuildContext context,
  required Widget dialogWidget,
  required bool isScrollable,
}) {
  showModalBottomSheet(
    context: context,
    builder: (context) => dialogWidget,
    isScrollControlled: isScrollable,
    backgroundColor: dialogBackgroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(24.0),
      ),
    ),
  );
}
