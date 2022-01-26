import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final double? textSize;
  final TextStyle? style;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Decoration? decoration;
  final Color color;
  final Color backgroundColor;
  final TextOverflow? overflow;
  final int? maxLines;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final TextDecoration textDecoration;
  final double? containerWidth;

  const TextWidget(
      {Key? key,
      required this.text,
      this.textSize = 12,
      this.style,
      this.maxLines,
      this.padding = const EdgeInsets.all(0.0),
      this.margin = const EdgeInsets.all(0.0),
      this.color = Colors.black,
      this.decoration,
      this.overflow,
      this.containerWidth,
      this.fontWeight = FontWeight.normal,
      this.backgroundColor = Colors.transparent,
      this.textAlign = TextAlign.start,
      this.textDecoration = TextDecoration.none})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration,
      padding: padding,
      margin: margin,
      width: containerWidth,
      child: Text(
        text,
        overflow: overflow,
        style: style ?? TextStyle(
                decoration: textDecoration,
                fontSize: textSize,
                color: color,
                fontWeight: fontWeight,
              ),
        maxLines: maxLines,
        textAlign: textAlign,
      ),
    );
  }
}
