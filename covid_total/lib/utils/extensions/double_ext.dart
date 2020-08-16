


import 'package:intl/intl.dart';

import '../../export.dart';


extension DoubleParser on double {
  String toCurrencyFormat({String language = "vi_VN"}) { // us_EN
    //final format = new NumberFormat.currency(locale: "vi_VN", symbol: language == "vi_VN" ?  "₫" : "USD");
    final f = new NumberFormat("#,##0.#", language);
    return f.format(this) + (language == "vi_VN" ? " đ" : " USD");
  }



  String minutesToTimeDisplay() { // us_EN

    final days = this ~/ (24*60);
    int minutes = (days > 0 ? this - days*24*60 : this).toInt();
    final hours =  minutes~/60;
    minutes =  hours > 0 ? minutes - hours*60 : minutes;

    var result = "";

    if (days > 0 ) {
      var suffix = "ngày";
      result = "$days $suffix";
    }

    if (hours > 0 || isNotEmpty(result)) {
      var suffix = "giờ";
      result += "${ result.isEmpty ? "" : " "}$hours $suffix";
    }
    if (minutes > 0 || isEmpty(result)) {
      var suffix = "phút";
      result += "${ result.isEmpty ? "" : " "}$minutes $suffix";
    }

    return result;
  }

}


extension IntEx on int {
  String toFormatNumber() { // us_EN

    final f = new NumberFormat("#,##0.#", "vi_VN");
    return f.format(this) ;
  }

}