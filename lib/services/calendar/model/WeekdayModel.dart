import 'package:flutter/material.dart';
import 'package:me/services/calendar/model/WeekDayMap.dart';

class WeekdayModel {
  int value = 1;      // 1 ~ 7 : 월 ~ 일
  String name = '월'; // 월 ~ 일
  Color color = Colors.white;


  WeekdayModel(int value) {
    value = value;
    name  = (weekdayMap[value]!['name'] as Map)['ko'];
    color =  weekdayMap[value]!['color'] as Color;
  } // Color
}


/**
 * 달력 요일 헤더
 */
List<WeekdayModel> getWeekdays() {
  return [
            WeekdayModel(7), // 일요일
            WeekdayModel(1), // 월요일
            WeekdayModel(2), // 화요일
            WeekdayModel(3), // 수요일
            WeekdayModel(4), // 목요일
            WeekdayModel(5), // 금요일
            WeekdayModel(6), // 토요일
        ];
}
