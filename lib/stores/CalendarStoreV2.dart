import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:me/services/calendar/model/DocumentModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/calendar/model/DayModel.dart';
import '../utils/CalendarUtil.dart';

// 사용할 변수를 late로 선언한다.
// store의 역할이 멀까? >> 변수를 가지고 있다.
// 화면과 데이터 분리 할 수 있다.
/// SingleTon
class CalendarStoreV2 extends ChangeNotifier {
  /// *********************************************************** ///
  /// *********************** 싱글톤 초기화 *********************** ///
  /// *********************************************************** ///

  static final CalendarStoreV2 _singleton = CalendarStoreV2._internal();

  factory CalendarStoreV2() {
    return _singleton;
  }

  /// CalendarStoreV2 초기화
  CalendarStoreV2._internal() {
    _thisMonth = DateTime.now();
  }

  /// ******************************************************** ///
  /// *********************** data 정의 *********************** ///
  /// ******************************************************** ///

  /// TODO 사용자가 DropDown 또는 팜업으로 선택할 수있도록 할 예정
  /// Calendar>Main>AppBar
  /// Data : 이번달
  late DateTime _thisMonth;

  DateTime get thisMonth => _thisMonth;

  setThisMonth(DateTime dateTime) {
    _thisMonth = dateTime;
    notifyListeners();
  }

  /// ********************************************************** ///
  /// *********************** action 정의 *********************** ///
  /// ********************************************************** ///

}
