import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GetSVGIcon extends StatelessWidget {
  final Color? color;
  final String? icon;
  final double? size;
  const GetSVGIcon({Key? key, this.color, this.icon, this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String assetName = 'assets/images/svgicons/' + icon! + '.svg';
    return SvgPicture.asset(assetName,
        width: size! * 1.6, color: color, semanticsLabel: 'A red up arrow');
  }
}
