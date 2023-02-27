import 'package:flutter/material.dart';

class CalendarUtil {

  /// @return 2023.02
  static String getYYYYMM(DateTime dateTime) {
    StringBuffer YYYYMM = StringBuffer();
    YYYYMM.write(dateTime.year.toString());
    YYYYMM.write(".");
    YYYYMM.write(dateTime.month.toString().padLeft(2, '0'));

    return YYYYMM.toString();
  }

  /// 다음달
  static DateTime getNextMonth(DateTime dateTime){
    return DateTime(dateTime.year, dateTime.month + 1, 1);
  }

  /// 이전달
  static DateTime getPreMonth(DateTime dateTime){
    return DateTime(dateTime.year, dateTime.month - 1, 1);;
  }

}
