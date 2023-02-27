import 'package:flutter/material.dart';

import 'package:me/services/calendar/model/DocType.dart';

class DocumentModel {
  late String docId = ''; // ID : docDate-docType-createDate
  late String docDate = ''; // 해당날짜
  late String docType = ''; // 타입
  late String docContent = ''; // 내용
  late String docColor = 'orangeAccent'; // highlight 색깔

  late String docFstEmoji = ''; // 이모지1
  late String docScdEmoji = ''; // 이모지2
  late String conditionColor = ''; // 이모지 컨디션

  late String startDate = ''; // 스케줄 - 시작시간
  late String endDate = ''; // 스케줄 - 종료기간
  late bool isDone = false;   // todo리스트 - 완료여부

  late String createDate = ''; // 생성일자
  late String updateDate = ''; // 수정일자

  // Doc 기본 생성자 (docType별로 createTodo... 만들거라 생략함)
  DocumentModel({
    required this.docDate,
    required this.docContent,
    required this.createDate,
  });

  // DocType-TODO Doc 생성
  DocumentModel.createTodo({
    required this.docDate,
    required this.docContent,
    required this.createDate,
  }) : docId = '$docDate-${DocType.todo.code}-$createDate',
  docType = DocType.todo.code;

  // Document.createSchedule({
  //   required this.docDate,
  //   required this.docContent,
  //   required this.createDate,
  // }) : docId = '$docDate-$this.docType-${createDate}' ;
  //
  // Document.createMemo({
  //   required this.docDate,
  //   required this.docContent,
  //   required this.createDate,
  // }) : docId = '$docDate-$this.docType-${createDate}' ;

  // Json to Document
  DocumentModel.fromJson(Map<String, dynamic> json)
      : docId = json['docId'] ?? '',
        docDate = json['docDate'] ?? '',
        docType = json['docType'] ?? '',
        docContent = json['docContent'] ?? '',
        docColor = json['docColor'] ?? 'orangeAccent',
        docFstEmoji = json['docFstEmoji'] ?? '',
        docScdEmoji = json['docScdEmoji'] ?? '',
        conditionColor = json['conditionColor'] ?? '',
        startDate = json['startDate'] ?? '',
        endDate = json['endDate'] ?? '',
        isDone = json['isDone'] ?? false,
        createDate = json['createDate'] ?? '',
        updateDate = json['updateDate'] ?? ''
  ;


  // Document to Json
  Map<String, dynamic> toJson() {
    return {
      'docId' : docId,
      'docDate' : docDate,
      'docType' : docType,
      'docContent' : docContent,
      'docColor' : docColor,
      'docFstEmoji' : docFstEmoji,
      'docScdEmoji' : docScdEmoji,
      'conditionColor' : conditionColor,
      'startDate' : startDate,
      'endDate' : endDate,
      'isDone' : isDone,
      'createDate' : createDate,
      'updateDate' : updateDate,
    };
  }

}
