import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:me/services/calendar/model/DocType.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:me/services/calendar/model/Document.dart';
import 'package:me/services/calendar/model/Weekday.dart';

import '../services/calendar/model/Day.dart';

class CalendarStore extends ChangeNotifier {
  String selectedYearMonth;
  int selectedDay;
  List<Day> selectedMonthCalendar;

  //현재 연월로 초기화
  CalendarStore()
      : selectedYearMonth = '',
        selectedDay = 0,
        selectedMonthCalendar = [] {
    this.selectedDay = DateTime.now().weekday == 7 ? 0 : DateTime.now().weekday;
    this.selectedYearMonth =
        [DateTime.now().year, DateTime.now().month].join('.');
    this.selectedMonthCalendar =
        makeCalendar(DateTime.now().year, DateTime.now().month);
  }

  setYearMonth(String value) {
    selectedYearMonth = value;
    notifyListeners();
  }

  setToday() {
    DateTime now = DateTime.now();
    setDay(now.year, now.month, now.day);
  }

  setDay(int year, int month, int day) {
    // AppBar 상단에 선택된 년월
    selectedYearMonth = [year, month].join('.');

    // 달력 만들기
    makeCalendar(year, month);

    // 상태값 감시
    notifyListeners();
  }

  setSelectedDay(int index) {
    this.selectedDay = index;

    // 상태값 감시
    notifyListeners();
  }

  List<Day> makeCalendar(int year, int month) {
    List<Day> calendar = [];
    DateTime firstDay = DateTime(year, month, 1);
    int startWeekDay = firstDay.weekday;

    for (var day = 0; day < 42; day++) {
      // 첫번째주이고, 시작하는 요일이 startWeekDay인가?
      if (day < 7 && startWeekDay == day) {
        calendar.add(Day(firstDay));
      } else {
        DateTime anotherDay =
            DateTime(year, month, 1).add(Duration(days: day - startWeekDay));
        calendar.add(Day(anotherDay));
      }
    }

    return calendar;
  }

  // TODO Parameter 수정될 듯!
  // 1. 일반 text 저장
  // TODO 2. type도 지정해야 함 >>> 상세 팝업 개발시
  // TODO 3. 추가, 수정, 삭제 여부 포함 되어야 할듯 >>> 상세 팝업 개발시
  void saveDoc(String doc) async {
    var storage = await SharedPreferences.getInstance();

    // 생성일 Formating
    var nowDate = DateFormat('yyyy_MM_dd_HH_mm_ss').format(DateTime.now());

    var year = selectedMonthCalendar[selectedDay].year.toString();
    var month = selectedMonthCalendar[selectedDay].month.toString();
    var day = selectedMonthCalendar[selectedDay].day.toString();
    var yearMonth = year + month;
    var yearMonthDay = year + month + day;

    // TODO 타입별로 Document 생성
    var document = Document.createTodo(
      docDate: yearMonthDay,
      docContent: doc,
      createDate: nowDate,
    );

    // monthKey 저장
    saveParentKey(storage, yearMonth, yearMonthDay);

    // DayKey 저장
    saveParentKey(storage, yearMonthDay, document.docId);

    // store doc 여부 확인 NO, 바로 업데이트!
    var json = document.toJson();
    // Document 저장
    storage.setString(document.docId, jsonEncode(json));


    // FIXME 저장 확인
    var keys = storage.getKeys();
    keys.forEach((element) {
      print(element);
      var value = storage.get(element);
      print(value.toString());
      storage.remove(element);
    });


  }

  // document를 저장하기전에 day, month를 parentKey로 저장
  // 월 : [날짜, ...]
  // 202212 : [20221201, 20221208]
  // 날짜 : [docId, ...]
  // 20221201 : [20221201-TODO-2022_12_01_14_02_22, ]
  void saveParentKey(SharedPreferences storage, String yearMonthDay, String docId) {
    bool hasDay = storage.containsKey(yearMonthDay);
    List<String> docs = [];
    docs = (hasDay ? storage.getStringList(yearMonthDay) : [])!;
    docs.add(docId);
    storage.setStringList(yearMonthDay, docs);
  }
}
