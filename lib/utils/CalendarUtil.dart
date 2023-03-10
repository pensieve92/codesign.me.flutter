import 'package:flutter/material.dart';

import '../constrants/calendar/CalendarConstant.dart';

class CalendarUtil {

  /// @return 2023.02
  static String getYYYYMM(DateTime dateTime) {
    StringBuffer YYYYMM = StringBuffer();
    YYYYMM.write(dateTime.year.toString());
    YYYYMM.write(".");
    YYYYMM.write(dateTime.month.toString().padLeft(2, '0'));

    return YYYYMM.toString();
  }

  /// @return 2023.02.11
  static String getYYYYMMDD(DateTime dateTime) {
    StringBuffer YYYYMMDD = StringBuffer();
    YYYYMMDD.write(dateTime.year.toString());
    YYYYMMDD.write(dateTime.month.toString().padLeft(2, '0'));
    YYYYMMDD.write(dateTime.day.toString().padLeft(2, '0'));

    return YYYYMMDD.toString();
  }

  /// 다음달
  static DateTime getNextMonth(DateTime dateTime){
    return DateTime(dateTime.year, dateTime.month + 1, 1);
  }

  /// 이전달
  static DateTime getPreMonth(DateTime dateTime){
    return DateTime(dateTime.year, dateTime.month - 1, 1);;
  }

  /// getToday
  /// 오늘 - 시간 초기화
  static DateTime getToday(){
    var now =  DateTime.now();
    int year = now.year;
    int month = now.month;
    int day = now.day;
    return DateTime(year, month, day);
  }

  /// 캘린더 생성
  static List<DateTime> createCalendar(DateTime dateTime){
    int year = dateTime.year;
    int month = dateTime.month;
    int day = 1;
    DateTime firstDay = DateTime(year, month, day);
    int startWeekday = firstDay.weekday;

    List<DateTime> calendar = [];
    for (var i = 0; i < 42; i++) {
      DateTime day = DateTime(year, month, 1).add(Duration(days: i - startWeekday));
      calendar.add(day);
    }

    return calendar;
  }

  /// 캘린더 그리드 헤더
  static List<Map<String, Object>> getWeekDays(){
    return weekdayConstants;
  }

  @Deprecated("V4 변경완료시, 제거 예정")
  /// 캘린더 그리드 헤더 (월~일 텍스트 추출)
  static String getWeekDayText(int i){
    return (weekdayConstants[i]['text'] as Map)['ko'];
  }

  @Deprecated("V4 변경완료시, 제거 예정")
  /// 캘린더 그리드 헤더 (월~일 Color 추출)
  static Color getWeekDayColor(int i){
    return (weekdayConstants[i]['color'] as Color);
  }


}
