




import 'package:flutter/material.dart';
import 'package:covid_total/export.dart';

import 'indicator/loading_indicator.dart';

Widget LoadingWidget({Color color = CovidColors.colorMain}) {
  return Center(child: LoadingIndicator(color: color,));
}
