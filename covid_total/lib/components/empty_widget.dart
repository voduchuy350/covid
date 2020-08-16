
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:covid_total/export.dart';

class MyEmptyWidget extends StatefulWidget {
  final String image ;
  final dynamic error;
  final Function onRetry;
  MyEmptyWidget({this.image,this.error,this.onRetry});
  @override
  _MyEmptyWidgetState createState() => _MyEmptyWidgetState();
}

class _MyEmptyWidgetState extends State<MyEmptyWidget> {
  @override
  Widget build(BuildContext context) {
    var error = "";

    if(widget.error is PlatformException) {
      error = widget.error.message;
    } else {
      error = widget.error.toString();
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

//          Image.asset(CovidImages.ic_virus_2,
//            height: 60,
//            width: 60,
//              color: CovidColors.color9E9E9E
//          ),
          SizedBox(height: 20,),
          CovidText(
              error,
            fontWeight: FontWeight.w500,
            size: 16,
            textAlign: TextAlign.center,
            color: CovidColors.color9E9E9E
          ),
          SizedBox(height: 20,),
          Container(
            width: 200,
            child: CovidButtonWidget(
              isSafeArea: false,
              title: "Thử lại",
              onTap: () {
                if (widget.onRetry != null) {
                  widget.onRetry();
                }
              },
            ),
          )
        ],
      ),

    );
  }
}
