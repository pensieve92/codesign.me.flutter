import 'package:flutter/material.dart';
import 'package:me/services/calendar/model/Day.dart';
import 'package:me/services/calendar/model/Weekday.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart'; // 스크롤 다룰때 유용
import 'package:me/widgets/calendar/DayWidget.dart';
import 'package:me/utils/commonUtil.dart';

import '../../stores/CalendarStore.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  var gridCellRatio = 1 / 2; // 가로 제로 비율
  final _docContentEditController = TextEditingController();

  final CalendarStore calendarStore = CalendarStore();
  late Future<List<Day>>? daysOfMonth;

  @override
  void initState() {
    super.initState();
    setState(() {
      daysOfMonth = calendarStore.makeCalendar();
    });
  }

  @override
  void dispose() {
    _docContentEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: baseCalendarAppBar(context),
      body: FutureBuilder(
        future: daysOfMonth,
        builder: (BuildContext context, AsyncSnapshot<List<Day>> snapshot) {
          if (snapshot.hasData) {
            return baseCalendarBody(context, snapshot);
          } else {
            return CustomScrollView();
          }
          ;
        },
      ),
      bottomSheet: baseCalendarBottomSheet(context),
    );
  }

  /// 캘린더 - header AppBar
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
            Icon(Icons.arrow_drop_down),
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

  /// 캘린더 - body
  CustomScrollView baseCalendarBody(
      BuildContext context, AsyncSnapshot<List<Day>> snapshot) {
    var size = MediaQuery.of(context).size;
    print("size$size");
    var days = snapshot.data;

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
            childAspectRatio: gridCellRatio ?? 1 / 2, // item의 가로세로비율 가로1: 세로2 // 이거를 스크롤 될때 줄이거나 늘리거나 해야됨! //
          ),
          delegate: SliverChildBuilderDelegate(

                (BuildContext context, int index) {
              // DayWidget
              return Container(
                alignment: Alignment.center,
                color: Colors.black,
                child: GestureDetector(
                  onTap: () =>
                      context.read<CalendarStore>().setSelectedDay(index),
                  child: Opacity(
                    opacity: days![index].isCurMonth ? 1.0 : 0.5,
                    child: Container(
                      decoration: setSelectedDayStyle(index),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: DayWidget(context, days!, index),
                      ),
                    ),
                  ),
                ),
              );
            },
            childCount: 42, // TODO 42로 다시 변경해야함
          ),
        ),

        // SliverFixedExtentList(delegate: SliverChildBuilderDelegate((BuildContext context, int index){
        //   return ListTile(title: Text('List Item'));
        // }), itemExtent: 10.0),

        // bottomSheet 높이만큼 height를 지정해주자
        SliverToBoxAdapter(
          child: SizedBox(
            height: 53.0,
          ),
        ),
      ],
    );
  }

  /// 캘린더 - footer 저장 입력바
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
                ),
              ),
            ),
            controller: _docContentEditController,
          ),
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor:
                  Theme.of(context).colorScheme.onSecondaryContainer,
              backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
            onPressed: () {},
            // 키보드 활성 여부에 따라 버튼 아이콘 변경
            child: gf_isShowKeyboard(context)
                ? IconButton(
                    icon: Icon(Icons.check),
                    onPressed: () {
                      print('click check butotn ');
                      // saveDoc DocType >>  일정, 메모, todo, note post
                      context
                          .read<CalendarStore>()
                          .saveDoc(_docContentEditController.text);
                    },
                  )
                : IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      // TODO 상세 입력폼 나오게 분리하기
                      print('click add butotn ');
                    },
                  ),
        ),
      ],
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
