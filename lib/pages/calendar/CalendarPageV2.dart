import 'package:flutter/material.dart';
import 'package:me/services/calendar/model/DayModel.dart';
import 'package:me/services/calendar/model/WeekdayModel.dart';
import 'package:me/stores/CalendarStoreV2.dart';
import 'package:me/utils/CalendarUtil.dart';
import 'package:me/widgets/calendar/CalendarHeaderV2.dart';
import 'package:provider/provider.dart';
import 'package:flutter/rendering.dart'; // 스크롤 다룰때 유용
import 'package:me/widgets/calendar/DayWidget.dart';
import 'package:me/utils/commonUtil.dart';

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
    var store = context.watch<CalendarStoreV2>();
    DateTime thisMonth =  store.thisMonth;

    return Scaffold(
      appBar: CalendarHeaderV2(),
      body: Container(
        color: Colors.blue,
        child: Row(
          children: [
            IconButton(
              onPressed: () => {
                print('prev Month'),
                store.setThisMonth(CalendarUtil.getPreMonth(thisMonth)),
              },
              icon: Icon(Icons.arrow_back_ios_rounded),
              color: Colors.orangeAccent,
            ),
            IconButton(
              onPressed: () => {
                print('next Month'),
                store.setThisMonth(CalendarUtil.getNextMonth(thisMonth)),
              },
              icon: Icon(Icons.arrow_forward_ios_rounded),
              color: Colors.orangeAccent,
            ),
          ],
        ),
      ),
      bottomSheet: Container(child: Text('bottom'), color: Colors.orange),
    );
  }

  /// 캘린더 - header AppBar
  /// TODO CalendarHeader Widget class
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
  /// TODO CalendarBody Widget class
  CustomScrollView baseCalendarBody(
      BuildContext context, AsyncSnapshot<List<DayModel>> snapshot) {
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
            childAspectRatio: gridCellRatio ??
                1 / 2, // item의 가로세로비율 가로1: 세로2 // 이거를 스크롤 될때 줄이거나 늘리거나 해야됨! //
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              // DayWidget
              return Container(
                alignment: Alignment.center,
                color: Colors.black,
                // TODO 상태변화 감지 이거 때문인지 확인하기
                child: GestureDetector(
                  onTap: () =>
                      context.read<CalendarStore>().setSelectedDay(index),
                  child: Opacity(
                    opacity: days![index].isCurMonth ? 1.0 : 0.5,
                    child: Container(
                      decoration: setSelectedDayStyle(index),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: DayWidget(context, days![index], index),
                      ),
                    ),
                  ),
                ),
              );
            },
            childCount: 42,
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
  /// TODO CalendarFooter Widget class
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
            foregroundColor: Theme.of(context).colorScheme.onSecondaryContainer,
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
          ).copyWith(elevation: ButtonStyleButton.allOrNull(0.0)),
          onPressed: () {},
          // 키보드 활성 여부에 따라 버튼 아이콘 변경
          child: gf_isShowKeyboard(context)
              ? IconButton(
                  icon: Icon(Icons.check),
                  onPressed: () async {
                    print('click check butotn ');
                    // saveDoc DocType >>  일정, 메모, todo, note post
                    // context
                    //     .read<CalendarStore>()
                    //     .saveDoc(_docContentEditController.text);
                    context.read<CalendarStore>().addCount2();

                    // TODO 저장후 리렌더링
                    // setState(() {
                    //   daysOfMonth = context.read<CalendarStore>().selectedMonthCalendar;
                    //   if(daysOfMonth != null){
                    //
                    //     daysOfMonth!.then((value) => {
                    //
                    //       print('daysOfMonth : ${value[0].docs[value[0].docs.length -1].docContent}')
                    //
                    //     });
                    //     print('daysOfMonth : $daysOfMonth');
                    //   }
                    //
                    // });
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
