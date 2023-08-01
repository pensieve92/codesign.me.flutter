import 'dart:convert';

import 'package:me/services/calendar/model/DocumentModel.dart';
import 'package:me/services/calendar/model/WeekdayModel.dart';
import 'package:me/stores/CalendarStore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DayModel {
  late DateTime dateTime; // defualt 값
  late int year; // 년
  late int month; // 월
  late int day; // 일
  late WeekdayModel weekday; // 요일
  late List<DocumentModel> docs; // doc 리스트
  late bool isCurMonth; // 현재월여부
  late String dateName; // 공휴일 명
  late String isHolyDay; // 공휴일 여부

  /// 생성자
  DayModel(DateTime dateTime) : dateTime = DateTime.now() {
    dateTime = dateTime;
    year = dateTime.year;
    month = dateTime.month;
    day = dateTime.day;
    weekday = WeekdayModel(dateTime.weekday);
    isCurMonth = DateTime.now().month == dateTime.month;
    docs = <DocumentModel>[];
    dateName = '';
    isHolyDay = '';

    // TODO 생성자를 만들때 docs를 초기화해서 넣어 줘야할듯;
    // docs 조회하는 method 분리해서 넣어주기?
    // or 생성자에서 초기화 하지 말고, DayModel.setDocs()로 따로 넣어주기
  }

  /// YYYYMMDD 가져오기
  getYYYYMMDDToString() {
    return year.toString() + month.toString().padLeft(2, '0') +
        day.toString().padLeft(2, '0');
  }


  // setDocs(Map<dynamic, dynamic> dayList) {
  //   var docs = dayList[getYYYYMMDDToString()];
  //   this.docs = docs != null ? [...docs] : [];
  // }

  // Future<bool> hasDocs() async {
  //   var storage = await SharedPreferences.getInstance();
  //   var docs = storage.getStringList(getYYYYMMDDToString()) ?? [];
  //   return docs.isNotEmpty;
  // }

  void singleToneTest(){
    // TODO CalendarStore().saveDoc(doc); sigleTone Test하기
    CalendarStore().addCnt();
    print('===============================================');
    CalendarStore().addCnt();
  }

  /// docs 저장
  /// addDocs

  /// docs 삭제
  /// removeDocs
  /// docs 수정
  /// editDocs

  /// docs 조회
  /// getDocs
  /// 로컬 DB에 저장된 Docs 가져오기
  Future<List<DocumentModel>> getDocs() async {

    var storage = await SharedPreferences.getInstance();
    List<String> docsKeys = storage.getStringList(getYYYYMMDDToString()) ?? [];
    List<DocumentModel> docs = [];
    for (var key in docsKeys) {
      if (storage.containsKey(key)) {
        var doc = storage.getString(key);
        if (doc != null) {
          docs.add(DocumentModel.fromJson(jsonDecode(doc)));
        };
      }
    }

    // TODO 더 다듬어야 할거 같은데 ..
    // 부모키를 조회하고, 자식의 내용을 뿌려주는게 맞는 건가?..
    return Future(() => docs);
  }


  // Json to Day
  DayModel.fromJson(Map<String, dynamic> json)
      :  dateTime = json['dateTime'] ?? '',
         year = json['year'] ?? '',
         month = json['month'] ?? '',
         day = json['day'] ?? '',
         weekday = json['weekday'] ?? '',
         isCurMonth = json['isCurMonth'] ?? '',
         docs = json['docs'] ?? '',
         dateName = json['dateName'] ?? '',
         isHolyDay = json['isHolyDay'] ?? ''
  ;

  // Day to Json
  Map<String, dynamic> toJson() {
    return {
      'dateTime' : dateTime,
      'year' : year,
      'month' : month,
      'day' : day,
      'weekday' : weekday,
      'isCurMonth' : isCurMonth,
      'docs' : docs,
      'dateName': dateName,
      'isHolyDay': isHolyDay,
    };
  }

}


