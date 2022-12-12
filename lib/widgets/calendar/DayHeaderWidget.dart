import 'package:flutter/material.dart';
import 'package:me/services/calendar/model/Day.dart';

Row DayHeaderWidget(List<Day> days, int index) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Expanded(
        child: Container(
          // color: Colors.red,// 요일 백그라운드 칼라
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: Text(''),
                  ),
                ),
                Text((days[index]).day.toString(), style:TextStyle(color: (days[index]).weekday.color,)),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: Text(''),
                  ),
                ),
              ]
          ),
        ),
      )
    ],
  );
}