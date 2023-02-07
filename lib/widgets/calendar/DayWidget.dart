import 'package:flutter/material.dart';
import 'package:me/services/calendar/model/Day.dart';
import 'package:me/widgets/calendar/DayHeaderWidget.dart';
import 'package:me/widgets/calendar/DayTodoWidget.dart';
import 'package:me/widgets/calendar/DayScheduleWidget.dart';


List<Widget> DayWidget(BuildContext context, List<Day> days, int index) {
  return [
    // Header - 요일
    DayHeaderWidget(context, days, index),

    // Body & Footer
    Expanded(
      child: Stack(
        children: [
          // Body - 일정 & TODO리스트
          Column(
            children: [
                 Container(
                  child: Column(
                    children: [
                      // 일정
                      DayScheduleWidget(),
                      // TODOList
                      DayTodoWidget(),
                    ],
                  ),
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

