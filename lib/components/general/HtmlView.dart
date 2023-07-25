import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class HtmlView extends StatefulWidget {
  final htmlData;
  final double? size;
  final double lineHeight;
  HtmlView({Key? key, this.htmlData, this.size, required this.lineHeight})
      : super(key: key);

  @override
  _HtmlViewState createState() => _HtmlViewState();
}

class _HtmlViewState extends State<HtmlView> {
  @override
  Widget build(BuildContext context) {
    return Html(
      data: widget.htmlData,
      style: {
        "p": Style(
          padding: EdgeInsets.all(0),
          fontSize: FontSize(widget.size != null ? widget.size : 13),
          fontFamily: 'Urbanist',
          lineHeight:
              LineHeight(widget.lineHeight != null ? widget.lineHeight : 1),
          margin: EdgeInsets.only(bottom: 10),
        ),
        "h3": Style(
          fontFamily: 'Urbanist',
          fontSize: FontSize(widget.size != null ? widget.size! * 1.1 : 13),
          lineHeight:
              LineHeight(widget.lineHeight != null ? widget.lineHeight : 1),
          margin: EdgeInsets.only(bottom: 10),
        ),
        "h4": Style(
          fontFamily: 'Urbanist',
          fontSize: FontSize(widget.size != null ? widget.size! * 1.1 : 13),
          lineHeight:
              LineHeight(widget.lineHeight != null ? widget.lineHeight : 1),
          margin: EdgeInsets.only(bottom: 10),
        )
      },
      onImageError: (exception, stackTrace) {},
    );
  }
}
