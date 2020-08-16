
import 'package:intl/intl.dart';
import 'package:covid_total/constants.dart';

extension DateTimeParser on DateTime {
  /// convert 1 String có dạng Date về DateTime Object
  /// format là  1 string kiểu : 'yyyy-MM-dd HH:mm' , "dd/MM/yyyy"
  String toStringWithFormat({String format = Constants.baseDateFormat}) {
    return DateFormat(format).format(this.toLocal());
  }


  /// convert 1 time UTC về đúng giờ đó nhưng với local time
  /// hàm này ko cộng 7 tiếng giống hàm toLocal()
  DateTime convertUtcToLocal() {
    if (this.isUtc) {
      return DateTime(this.year,
          this.month,
          this.day,
          this.hour,
          this.minute,
          this.second,
          this.millisecond
      );
    }
    return this;
  }

}

