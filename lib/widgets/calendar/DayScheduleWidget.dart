import 'package:flutter/material.dart';

Row DayScheduleWidget() {
  return Row(
    children: [
      FractionalTranslation(
        translation: Offset(0, 0),
        child: Container(
            child: SizedBox(
              height: 15,
              width: 5,
              child: const ColoredBox(color: Colors.amber),
            )),
      ),
      Expanded(
        child: Text('일정 6시 천혁 수원역',
            style: TextStyle(color: Colors.white)),
      ),
    ],
  );
}

