import 'package:flutter/material.dart';
import 'package:me/services/calendar/model/Document.dart';

Row DayTodoWidget(Document doc) {

  // print('day.docs : ${doc}');
  // print('day.docs : ${doc.docId}');
  // print('day.docs : ${doc.docType}');
  // print('day.docs : ${doc.docContent}');

  return Row(
    children: [
      Expanded(
          child: Container(
            color: Colors.amber,
            child: Text(doc.docContent, style: TextStyle(color: Colors.white, fontSize: 8.0)),
          )
      )
    ],
  );
}

