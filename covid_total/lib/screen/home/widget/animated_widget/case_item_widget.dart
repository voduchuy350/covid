

import 'dart:math';

import 'package:animator/animator.dart';
import 'package:flutter/material.dart';

import '../../../../export.dart';

class CaseItemWidget extends StatefulWidget {

  Color color ;
  CaseItemWidget(this.color);

  @override
  _CaseItemWidgetState createState() => _CaseItemWidgetState();
}

class _CaseItemWidgetState extends BaseState<CaseItemWidget> {
  bool _startCircle2 = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _startCircle2 = true;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      child: Stack(
        children: <Widget>[

          !_startCircle2 ? Container() :
          Animator(
            tweenMap: {
              "opacity" :  Tween<double>(begin: 1, end: 0),
              "size" :  Tween<double>(begin: 10, end: 40),
            },
            duration: Duration(milliseconds: 1000),
            repeats: 0,
            builder: (cxt,anim,child) =>
                Center(
                  child: Opacity(
                    opacity: anim.getAnimation("opacity").value,
                    child: Container(
                      height: anim.getAnimation("size").value,
                      width:  anim.getAnimation("size").value,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: widget.color ,//.withAlpha(100),
                          borderRadius: BorderRadius.all(Radius.circular(anim.getAnimation("size").value/2))
                      ),
                    ),
                  ),
                ),
          ),

          Animator(
            tweenMap: {
             "opacity" :  Tween<double>(begin: 1, end: 0),
              "size" :  Tween<double>(begin: 10, end: 40),
            },
            duration: Duration(milliseconds: 1000),
            repeats: 0,
            builder: (cxt,anim,child) =>
                Center(
                  child: Opacity(
                    opacity: anim.getAnimation("opacity").value,
                    child: Container(
                      height: anim.getAnimation("size").value,
                      width:  anim.getAnimation("size").value,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: widget.color ,//.withAlpha(100),
                          borderRadius: BorderRadius.all(Radius.circular(anim.getAnimation("size").value/2))
                      ),
                    ),
                  ),
                ),
          ),

          Center(
            child: Container(
              height: 16,
              width: 16,
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.all(Radius.circular(8))
              ),
            ),
          )

        ],
      ),
    ) ;




  }
}
