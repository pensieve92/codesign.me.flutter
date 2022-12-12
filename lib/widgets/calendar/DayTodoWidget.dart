import 'package:flutter/material.dart';

Row DayTodoWidget() {
  return Row(
    children: [
      Expanded(
          child: Container(
            color: Colors.amber,
            child: Text('TODO 1\nTODO 2', style: TextStyle(color: Colors.white)),
          )
      )
    ],
  );
}

