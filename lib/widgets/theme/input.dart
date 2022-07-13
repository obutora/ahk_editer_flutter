import 'package:ahk_editor_flutter/widgets/theme/color.dart';
import 'package:flutter/material.dart';

InputDecoration StandardInputDecoration(String label) {
  return InputDecoration(
    border: const OutlineInputBorder(
      borderSide: BorderSide(color: kPrimaryGreen, width: 1),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    focusedBorder: const OutlineInputBorder(
      borderSide: BorderSide(color: kPrimaryGreen, width: 2),
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    focusColor: kPrimaryGreen,
    labelText: label,
  );
}
