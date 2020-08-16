

import 'dart:math';

import 'package:animator/animator.dart';
import 'package:flutter/material.dart';

import '../../../../export.dart';

class Virus2Widget extends StatefulWidget {
  @override
  _Virus2WidgetState createState() => _Virus2WidgetState();
}

class _Virus2WidgetState extends BaseState<Virus2Widget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      child: Stack(
        children: <Widget>[
          Image.asset(
            CovidImages.ic_virus_6,
            height: 70,
            width: 70,
          ),
          Positioned(
            top: 5,
            right: 0,
            left: 0,
//            child: Center(
//              child: Container(
//                  height: 70,
//                  width: 70,
//                  alignment: Alignment.center,
//                  child: Image.asset(
//                  CovidImages.ic_eyes_1,
//                  fit: BoxFit.fill,
//                  height: 20,
//                  width: 40,
//                ),
//
//              ),
//            )


            child : Animator(
              tween: Tween<double>(begin: 20, end: 0),
              duration: Duration(milliseconds: 500),
              //  repeats: 0,
              cycles: 0,
              builder: (cxt, anim, child) => Container(
                height: 70,
                width: 70,
                alignment: Alignment.center,
                child: Image.asset(
                  CovidImages.ic_eyes_1,
                  fit: BoxFit.fill,
                  height: anim.value,
                  width: 40,
                ),
              ),
            ),
          )
        ],
      ),
    );

  }
}
