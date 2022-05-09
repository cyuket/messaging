import 'package:flutter/material.dart';
import 'package:messaging/app/shared/colors.dart';

// Box Decorations

final fieldDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(5),
  color: Colors.transparent,
  border: Border.all(
    color: AppColors.primaryTextColor,
  ),
);

final disabledFieldDecortaion = BoxDecoration(
  borderRadius: BorderRadius.circular(5),
  color: Colors.transparent,
  border: Border.all(
    color: AppColors.primaryTextColor,
  ),
);

final buttonDecoration = BoxDecoration(
  border: Border.all(
    color: AppColors.blueColor,
    width: 2,
  ),
  borderRadius: BorderRadius.circular(26),
);
// Field Variables

const fieldHeight = 55;
const smallFieldHeight = 40;
const inputFieldBottomMargin = 30;
const inputFieldSmallBottomMargin = 0;
const fieldPadding = EdgeInsets.symmetric(horizontal: 15);
const largeFieldPadding = EdgeInsets.symmetric(horizontal: 15, vertical: 15);
