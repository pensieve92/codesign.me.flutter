import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:me/services/calendar/model/Document.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/calendar/model/Day.dart';

class CalendarStore extends ChangeNotifier {
  String selectedYearMonth =
      [DateTime.now().year, DateTime.now().month].join('.');
  int selectedDay = DateTime.now().weekday == 7 ? 0 : DateTime.now().weekday;
  // late Future<List<Day>> selectedMonthCalendar = Future(() => [Day(DateTime.now())]);
  late Future<List<Day>> selectedMonthCalendar = makeCalendar();

  /// 캘린더
  /// 연, 월 선택
  setYearMonth(String value) {
    selectedYearMonth = value;
    notifyListeners();
  }

  /// 캘린더
  /// 오늘날짜 선택
  setToday() {
    DateTime now = DateTime.now();
    setDay(now.year, now.month, now.day);
  }

  /// 캘린더
  /// 날짜 선택
  setDay(int year, int month, int day) {
    // AppBar 상단에 선택된 년월
    selectedYearMonth = [year, month].join('.');

    // 달력 만들기
    makeCalendar(year: year, month: month);

    // 상태값 감시
    notifyListeners();
  }

  /// 캘린더
  /// 선택된 날짜의 인텍스 저장
  setSelectedDay(int index) {
    selectedDay = index;

    // 상태값 감시
    notifyListeners();
  }

  /// 캘린더
  /// 캘린더 조회
  /// 1.날짜 생성
  /// 2. Documnet 로컬 DB 조회
  Future<List<Day>> makeCalendar({int? year, int? month}) async {
    print("makeCalendar");

    // year, month 초기화
    year ??= DateTime.now().year;
    month ??= DateTime.now().month;

    var storage = await SharedPreferences.getInstance();

    List<Day> newCalendar = [];
    DateTime firstDay = DateTime(year, month, 1);
    int startWeekDay = firstDay.weekday;

    // TODO Day객체에 List<Document> 넣어주기
    var docsOfMonth = [];

    // TODO 얘를 한번 가져오고 + 전월, 다음월것도 가져온다음에 합치기
    // 이전, 다음 월 추출하기
    var prevYearMonth =
        DateFormat('yyyyMM').format(DateTime(year, month - 1, 1));
    var nextYearMonth =
        DateFormat('yyyyMM').format(DateTime(year, month + 1, 1));

    var daysOfMonth = storage.getStringList(selectedYearMonth);
    var daysOfPrevMonth = storage.getStringList(prevYearMonth);
    var daysOfNextMonth = storage.getStringList(nextYearMonth);

    // for (var day in daysOfMonth!) {
    //
    //   var docsOfDay = storage.getStringList(day);
    //   for (var doc in docsOfDay!) {
    //     //TODO 이부분은 아래 for문에서 추가해주자
    //     docsOfMonth.add(Document.fromJson(jsonDecode(storage.getString(doc)!)));
    //   }
    // }
    // print('docsOfMonth: $docsOfMonth');

    for (var day = 0; day < 42; day++) {
      // 첫번째주이고, 시작하는 요일이 startWeekDay인가?
      if (day < 7 && startWeekDay == day) {
        newCalendar.add(Day(firstDay));
      } else {
        DateTime anotherDay =
            DateTime(year, month, 1).add(Duration(days: day - startWeekDay));
        newCalendar.add(Day(anotherDay));
      }
    }
    print("calendar: $newCalendar");
    // selectedMonthCalendar = newCalendar as Future<List<Day>>;
    return newCalendar;
  }

  // TODO Parameter 수정될 듯!
  // 1. 일반 text 저장
  // TODO 2. type도 지정해야 함 >>> 상세 팝업 개발시
  // TODO 3. 추가, 수정, 삭제 여부 포함 되어야 할듯 >>> 상세 팝업 개발시
  /// 캘린더
  /// Document 저장
  /// type: TODO,
  void saveDoc(String doc) async {
    var storage = await SharedPreferences.getInstance();

    // 생성일 Formating
    var nowDate = DateFormat('yyyy_MM_dd_HH_mm_ss').format(DateTime.now());

    var currentCalendar = await selectedMonthCalendar;
    var year = currentCalendar[selectedDay].year.toString();
    var month = currentCalendar[selectedDay].month.toString().padLeft(2, '0');
    var day = currentCalendar[selectedDay].day.toString().padLeft(2, '0');

    var yearMonth = year + month;
    var yearMonthDay = year + month + day;

    // Todo-Doc 생성
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
      print("key: $element");
      var value = storage.get(element);
      print(value.toString());
      // 제거
      // storage.remove(element);
    });
  }

  /// 캘린더
  /// Document Key저장
  /// document를 저장하기전에 day, month를 parentKey로 저장
  /// 월 : [날짜, ...]
  /// ex >>> 202212 : [20221201, 20221208]
  /// 날짜 : [docId, ...]
  /// ex >>> 20221201 : [20221201-TODO-2022_12_01_14_02_22, ]
  void saveParentKey(SharedPreferences storage, String parentKey, String childKey) {
    bool hasKey = storage.containsKey(parentKey);
    List<String> childKeys = storage.getStringList(parentKey) ?? [];

    if(hasKey){ // 키가 존재할 경우
      // child키가 중복으로 존재하는지
      bool dupChildKey = childKeys.contains(childKey);
      if(!dupChildKey){// child 키가 중복이 아닐 경우
        // 기존에 배열에 add후 저장하기
        childKeys.add(childKey);
        storage.setStringList(parentKey, childKeys);
      }
    }else{ // 키가 존재하지 않을 경우
      // 빈 배열에 add후 저장
      childKeys.add(childKey);
      storage.setStringList(parentKey, childKeys);
    }
  }
}
