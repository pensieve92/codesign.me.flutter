import 'package:flutter/material.dart';
import 'package:me/services/calendar/model/Weekday.dart';

import '../services/calendar/model/Day.dart';

class CalendarStore extends ChangeNotifier {
  String selectedYearMonth;
  List<Day> selectedMonthCalendar;

  //현재 연월로 초기화
  CalendarStore(): selectedYearMonth = '', selectedMonthCalendar =[] {
    this.selectedYearMonth = [DateTime.now().year, DateTime.now().month].join('.');
    this.selectedMonthCalendar = makeCalendar(DateTime.now().year, DateTime.now().month);
  }

  setYearMonth(String value) {
    selectedYearMonth = value;
    notifyListeners();
  }

  setToday(){
    DateTime now = DateTime.now();
    setDay(now.year, now.month, now.day);
  }

  setDay(int year, int month, int day){
    // AppBar 상단에 선택된 년월
    selectedYearMonth = [year, month].join('.');

    // 달력 만들기
    makeCalendar(year, month);

    // 상태값 감시
    notifyListeners();
  }

  List<Day> makeCalendar(int year, int month){
    List<Day> calendar = [];
    DateTime firstDay = DateTime(year, month, 1);
    int startWeekDay = firstDay.weekday;

    for(var day=0; day < 42; day++){
      // 첫번째주이고, 시작하는 요일이 startWeekDay인가?
      if(day < 7 && startWeekDay == day){
        calendar.add(Day(firstDay));
      }else{
        DateTime anotherDay = DateTime(year, month, 1).add(Duration(days: day - startWeekDay));
        calendar.add(Day(anotherDay));
      }
    }

    return calendar;
  }

}

