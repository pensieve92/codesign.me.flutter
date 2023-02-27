import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:me/services/calendar/model/DocumentModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/calendar/model/DayModel.dart';

// TODO Store를 sigleton으로 관리하는 방법
// 사용할 변수를 late로 선언한다.
// store의 역할이 멀까? >> 변수를 가지고 있다.
// 화면과 데이터 분리 할 수 있다.
// TODO 새로 만들고 싶다..
class CalendarStore extends ChangeNotifier {

  // String selectedYearMonth = DateTime.now().year.toString() +  DateTime.now().month.toString().padLeft(2, '0');
  late String selectedYearMonth;
  int selectedDay = DateTime.now().weekday == 7 ? 0 : DateTime.now().weekday;
  // late Future<List<Day>> selectedMonthCalendar = Future(() => [Day(DateTime.now())]);
  late Future<List<DayModel>> selectedMonthCalendar = makeCalendar(); // TODO 얘가 watch로 걸려있어야 변경시, 리렌더링됨.!
  late Future<int> count = addCount();
  int cnt = 0;


  late int _cartSize;

  // 생성자 선언
  CalendarStore._privateConstructor(){
     selectedYearMonth = DateTime.now().year.toString() +  DateTime.now().month.toString().padLeft(2, '0');
     // selectedDay = DateTime.now().weekday == 7 ? 0 : DateTime.now().weekday;
     // selectedMonthCalendar = makeCalendar(); // TODO 얘가 watch로 걸려있어야 변경시, 리렌더링됨.!
     // Future<int> count = addCount();
     // cnt = 0;
    _cartSize = 0;
    cnt = 0;
  }

  // 인스턴스 할당
  static final CalendarStore _instance = CalendarStore._privateConstructor();

  factory CalendarStore(){
    return _instance;
  }

  // String selectedYearMonth = DateTime.now().year.toString() +  DateTime.now().month.toString().padLeft(2, '0');
  // int selectedDay = DateTime.now().weekday == 7 ? 0 : DateTime.now().weekday;
  // // late Future<List<Day>> selectedMonthCalendar = Future(() => [Day(DateTime.now())]);
  // late Future<List<DayModel>> selectedMonthCalendar = makeCalendar(); // TODO 얘가 watch로 걸려있어야 변경시, 리렌더링됨.!
  // late Future<int> count = addCount();
  // int cnt = 0;

  addCnt(){
    print('cnt : $cnt');
    cnt++;
    print('cnt : $cnt');
    notifyListeners();
  }

  /// test
  /// +1
  Future<int> addCount() async {
    var storage = await SharedPreferences.getInstance();
    int current = storage.getInt("count") ?? 0;
    int newValue = current + 1;
    storage.setInt('count', newValue);
    print('newValue : $newValue');
    return storage.getInt("count") as int;
  }

  Future<int?> addCount2() async {
    count = addCount();
    notifyListeners();
  }

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
    // selectedYearMonth = [year, month].join('.');
    selectedYearMonth = year.toString() + month.toString().padLeft(2, '0');
    notifyListeners();

    // 달력 만들기
    makeCalendar(year: year, month: month);

    // 상태값 감시
    notifyListeners();
  }

  /// 캘린더
  /// 선택된 날짜의 인텍스 저장
  setSelectedDay(int index) {
    print('setSelectedDay');
    selectedDay = index;

    // 상태값 감시
    notifyListeners();



  }

  getSelectedDay() {
    return selectedDay;
  }

  /// 캘린더
  /// 캘린더 조회
  /// 1.날짜 생성
  /// 2. Documnet 로컬 DB 조회
  Future<List<DayModel>> makeCalendar({int? year, int? month}) async {
    print("makeCalendar");

    // year, month 초기화
    year ??= DateTime.now().year;
    month ??= DateTime.now().month;

    var storage = await SharedPreferences.getInstance();

    List<DayModel> newCalendar = [];
    DateTime firstDay = DateTime(year, month, 1);
    int startWeekDay = firstDay.weekday;

    // Docs 있는 Days 가져오기
    // var dayList = getDaysAddedDocsTreeMonth(year, month, storage);

    // 캘린더 생성 + Doc 추가
    for (var day = 0; day < 42; day++) {
      // 첫번째주이고, 시작하는 요일이 startWeekDay인가?
      if (day < 7 && startWeekDay == day) {
        var initDay = DayModel(firstDay);
        // initDay.setDocs(dayList);
        newCalendar.add(initDay);
      } else {
        DateTime anotherDay = DateTime(year, month, 1).add(Duration(days: day - startWeekDay));
        var initDay = DayModel(anotherDay);
        // initDay.setDocs(dayList);
        newCalendar.add(initDay);
      }
    }
    print("calendar: $newCalendar");
    // print(newCalendar[12].docs);
    // print(newCalendar[12].docs[0].docDate);
    // selectedMonthCalendar = newCalendar as Future<List<Day>>;
    return newCalendar;
  }

  /// 캘린더
  /// 전월, 현재월, 다음월에 Docs 가져오기
  Map getDaysAddedDocsTreeMonth(int year, int month, SharedPreferences storage) {
    var days = {};
    var prevYearMonth = DateFormat('yyyyMM').format(DateTime(year, month - 1, 1));
    var nextYearMonth = DateFormat('yyyyMM').format(DateTime(year, month + 1, 1));

    var docDaysOfCurrentMonth = storage.getStringList(selectedYearMonth) ?? [];
    var docDaysOfPrevMonth = storage.getStringList(prevYearMonth) ?? [];
    var docDaysOfNextMonth = storage.getStringList(nextYearMonth) ?? [];
    var dayKeys = [...docDaysOfPrevMonth , ...docDaysOfCurrentMonth,  ...docDaysOfNextMonth];

    if(dayKeys.isNotEmpty){
      for (var dayKey in dayKeys) {// docsKey 조회
        var docKeys = storage.getStringList(dayKey) ?? [];
        if(docKeys.isNotEmpty){ // docs 조회
          var docList = [];
          for (var docKey in docKeys) {
            var doc = storage.getString(docKey) ?? '';
            if(doc.isNotEmpty) docList.add(DocumentModel.fromJson(jsonDecode(doc)));
          }
          days[dayKey] = docList;
        }
      }
    }
    return days;
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
    var document = DocumentModel.createTodo(
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
      storage.remove(element);
    });

    // TODO 저장후 다시 조회하기
    // selectedMonthCalendar = await Future(() => makeCalendar());
    selectedMonthCalendar = makeCalendar();
    // notifyListeners();
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
