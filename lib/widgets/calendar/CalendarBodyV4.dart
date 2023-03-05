import 'package:flutter/material.dart';
import 'package:me/utils/CalendarUtil.dart';
import 'package:provider/provider.dart';

import '../../stores/CalendarStoreV2.dart';

class CalendarBodyV4 extends StatefulWidget {
  const CalendarBodyV4({Key? key}) : super(key: key);

  @override
  State<CalendarBodyV4> createState() => _CalendarBodyV4();
}

class _CalendarBodyV4 extends State<CalendarBodyV4> {
  @override
  Widget build(BuildContext context) {
    var store = context.watch<CalendarStoreV2>();
    DateTime thisMonth = store.thisMonth;

    List<DateTime> calendar = CalendarUtil.createCalendar(thisMonth);

    return Column(
      children: [
        // 헤더
        Flexible(flex: 1, child: createHeader()),
        // 바디
        Flexible(
          flex: 21,
          child: createBody(calendar),
        ),
        // 풋터
        Flexible(flex: 2, child: createFooter()),
      ],
    );
  }

  /// createHeader
  /// 캘린더 Header 영역
  Column createHeader() {
    var weekDays = CalendarUtil.getWeekDays();
    var lang = 'ko';

    return Column(
      children: [
        Flexible(
            child: Row(
          children: weekDays
              .map((item) => Expanded(
                      child: Container(
                    color: Colors.black,
                    alignment: Alignment.center,
                    child: Text(
                      (item['text'] as Map)[lang],
                      style: TextStyle(color: item['color'] as Color),
                    ),
                  )))
              .toList(),
        )),
      ],
    );
  }

  /// createBody
  /// 캘린더 Body 영역
  Column createBody(List<DateTime> calendar) {
    var store = context.watch<CalendarStoreV2>();
    DateTime thisMonth =  store.thisMonth;

    // 42개를 7일씩 6주로 끊기
    const daysOfWeek = 7;
    List<List<DateTime>> weekList = [];
    for (var i = 0; i < 6; i++) {
      weekList.add(calendar.sublist(daysOfWeek * i, daysOfWeek * (i + 1)));
    }

    return Column(
      children: weekList
          .map((week) => Flexible(
              child: Row(
                  children: week.map((day) => Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                color: Colors.black,
                                // TODO 상태변화 감지 이거 때문인지 확인하기
                                child: GestureDetector(
                                  onTap: () => {},
                                  child: Opacity(
                                    opacity: day.month == thisMonth.month ? 1.0 : 0.5,
                                    child: Container(
                                      // decoration: setSelectedDayStyle(index),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [Text(day.day.toString(), style: TextStyle(color: Colors.white),)],
                                      ),
                                    ),
                                  ),
                                ),
                          ),
                  ),
                  ).toList()),
            ),
          ).toList(),
    );
  }

  /// createFooter
  /// 입력 input 영역
  Container createFooter() {
    return Container(
      color: Colors.yellowAccent,
    );
  }
}
