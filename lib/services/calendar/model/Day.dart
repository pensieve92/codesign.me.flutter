import 'package:flutter/material.dart';
import 'package:me/services/calendar/model/Document.dart';
import 'package:me/services/calendar/model/Weekday.dart';

class Day {
  late DateTime dateTime; // defualt 값
  late int year;// 년
  late int month; // 월
  late int day; // 일
  late Weekday weekday; // 요일
  late bool isCurMonth; // 현재월여부
  late List<Document> docs; // doc 리스트

  Day(DateTime dateTime): dateTime = DateTime.now() {
    this.dateTime = dateTime;
    this.year = dateTime.year;
    this.month = dateTime.month;
    this.day = dateTime.day;
    this.weekday = Weekday(dateTime.weekday);
    this.isCurMonth = DateTime.now().month == dateTime.month;
  }
}


