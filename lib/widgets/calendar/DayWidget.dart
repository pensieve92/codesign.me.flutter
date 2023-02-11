import 'package:flutter/material.dart';
import 'package:me/services/calendar/model/Day.dart';
import 'package:me/services/calendar/model/Document.dart';
import 'package:me/widgets/calendar/DayHeaderWidget.dart';
import 'package:me/widgets/calendar/DayTodoWidget.dart';
import 'package:me/widgets/calendar/DayScheduleWidget.dart';

List<Widget> DayWidget(BuildContext context, Day day, int index) {
  // print('DayWidget days : $day');
  return [
    // Header - 요일
    DayHeaderWidget(context, day, index),
    // Body & Footer
    Expanded(
      child: Stack(
        children: [
          // Body - 일정 & TODO리스트
          Column(
            children: [
                 Column(
                   children: day.docs.isNotEmpty ? createDocs(day.docs) : [Row()],
                 ),
            ],
          ),
          // Footer - 이모지
          Positioned(
            bottom: 0,
            child: Icon(Icons.add, color: Colors.red, size: 25)
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: Icon(Icons.add, color: Colors.red, size: 25)
          ),
        ],
      ),
    ),
  ];
}

List<Widget> createDocs(List<Document> docs){
  List<Widget> list = [];
  for(var doc in docs){
    if (doc.docType == "TODO") {
      list.add(DayTodoWidget(doc));
    }else {
      list.add(DayScheduleWidget());
    }
  }
  return list;
}


