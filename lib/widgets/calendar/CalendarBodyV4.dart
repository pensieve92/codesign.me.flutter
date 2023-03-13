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

  var toggleFooter = false;
  // 전체: 24
  var headFlex = 1;
  var bodyFlex = 21;
  var footFlex = 2;

  // 선택된 날
  DateTime selectedDay = CalendarUtil.getToday();

  @override
  Widget build(BuildContext context) {
    var store = context.watch<CalendarStoreV2>();
    DateTime thisMonth = store.thisMonth;

    List<DateTime> calendar = CalendarUtil.createCalendar(thisMonth);

    return Column(
      children: [
        // 헤더
        Flexible(flex: headFlex, child: createHeader()),
        // 바디
        Flexible(
          flex: bodyFlex,
          child: createBody(calendar),
        ),
        // 풋터
        Flexible(flex: footFlex, child: createFooter()),
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
                    color: Theme.of(context).backgroundColor,
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
    DateTime thisMonth = store.thisMonth;

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
                  children: week
                      .map((day) => Expanded(
                          child: GestureDetector(
                            onTap: () => {
                              selectDay(day)
                            },
                            child: Container(
                              decoration: selectedDayDecoration(day),
                                child: Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Opacity(
                                        opacity: day.month == thisMonth.month ? 1.0 : 0.5,
                                        child: Text(
                                          day.day.toString(),
                                          style: Theme.of(context).textTheme.bodyText2,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                            ),
                          ),
                        ),
                      )
                      .toList()),
            ),
          )
          .toList(),
    );
  }

  /// createFooter
  /// 입력 input 영역
  Container createFooter() {
    return Container(
      color: Colors.yellowAccent,
      child: IconButton(
        onPressed: () => {toggleFooterRatio()},
        icon: Icon(Icons.add),
      ),
    );
  }

  /// toggleCalendarRatio
  /// body, footer 영역 확대/축소
  toggleFooterRatio() {
    setState(() {
      if (toggleFooter == false) {
        bodyFlex = 11;
        footFlex = 12;
      } else {
        bodyFlex = 21;
        footFlex = 2;
      }

      toggleFooter = !toggleFooter;
    });
  }

  /// selectDay
  /// 날짜 선택
  selectDay(day){
    setState(() {
      selectedDay = day;
    });
  }

  /// setSelectedDayStyle
  /// 선택된 날짜 데코레이션
  BoxDecoration selectedDayDecoration(day) {
    if (selectedDay == day) {
      return BoxDecoration(
          color: Theme.of(context).backgroundColor,
          border: Border.all(
            color: Colors.white,
            width: 1.0,
          ),
      );
    } else {
      return BoxDecoration(
        color: Theme.of(context).backgroundColor,
      );
    }
  }
}
