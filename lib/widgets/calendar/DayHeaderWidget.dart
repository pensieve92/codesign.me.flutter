import 'package:flutter/material.dart';
import 'package:me/services/calendar/model/Day.dart';
import 'package:me/stores/CalendarStore.dart';
import 'package:provider/provider.dart';

Row DayHeaderWidget(BuildContext context, Day day, int index) {
  var today = DateTime.now().day;
  bool isToday = day.isCurMonth && day.day == today;

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
                Container(
                  width: 20,
                    alignment: Alignment.center,
                  decoration: isToday ? BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.white12,
                    ),
                    borderRadius: BorderRadius.circular(7.5)
                  ): BoxDecoration(),
                    child: Text(day.day.toString(),
                    style:TextStyle(
                      color: isToday ? Colors.black : day.weekday.color,
                      fontSize: 12,
                      fontWeight: FontWeight.bold
                    )
                  ),
                ),
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