import 'package:flutter/material.dart';
import 'package:me/utils/CalendarUtil.dart';
import 'package:provider/provider.dart';

import '../../stores/CalendarStoreV2.dart';

class CalendarBodyV2 extends StatefulWidget {
  const CalendarBodyV2({Key? key}) : super(key: key);

  @override
  State<CalendarBodyV2> createState() => _CalendarBodyV2();
}

class _CalendarBodyV2 extends State<CalendarBodyV2> {

  @override
  Widget build(BuildContext context) {
    var store = context.watch<CalendarStoreV2>();
    DateTime thisMonth =  store.thisMonth;

    List<DateTime> calendar = CalendarUtil.createCalendar(thisMonth);

    var gridCellRatio = 1 / 2; // 가로 제로 비율

    return CustomScrollView(
      scrollDirection: Axis.vertical,
      slivers: <Widget>[
        // 월 ~ 일 달력 헤더 그리드
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7, // 1개의 행에 보여줄 item개수
            childAspectRatio:
            2.5 / 1, // item의 가로세로비율 가로/세로 // 이거를 스크롤 될때 줄이거나 늘리거나 해야됨!
          ),
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              return Container(
                height: 100,
                alignment: Alignment.center,
                color: Colors.black,
                child: Text(CalendarUtil.getWeekDayText(index),
                    style: TextStyle(color: CalendarUtil.getWeekDayColor(index)),
                ),
              );
            },
            childCount: 7,
          ),
        ),
        // 달력 메인 그리드
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7, // 1개의 행에 보여줄 item개수
            childAspectRatio: gridCellRatio, // item의 가로세로비율 가로1: 세로2 // 이거를 스크롤 될때 줄이거나 늘리거나 해야됨! //
          ),
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              // DayWidget
              return Container(
                alignment: Alignment.center,
                color: Colors.black,
                // TODO 상태변화 감지 이거 때문인지 확인하기
                child: GestureDetector(
                  onTap: () => {},
                      // context.read<CalendarStore>().setSelectedDay(index),
                  child: Opacity(
                    opacity: calendar[index].month == thisMonth.month ? 1.0 : 0.5,
                    child: Container(
                      // decoration: setSelectedDayStyle(index),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // children: DayWidget(context, days![index], index),
                        children: [Text(calendar[index].day.toString(), style: TextStyle(color: Colors.white),)],
                      ),
                    ),
                  ),
                ),
              );
            },
            childCount: 42,
          ),
        ),

        // SliverAppBar(title: Text("sliverAppbar"), titleTextStyle: TextStyle(color: Colors.white),)

        // SliverFixedExtentList(delegate: SliverChildBuilderDelegate((BuildContext context, int index){
        //   return ListTile(title: Text('List Item'));
        // }), itemExtent: 10.0),

        // bottomSheet 높이만큼 height를 지정해주자
        // SliverToBoxAdapter(
        //   child: SizedBox(
        //     height: 53.0,
        //   ),
        // ),
      ],
    );
  }
}
