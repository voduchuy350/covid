

import 'dart:math';

import 'package:animator/animator.dart';
import 'package:flutter/material.dart';

import '../../../../export.dart';

class Virus1Widget extends StatefulWidget {
  @override
  _Virus1WidgetState createState() => _Virus1WidgetState();
}

class _Virus1WidgetState extends BaseState<Virus1Widget> {
  @override
  Widget build(BuildContext context) {
    return Animator(
      tween: Tween<double>(begin: 40,end: 70),
      duration: Duration(milliseconds: 500),
      //  repeats: 0,
      cycles: 0,
      builder: (cxt,anim,child) =>
          Container(
            height: 70,
            width: 70,
            alignment: Alignment.center,
            child:  Image.asset(
              CovidImages.ic_virus_3,
              height: anim.value,
              width: anim.value,
            ),
          ),
    ) ;




  }
}
