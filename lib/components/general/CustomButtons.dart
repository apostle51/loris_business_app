import 'package:flutter/material.dart';
import '/theme/appColors.dart';

class CustomBigButton extends StatelessWidget {
  final GestureTapCallback? onPressed;
  final String? title;
  final bool? loader;
  final Color? color;
  final Color? textColor;
  final IconData? icon;

  CustomBigButton(
      {@required this.onPressed,
      this.title,
      @required this.loader,
      this.icon,
      this.color,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size.fromHeight(50),
        primary: color ?? AppColors.dark,
        onPrimary: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))),
      ),
      child: loader!
          ? Container(
              width: 30,
              height: 30,
              padding: EdgeInsets.all(3),
              child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.white)),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title ?? '',
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: textColor ?? AppColors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1),
                ),
                SizedBox(
                  width: 4,
                ),
                if (icon != null)
                  Icon(
                    icon,
                    color: textColor ?? AppColors.white,
                  )
              ],
            ),
    );
  }
}
