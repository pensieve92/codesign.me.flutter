import 'package:flutter/material.dart';

const Map<int, Map<String, Object>> weekdayObjects =
{
  1: {
    'text': {'en': 'mon', 'ko': '월'},
    'color': Colors.white,
  },
  2: {
    'text': {'en': 'tues', 'ko': '화'},
    'color': Colors.white,
  },
  3: {
    'text': {'en': 'wednes', 'ko': '수'},
    'color': Colors.white,
  },
  4: {
    'text': {'en': 'thurs', 'ko': '목'},
    'color': Colors.white,
  },
  5: {
    'text': {'en': 'fri', 'ko': '금'},
    'color': Colors.white,
  },
  6: {
    'text': {'en': 'satur', 'ko': '토'},
    'color': Colors.blue,
  },
  7: {
    'text': {'en': 'sunday', 'ko': '일'},
    'color': Colors.red,
  },
};

List<Map<String, Object>> weekdayConstants =
   [
    weekdayObjects[7]!, // 일요일
    weekdayObjects[1]!, // 월요일
    weekdayObjects[2]!, // 화요일
    weekdayObjects[3]!, // 수요일
    weekdayObjects[4]!, // 목요일
    weekdayObjects[5]!, // 금요일
    weekdayObjects[6]!, // 토요일
  ];



