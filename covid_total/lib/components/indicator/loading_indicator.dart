import 'package:flutter/material.dart';
import 'package:covid_total/export.dart';

import 'ball_rotate_chase.dart';
import 'decorate.dart';
import 'dart:io';

class LoadingIndicator extends StatelessWidget {

  /// The color you draw on the shape.
  final Color color;

  LoadingIndicator({
    Key key,
    this.color = CovidColors.colorMain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecorateContext(
      decorateData: DecorateData(color: color),
      child: Container(width: 40, height: 40, child: BallRotateChase()),
    );
  }

/// return the animation indicator.

}