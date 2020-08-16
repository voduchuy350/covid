

import 'package:flutter/material.dart';
import 'package:covid_total/components/covid_text.dart';

import '../export.dart';

class CovidTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText ;
  final FocusNode focusNode;
  final Widget suffixIcon;
  final bool isPassword ;
  final Function(String) onSubmit;
  final TextInputAction textInputAction;


  CovidTextField({this.controller,
  this.hintText,
    this.textInputAction = TextInputAction.done,
  this.focusNode,
  this.suffixIcon,
    this.onSubmit,
    this.isPassword  = false});
  


  @override
  _CovidTextFieldState createState() => _CovidTextFieldState();
}

class _CovidTextFieldState extends BaseState<CovidTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(30))
      ),
      child: TextField(
        textInputAction: widget.textInputAction,
        onSubmitted: (value) {
          if (widget.onSubmit != null) {
            widget.onSubmit(value);
          }
        },
        obscureText: widget.isPassword,
          controller: widget.controller,
          focusNode: widget.focusNode,
          style: styleCovidText.copyWith(
              fontSize: scaleWidth(16),
              color: Colors.black,
              backgroundColor: Colors.white),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            hintText: widget.hintText,
            fillColor: Colors.white,
            hintStyle: styleCovidText.copyWith(
              fontWeight: FontWeight.w300,
                fontSize: scaleWidth(15),
                color: CovidColors.color9E9E9E),
            enabledBorder: OutlineInputBorder(
              //borderSide: BorderSide(color: AssetsColor.colorGreyLineE9EAED),
              borderRadius: BorderRadius.all(Radius.circular(30)),
              borderSide: BorderSide(color: CovidColors.colorD7CCC8, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: CovidColors.colorMainMedium, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            suffixIcon: widget.suffixIcon != null ?
            widget.suffixIcon
                : null
          )),
    );
  }
}
