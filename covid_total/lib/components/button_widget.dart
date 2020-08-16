
import 'package:flutter/material.dart';

import '../export.dart';
import 'loading_dot_widget.dart';

class CovidButtonWidget extends StatefulWidget {
  CovidButtonType status;
  Function onTap;
  String title;
  bool isSafeArea;

  CovidButtonWidget(
      {this.status = CovidButtonType.enable,
        this.onTap,
        this.title,
        this.isSafeArea = true
      });

  @override
  _CovidButtonWidgetState createState() => _CovidButtonWidgetState();
}

class _CovidButtonWidgetState extends BaseState<CovidButtonWidget> {
  @override
  Widget build(BuildContext context) {
    Widget button = RaisedButton(
      onPressed: widget.status == CovidButtonType.enable ? widget.onTap : null,
      disabledColor: Color(0xffAA947F),
      color: CovidColors.colorMain,
      padding: EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)),
      child: Container(
        width: double.infinity,
        height: scaleWidth(45),
        child: Align(
          alignment: Alignment.center,
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 200),
            transitionBuilder: (Widget child, Animation<double> animation) =>
                ScaleTransition(
                  child: child,
                  scale: animation,
                ),
            child: widget.status != CovidButtonType.loading
                ? CovidText(
                widget.title,
                fontWeight: FontWeight.bold,
                size: 14,
                color: Colors.white
            ) :

            LoadingDotWidget(
              color: CovidColors.colorMain,
              size: 15.0,
            )
            ,
          ),
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10))),
      ),
    );

    Widget child = Container(
      child: button ,
    );

    return widget.isSafeArea ? SafeArea(
      child: child,
    ) : child;

  }
}

enum CovidButtonType { loading, disable, enable }

