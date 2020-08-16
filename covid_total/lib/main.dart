import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:covid_total/export.dart';
import 'package:covid_total/screen/home/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
//    Intl.defaultLocale = "vi_VN";
//    initializeDateFormatting("vi_VN");
//    Intl.defaultLocale = "vi";
//    initializeDateFormatting("vi");

    return MaterialApp(
      title: 'Covid Total',
      theme: ThemeData(
        backgroundColor: CovidColors.colorF1EFEC,
        scaffoldBackgroundColor: CovidColors.colorF1EFEC
      ),
      home: HomeScreen.newInstance(),
    );
  }
}
