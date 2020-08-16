
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:covid_total/constants.dart';
import 'package:covid_total/resources/colors.dart';
import 'package:covid_total/utils/base/base.dart';


class CovidText extends StatefulWidget {
  final String text;
  final double size;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final int maxLines;
  final TextStyle textStyle;
  final double letterSpacing;
  final bool isDiscountPrice;

  const CovidText(this.text,
      {Key key,
        this.size,
        this.fontWeight,
        this.color = CovidColors.colorMain,
        this.textStyle,
        this.textAlign,
        this.overflow,
        this.isDiscountPrice = false,
        this.maxLines,
        this.letterSpacing})
      : super(key: key);

  @override
  _CovidTextState createState() => _CovidTextState();
}

class _CovidTextState extends BaseState<CovidText> {
  @override
  Widget build(BuildContext context) {
    final DefaultTextStyle defaultTextStyle = DefaultTextStyle.of(context);
    var _text = Text(
      widget.text ?? "",
      textScaleFactor: 1.0,
      textAlign: widget.textAlign ?? defaultTextStyle.textAlign,
      overflow: widget.overflow ?? defaultTextStyle.overflow,
      maxLines: widget.maxLines ?? defaultTextStyle.maxLines,

      style: TextStyle(
          fontSize: widget.size != null
              ? scaleWidth(widget.size)
              : scaleWidth(14),
          fontFamily: Constants.fontFamily,
          letterSpacing: widget.letterSpacing ?? 0,
          color: widget.color,
          decoration: widget.isDiscountPrice
              ? TextDecoration.lineThrough
              : TextDecoration.none,
          fontWeight: widget.fontWeight)
          .merge(widget.textStyle),
    );
    return _text;
  }
}

TextStyle styleCovidText = TextStyle(
  fontFamily: Constants.fontFamily,
  fontSize: 14,
  color: CovidColors.colorMain,
);


