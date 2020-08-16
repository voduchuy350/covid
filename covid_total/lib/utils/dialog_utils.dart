


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covid_total/components/covid_text.dart';
import 'package:covid_total/export.dart';

showCovidDialog({@required BuildContext context,
  String title ,
  String content,
  String cancelTitle ,
  Function cancelAction,
  String okTitle ,
  Function okAction,
  String optionButtonTitle ,
  Function optionButtonAction
}) {
  showDialog(context: context,
    barrierDismissible: false,
    builder: (ctx) {
    return AlertDialog(

      title: isNotEmpty(title) ? CovidText(
        title,
        fontWeight: FontWeight.bold,
        size: 18,
        color: Colors.black,
      ) : null,
      content: isNotEmpty(content) ? CovidText(
        content,
        fontWeight: FontWeight.normal,
        size: 18,
        color: Colors.black,
      ) : null,
      actions: <Widget>[
            isNotEmpty(cancelTitle)
                ? FlatButton(
                    onPressed: () {
                      if (cancelAction != null) {
                        cancelAction();
                      }
                    },
                    child: CovidText(
                      cancelTitle,
                      fontWeight: FontWeight.normal,
                      size: 18,
                      color: CovidColors.color9E9E9E,
                    ))
                : null,

            /// sub button
            isNotEmpty(optionButtonTitle)
                ? FlatButton(
                    onPressed: () {
                      if (optionButtonAction != null) {
                        optionButtonAction();
                      }
                    },
                    child: CovidText(
                      optionButtonTitle,
                      fontWeight: FontWeight.bold,
                      size: 18,
                      color: CovidColors.colorMain,
                    ))
                : null,

            /// ok button
            FlatButton(
              onPressed: () {
                if (okAction != null) {
                  okAction();
                } else {
                  Navigator.pop(context);
                }
              },
              child: CovidText(
                isNotEmpty(okTitle) ? okTitle : "OK",
                fontWeight: FontWeight.bold,
                size: 18,
                color: CovidColors.colorMain,
              ),
            ),

          ],
        );
      }) ;

}