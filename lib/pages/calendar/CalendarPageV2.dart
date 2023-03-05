import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart'; // 스크롤 다룰때 유용
import 'package:me/widgets/calendar/CalendarBodyV2.dart';
import 'package:me/widgets/calendar/CalendarBodyV3.dart';
import 'package:me/widgets/calendar/CalendarBodyV4.dart';
import 'package:me/widgets/calendar/CalendarFooterV2.dart';
import 'package:me/widgets/calendar/CalendarHeaderV2.dart';
import 'package:provider/provider.dart';

import '../../stores/CalendarStore.dart';

class CalendarPageV2 extends StatefulWidget {
  const CalendarPageV2({Key? key}) : super(key: key);

  @override
  State<CalendarPageV2> createState() => _CalendarPageV2State();
}

class _CalendarPageV2State extends State<CalendarPageV2> {
  var gridCellRatio = 1 / 2; // 가로 제로 비율
  final _docContentEditController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _docContentEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CalendarHeaderV2(),
      // body: CalendarBodyV2(), // TODO 스크롤을 없애기 위해, SliverGrid >> GridView로 변경
      // body: CalendarBodyV3(), // TODO 스크롤을 없애기 위해, SliverGrid >> GridView로 변경
      body: CalendarBodyV4(), // TODO SliverGrid >> Column, Row로 변경
      // body: Column(
      //   children: [
      //     Flexible(
      //       // flex: 10,
      //       // Container를 Expanded로 감싸줌, 파란색 박스
      //       // child: Container(
      //       //   color: Colors.blue,
      //       // ),
      //       child: CalendarBodyV2(),
      //     ),
      //     Expanded(
      //       // Container를 Expanded로 감싸줌, 빨간색 박스
      //       child: Container(
      //         color: Colors.red,
      //       ),
      //     ),
      //
      //   ],
      // )
      // bottomSheet: CalendarFooterV2(),
      // bottomNavigationBar: BottomAppBar(
      //   color: Colors.orangeAccent,
      //   child: Text('bottomNavigationBar'),
      // ),
      // persistentFooterButtons: [
      //   IconButton(
      //     icon: Icon(Icons.add),
      //     onPressed: null,
      //   )
      // ],
    );
  }

  /// 선택된 Day 표시 - 스타일변경
  BoxDecoration setSelectedDayStyle(int index) {
    int selectedDay = context.watch<CalendarStore>().selectedDay;
    if (selectedDay == index) {
      return BoxDecoration(
          color: Colors.black,
          border: Border.all(
            color: Colors.white,
            width: 2.0,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10.0)));
    } else {
      return BoxDecoration();
    }
  }
}
