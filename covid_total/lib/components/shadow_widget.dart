
import 'package:flutter/material.dart';

class ShadowWidget extends StatefulWidget {
  final Widget child;
  /// màu của shadow
  final Color shadowColor;
  final double cornerRadius ;
  /// độ mịn , càng cao thì càng mịn
  final double blurRadius;
  /// độ lan cuả bóng ra xung quanh, càng cao càng tản ra xa
  final double spreadRadius ;
  /// độ dịch theo chiều ngang của shadow
  final double horizontalOffset ;
  /// độ dịch theo chiều dọc của shadow
  final double verticalOffset ;
  /// màu nền của widget
  final Color backgroundColor;
  
  ShadowWidget({
    Key key,
    @required this.child,
    this.shadowColor,
//    this.blurRadius = 4.0,
//    this.spreadRadius = 2.0,
//    this.horizontalOffset = 0.5,
//    spreadRadius: 5,
//    blurRadius: 20,
//    verticalOffset: 0.5,

    this.spreadRadius = 5,
    this.blurRadius = 20,
    this.verticalOffset = 0.5,
    this.horizontalOffset = 0.5,
    this.backgroundColor = Colors.white,
    this.cornerRadius = 2}): super(key: key)  ;

//  const ViewSeatWidget({
//    Key key,
//    this.data,
//    this.onShowMaxSeat
//  }) : super(key: key);

  @override
  _ShadowWidgetState createState() => _ShadowWidgetState();
}

class _ShadowWidgetState extends State<ShadowWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        color: widget.backgroundColor,
        boxShadow: [
          BoxShadow(
            color: widget.shadowColor ?? Color(0xffe9e9e9),
            //color: widget.shadowColor ?? Colors.black12,
            blurRadius:  widget.blurRadius  , // has the effect of softening the shadow
            spreadRadius: widget.spreadRadius , // has the effect of extending the shadow
            offset: Offset(
              widget.horizontalOffset, // horizontal
              widget.verticalOffset, // vertical
            ),
          )
        ],
        borderRadius: new BorderRadius.all(Radius.circular(widget.cornerRadius)),
      ),
      child: widget.child,
    );
  }
}
