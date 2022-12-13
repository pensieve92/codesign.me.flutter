import 'package:flutter/material.dart';
import 'package:me/services/calendar/model/Day.dart';
import 'package:me/services/calendar/model/Weekday.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart'; // 스크롤 다룰때 유용
import 'package:me/widgets/calendar/DayWidget.dart';

import '../../stores/CalendarStore.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  var gridCellRatio = 1 / 2; // 가로 제로 비율
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: baseCalendarAppBar(context),
      body: baseCalendarBody(context),
      bottomSheet: baseCalendarBottomSheet(context),
    );
  }

  /**
   * 캘린더 - 하단 검색바
   */
  Row baseCalendarBottomSheet(BuildContext context) {
    return Row(
      children: [
        Flexible(
            child: TextField(
                // TODO
                // 커서가 올라가면 borderRadius가 적용이 안된다.
                // 커서올라같을때 시타일 지정하는게 있는지 찾아보기
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.blue.shade100,
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(
                          color: Colors.green,
                          width: 1.0,
                        ))))),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
          onPressed: () {},
          child: Icon(Icons.add),
        ),
      ],
    );
  }

  CustomScrollView baseCalendarBody(BuildContext context) {
    var days = context.watch<CalendarStore>().selectedMonthCalendar;

    return CustomScrollView(
      // controller: _scrollController,
      scrollDirection: Axis.vertical,
      slivers: <Widget>[
        // 월 ~ 일 달력 헤더 그리드
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7, // 1개의 행에 보여줄 item개수
            childAspectRatio:
                2.5 / 1, // item의 가로세로비율 가로/세로 // 이거를 스크롤 될때 줄이거나 늘리거나 해야됨! //
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                height: 100,
                alignment: Alignment.center,
                color: Colors.black,
                child: Text(getWeekdays()[index].name,
                    style: TextStyle(color: getWeekdays()[index].color)),
              );
            },
            childCount: 7,
          ),
        ),
        // 달력 메인 그리드
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7, // 1개의 행에 보여줄 item개수
            childAspectRatio: gridCellRatio ??
                1 / 2, // item의 가로세로비율 가로1: 세로2 // 이거를 스크롤 될때 줄이거나 늘리거나 해야됨! //
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              // DayWidget
              return Container(
                alignment: Alignment.center,
                color: Colors.black,
                child: GestureDetector(
                  onTap: () => context.read<CalendarStore>().setSelectedDay(index),
                  child: Opacity(
                    opacity: days[index].isCurMonth ? 1.0 : 0.5,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: DayWidget(context, days, index),
                      ),
                      decoration: setSelectedDayStyle(index),
                    ),
                  ),
                ),
              );
            },
            childCount: 7,// TODO 42로 다시 변경해야함
          ),
        ),

        // SliverFixedExtentList(delegate: SliverChildBuilderDelegate((BuildContext context, int index){
        //   return ListTile(title: Text('List Item'));
        // }), itemExtent: 10.0),

        // bottomSheet 높이만큼 height를 지정해주자
        SliverToBoxAdapter(
          child: Container(
            height: 48.0,
          ),
        ),
      ],
    );
  }

  /**
   * 선택된 Day 표시
   */
  BoxDecoration setSelectedDayStyle(int index) {
    int selectedDay = context.watch<CalendarStore>().selectedDay;
    if(selectedDay == index) {
      return BoxDecoration(
          color: Colors.black,
          border: Border.all(
            color: Colors.white,
            width: 2.0,
          ),
          borderRadius: BorderRadius.all(
              Radius.circular(10.0)
          )
      );
    }else{
      return BoxDecoration();
    }
  }



  /**
   * 캘린더 - 상단 AppBar
   */
  AppBar baseCalendarAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          print('click menu icon');
        },
        icon: Icon(Icons.menu_rounded),
      ),
      title: ElevatedButton(
        onPressed: () {
          print('show modal');
        },
        style: ElevatedButton.styleFrom(
          fixedSize: Size(100, 45),
          backgroundColor: Colors.black,
          textStyle: TextStyle(fontSize: 20),
          padding: EdgeInsets.only(left: 0),
        ),
        child: Row(
          children: [
            Text(context.watch<CalendarStore>().selectedYearMonth),
            Icon(Icons.arrow_drop_down)
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text('오늘',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.grey,
                )
              ]),
          onPressed: () => context.read<CalendarStore>().setToday(),
        ),
        IconButton(
          onPressed: () {
            print('click search icon');
          },
          icon: Icon(Icons.search_rounded),
        ),
        IconButton(
          onPressed: () {
            print('click calendar month icon');
          },
          icon: Icon(Icons.calendar_month_rounded),
        ),
      ],
      backgroundColor: Colors.black,
    );
  }
}
