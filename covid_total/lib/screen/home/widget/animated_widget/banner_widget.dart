

import 'dart:math';

import 'package:animator/animator.dart';
import 'package:flutter/material.dart';

import '../../../../export.dart';

class BannerWidget extends StatefulWidget {
  @override
  _BannerWidgetState createState() => _BannerWidgetState();
}

class _BannerWidgetState extends BaseState<BannerWidget> {
  @override
  Widget build(BuildContext context) {
    return Animator(
      tween: Tween<double>(begin: 0,end:  (pi / 180 * 10)),
      duration: Duration(seconds: 1),
    //  repeats: 0,
      cycles: 0,
      builder: (cxt,anim,child) => Transform.rotate(angle: anim.value,
        alignment: Alignment.bottomRight,
        child:   Image.asset(
          CovidImages.ic_banner,
          height: screenSize.height * 0.4,
          width: screenSize.width * 1.1,
        ),
      ),

    ) ;




  }
}
