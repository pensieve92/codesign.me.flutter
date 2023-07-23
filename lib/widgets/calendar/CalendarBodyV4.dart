import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:me/db/daos/datasource.dart';
import 'package:me/db/tables/DocTypeGroups.dart';
import 'package:me/utils/CalendarUtil.dart';
import 'package:provider/provider.dart';
import 'package:me/utils/commonUtil.dart';

import '../../stores/CalendarStoreV2.dart';

class CalendarBodyV4 extends StatefulWidget {
  final int dragCount;
  CalendarBodyV4({Key? key, required this.dragCount }) : super(key: key);

  @override
  State<CalendarBodyV4> createState() => _CalendarBodyV4();
}

class _CalendarBodyV4 extends State<CalendarBodyV4> {

  var toggleFooter = false;
  var flagKeyBoard = false;

  // 전체: 24
  var headFlex = 1;
  var bodyFlex = 22;
  var footFlex = 1;

  // 선택된 날
  DateTime selectedDay = CalendarUtil.getToday();

  @override
  Widget build(BuildContext context) {
    print('widget.dragCount : ${widget.dragCount}');

    setState(() {
      if(widget.dragCount == -1){
        // 달력 100%
        headFlex = 1;
        bodyFlex = 19;
        footFlex = 4;
      } else if(widget.dragCount == 0) {
        // 달력, 리스트 50%
        bodyFlex = 8;
        footFlex = 15;
      } else if(widget.dragCount == 1) {
        // 달력 1줄만, 나머지 리스트 100%
        bodyFlex = 3;
        footFlex = 20;
      }
    });


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
          child: createBody(calendar)
        ),
        // 풋터
        Flexible(
          flex: footFlex,
          child: StreamBuilder<List<DocTypeGroup>>(
            // TODO 조회 확인 테스트
            stream: GetIt.I<LocalDataBase>().docTypeDao.watchDocTypeGroup("1"),
            builder: (context, snapshot) {
              // },
              if(snapshot.hasData){
                print('result : ${snapshot.data}');
              }else{
                print('result : no Data');
              }

              return Container(color: Colors.orange,);
            }
          ),
        ),
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
          .map(
            (week) => Flexible(
              child: Row(
                  children: week
                      .map(
                        (day) => Expanded(
                          child: GestureDetector(
                            onTap: () => {selectDay(day)},
                            child: Container(
                              decoration: selectedDayDecoration(day),
                              child: Container(
                                alignment: Alignment.center,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Opacity(
                                      opacity: day.month == thisMonth.month
                                          ? 1.0
                                          : 0.5,
                                      child: Text(
                                        day.day.toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2,
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

  /// selectDay
  /// 날짜 선택
  selectDay(day) {
    // 키보드 포커스 아웃
    FocusManager.instance.primaryFocus?.unfocus();

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
