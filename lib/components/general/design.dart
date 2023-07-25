import 'package:flutter/material.dart';
import '/theme/appColors.dart';

class CustomDesign {
  static Widget h2Title(title, {center}) {
    return Align(
      alignment: center ? Alignment.topCenter : Alignment.centerLeft,
      child: Container(
        child: Text(
          title,
          textAlign: TextAlign.left,
          style: AppColors.darkT(size: 14, bold: true),
        ),
      ),
    );
  }
}
