import 'package:flutter/material.dart';

class AppColors {
  AppColors._();
  static Color primary = Color(0xFFd8076a);
  static Color orange = Color(0xFFed8b00);
  static Color success = Color(0xFF16b92a);
  static Color info = Color(0xFF79BEEC);
  static Color warning = Color(0xFFef740b);
  static Color danger = Color(0xFFd52533);
  static Color dark = Color(0xFF1c1c1c);
  static Color grey = Color(0xFFc2c2c2);

  static Color light = Color(0xFFf2f2f2);
  static Color lightdark = Color(0xFFe9e9e9);
  static Color lighter = Color(0xFFf2f2f2);
  static Color white = Color(0xFFffffff);
  static Color black = Color(0xFF000000);
  static Color backgroundColor = Color(0xFFffffff);
  static Color textLight = Color(0xFF999999);
  static Color blackOntextLight = Color(0xFFB1B1B1);

  static TextStyle darkT({double? size, bool? bold}) {
    return TextStyle(
        fontSize: size != null ? size : 13,
        fontFamily: 'Urbanist',
        fontWeight: bold != null && bold ? FontWeight.bold : FontWeight.normal,
        letterSpacing: 0,
        color: black);
  }

  static TextStyle primaryT({double? size, bool? bold}) {
    return TextStyle(
        fontSize: size != null ? size : 13,
        fontFamily: 'Urbanist',
        fontWeight: bold != null && bold ? FontWeight.bold : FontWeight.normal,
        letterSpacing: 0,
        color: primary);
  }

  static TextStyle whiteT({double? size, bool? bold}) {
    return TextStyle(
        fontSize: size != null ? size : 13,
        fontFamily: 'Urbanist',
        fontWeight: bold != null && bold ? FontWeight.bold : FontWeight.normal,
        letterSpacing: 0,
        color: white);
  }

  static TextStyle greyT({double? size, bool? bold}) {
    return TextStyle(
        fontSize: size != null ? size : 13,
        fontFamily: 'Urbanist',
        fontWeight: bold != null && bold ? FontWeight.bold : FontWeight.normal,
        letterSpacing: 0,
        color: AppColors.grey);
  }

  static TextStyle blackOnGreyT({double? size, bool? bold}) {
    return TextStyle(
        fontSize: size != null ? size : 13,
        fontFamily: 'Urbanist',
        fontWeight: bold != null && bold ? FontWeight.bold : FontWeight.normal,
        letterSpacing: 0,
        color: AppColors.blackOntextLight);
  }

  static const BoxDecoration inputContainer = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(35)),
      border: Border(
        top: BorderSide(width: 0.5, color: Color(0xFFc2c2c2)),
        left: BorderSide(width: 0.5, color: Color(0xFFc2c2c2)),
        right: BorderSide(width: 0.5, color: Color(0xFFc2c2c2)),
        bottom: BorderSide(width: 0.5, color: Color(0xFFc2c2c2)),
      ));

  static const BoxDecoration searchContainer = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(35)),
      border: Border(
        top: BorderSide(width: 4, color: Color(0xFFc2c2c2)),
        left: BorderSide(width: 4, color: Color(0xFFc2c2c2)),
        right: BorderSide(width: 4, color: Color(0xFFc2c2c2)),
        bottom: BorderSide(width: 4, color: Color(0xFFc2c2c2)),
      ));

  static const BoxDecoration shadowWhite = BoxDecoration(
    color: Colors.white,
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: Colors.black12,
        blurRadius: 4.0,
        offset: const Offset(0.0, 4.0),
      ),
    ],
  );

  static const BoxDecoration shadowBox = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.all(Radius.circular(10)),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: Colors.black12,
        blurRadius: 4,
        offset: const Offset(0.0, 2),
      ),
    ],
  );

  static const BoxDecoration shadowBoxBottomRadius = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(10),
      bottomRight: Radius.circular(10),
    ),
    boxShadow: <BoxShadow>[
      BoxShadow(
        color: Colors.black12,
        blurRadius: 4,
        offset: const Offset(0.0, 2),
      ),
    ],
  );

  static const BoxDecoration boxDecorationBorderBottom = BoxDecoration(
      color: Colors.white,
      border: Border(
        bottom: BorderSide(width: 1.0, color: Color(0xFFdedede)),
      ));

  static const BoxDecoration boxDecorationBorderBottomGrey = BoxDecoration(
      color: Color(0xFFe9e9e9),
      border: Border(
        bottom: BorderSide(width: 1.0, color: Color(0xFFdedede)),
      ));

  // GRADIENT

  static const Gradient darkGradient = LinearGradient(
    begin: Alignment.topCenter,
    colors: [
      Color(0xFF343a40),
      Color(0xFF000000),
    ],
    stops: [0.2, 1.0],
  );

  static const Gradient successGradient = LinearGradient(
    colors: [
      Color(0xFF15AF2F),
      Color(0xFF5B951B),
    ],
    stops: [0.2, 1.0],
  );
}
