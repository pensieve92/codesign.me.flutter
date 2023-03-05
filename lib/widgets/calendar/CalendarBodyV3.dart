import 'package:flutter/material.dart';
import 'package:me/utils/CalendarUtil.dart';
import 'package:provider/provider.dart';

import '../../stores/CalendarStoreV2.dart';

class CalendarBodyV3 extends StatefulWidget {
  const CalendarBodyV3({Key? key}) : super(key: key);

  @override
  State<CalendarBodyV3> createState() => _CalendarBodyV3();
}

class _CalendarBodyV3 extends State<CalendarBodyV3> {

  @override
  Widget build(BuildContext context) {

    var store = context.watch<CalendarStoreV2>();
    DateTime thisMonth = store.thisMonth;

    List<DateTime> calendar = CalendarUtil.createCalendar(thisMonth);

    var gridCellRatio = 1 / 2; // 가로 제로 비율

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    var appHeaderHeight = 105.5;
    print('context.owner : ${context.owner}');
    print('context.owner : ${context.widget}');

    // 그리드 헤더
    const double gridHeadRatio = 2.0;
    var gridHeadHeight = width / gridHeadRatio;

    print('gridHeadHeight: $gridHeadHeight');
    print('width: $width');

    // 그리드 풋터
    const double gridBottomHeight = 130;

    // 그리드 바디
    var gridHeight =
        (height - appHeaderHeight - gridHeadHeight - gridBottomHeight);

    print('height: $height');
    print('gridHeadHeight: $gridHeadHeight');
    print('gridBottomHeight: $gridBottomHeight');
    print('gridHeight: $gridHeight');
    var gridCellRatio2 = width / (gridHeight);
    // var gridCellRatio2 = gridHeight / width;
    // var gridCellRatio2 = 0.8;

    // MediaQuery.of(context).size.height 전체 핸드폰의 사이즈 이고
    // 현재 Widget의 사이즈를 구해서 계산해야됨 stickyKey.currentContext;
    // `currentContext`

    print('gridCellRatio2 : $gridCellRatio2');

    return Column(
      children: [
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 7,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7, // 1개의 행에 보여줄 item개수
            childAspectRatio: gridHeadRatio, // item의 가로세로비율 가로/세로
          ),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              alignment: Alignment.center,
              color: Colors.black,
              child: Text(
                CalendarUtil.getWeekDayText(index),
                style: TextStyle(color: CalendarUtil.getWeekDayColor(index)),
              ),
            );
          },
        ),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 42,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7, // 1개의 행에 보여줄 item개수
            childAspectRatio:
                gridCellRatio2, // item의 가로세로비율 가로/세로 // 이거를 스크롤 될때 줄이거나 늘리거나 해야됨!
          ),
          itemBuilder: (BuildContext context, int index) {
            // DayWidget
            return Container(
              alignment: Alignment.center,
              color: Colors.black,
              // TODO 상태변화 감지 이거 때문인지 확인하기
              child: GestureDetector(
                onTap: () => {
                },
                // context.read<CalendarStore>().setSelectedDay(index),
                child: Opacity(
                  opacity: calendar[index].month == thisMonth.month ? 1.0 : 0.5,
                  child: Container(
                    // decoration: setSelectedDayStyle(index),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // children: DayWidget(context, days![index], index),
                      children: [
                        Text(
                          calendar[index].day.toString(),
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        SizedBox(
          height: gridBottomHeight,
          child: Text("text"),
        )
      ],
    );

    //   CustomScrollView(
    //   scrollDirection: Axis.vertical,
    //   slivers: <Widget>[
    //     // 월 ~ 일 달력 헤더 그리드
    //     SliverGrid(
    //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //         crossAxisCount: 7, // 1개의 행에 보여줄 item개수
    //         childAspectRatio:
    //         2.5 / 1, // item의 가로세로비율 가로/세로 // 이거를 스크롤 될때 줄이거나 늘리거나 해야됨!
    //       ),
    //       delegate: SliverChildBuilderDelegate(
    //             (BuildContext context, int index) {
    //           return Container(
    //             height: 100,
    //             alignment: Alignment.center,
    //             color: Colors.black,
    //             child: Text(CalendarUtil.getWeekDayText(index),
    //                 style: TextStyle(color: CalendarUtil.getWeekDayColor(index)),
    //             ),
    //           );
    //         },
    //         childCount: 7,
    //       ),
    //     ),
    //     // 달력 메인 그리드
    //     SliverGrid(
    //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //         crossAxisCount: 7, // 1개의 행에 보여줄 item개수
    //         childAspectRatio: gridCellRatio, // item의 가로세로비율 가로1: 세로2 // 이거를 스크롤 될때 줄이거나 늘리거나 해야됨! //
    //       ),
    //       delegate: SliverChildBuilderDelegate(
    //             (BuildContext context, int index) {
    //           // DayWidget
    //           return Container(
    //             alignment: Alignment.center,
    //             color: Colors.black,
    //             child: GestureDetector(
    //               onTap: () => {},
    //                   // context.read<CalendarStore>().setSelectedDay(index),
    //               child: Opacity(
    //                 opacity: calendar[index].month == thisMonth.month ? 1.0 : 0.5,
    //                 child: Container(
    //                   // decoration: setSelectedDayStyle(index),
    //                   child: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     // children: DayWidget(context, days![index], index),
    //                     children: [Text(calendar[index].day.toString(), style: TextStyle(color: Colors.white),)],
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           );
    //         },
    //         childCount: 42,
    //       ),
    //     ),
    //
    //     // SliverAppBar(title: Text("sliverAppbar"), titleTextStyle: TextStyle(color: Colors.white),)
    //
    //     // SliverFixedExtentList(delegate: SliverChildBuilderDelegate((BuildContext context, int index){
    //     //   return ListTile(title: Text('List Item'));
    //     // }), itemExtent: 10.0),
    //
    //     // bottomSheet 높이만큼 height를 지정해주자
    //     // SliverToBoxAdapter(
    //     //   child: SizedBox(
    //     //     height: 53.0,
    //     //   ),
    //     // ),
    //   ],
    // );
  }


}
