import 'package:flutter/material.dart';
import 'package:me/services/calendar/model/DayModel.dart';
import 'package:me/services/calendar/model/DocumentModel.dart';
import 'package:me/widgets/calendar/DayHeaderWidget.dart';
import 'package:me/widgets/calendar/DayTodoWidget.dart';
import 'package:me/widgets/calendar/DayScheduleWidget.dart';

List<Widget> DayWidget(BuildContext context, DayModel day, int index) {
 // print('hasDoc : ${day.hasDocs()}');
  day.singleToneTest();


  return [
    // Header - 요일
    DayHeaderWidget(context, day, index),
    // Body & Footer
    Expanded(
      child: FutureBuilder(
        future: day.getDocs(),
        builder: (context, snop) {
          // 42개 조회 / TODO 조회 데이터로 Doc 뿌리기
          print(snop.data);
          return Stack(
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
          );
        }
      ),
    ),
  ];
}

List<Widget> createDocs(List<DocumentModel> docs){
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


