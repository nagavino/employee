import 'package:flutter/material.dart';

import '../../../domain/constants.dart';

// ignore: must_be_immutable
class PrimaryButton extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final onPressed;
  String text;
  int customColor = 0;
  final double customFontSize;
  PrimaryButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.customColor,
    this.customFontSize = 14,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor:
            widget.customColor == 0 ? primaryColor : Color(widget.customColor),
        shape: RoundedRectangleBorder(
            side: BorderSide(
                color: transparent, width: 1, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(25)),
      ),
      child: Text(widget.text, style: TextStyle(color: white, fontSize: 12)),
    );
  }
}
