import 'package:flutter/material.dart';
import 'package:me/services/calendar/model/WeekDayMap.dart';

class Weekday {
  int value = 1;      // 1 ~ 7 : 월 ~ 일
  String name = '월'; // 월 ~ 일
  Color color = Colors.white;


  Weekday(int value) {
    this.value = value;
    this.name  = (weekdayMap[value]!['name'] as Map)['ko'];
    this.color =  weekdayMap[value]!['color'] as Color;
  } // Color
}


/**
 * 달력 요일 헤더
 */
List<Weekday> getWeekdays() {
  return [
            Weekday(7), // 일요일
            Weekday(1), // 월요일
            Weekday(2), // 화요일
            Weekday(3), // 수요일
            Weekday(4), // 목요일
            Weekday(5), // 금요일
            Weekday(6), // 토요일
        ];
}
