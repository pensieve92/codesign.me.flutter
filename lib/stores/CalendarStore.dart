import 'package:flutter/material.dart';

class CalendarStore extends ChangeNotifier {
  var selectedYearMonth;

  //현재 연월로 초기화
  CalendarStore(): selectedYearMonth = [DateTime.now().year, DateTime.now().month].join('.') ;

  setYearMonth(String? value) {
    selectedYearMonth = value;
    notifyListeners();
  }

  setToday(){
    DateTime now = DateTime.now();
    setDay(now.year, now.month, now.day);
  }

  setDay(int year, int month, int day){
    selectedYearMonth = [year, month].join('.');
    String weekday = getWeekday(year, month, day, null);
    notifyListeners();

    print('setDay $selectedYearMonth$day : $weekday');
  }


  /**
   * 요일 조회
   */
  getWeekday(int year, int month, int day, String? language){
    return weekday[DateTime(year, month, day).weekday]![language ?? 'ko'] ?? 'Error';
  }

}

const weekday = {
  1: {'en': 'monday', 'ko': '월요일'},
  2: {'en': 'tuesday', 'ko': '화요일'},
  3: {'en': 'wednesday', 'ko': '수일'},
  4: {'en': 'thursday', 'ko': '목요일'},
  5: {'en': 'friday', 'ko': '금요일'},
  6: {'en': 'saturday', 'ko': '토요일'},
  7: {'en': 'sunday', 'ko': '월요일'},
};