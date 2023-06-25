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

  var flagKeyBoard = false;

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
      drawer: Drawer(backgroundColor: Colors.greenAccent,
        child: Container(color: Colors.red,
            width: 100,
          child: Text("drawer"),
        ),
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: IntrinsicHeight(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(child: CalendarBodyV4())
                // CONTENT HERE
              ],
            ),
          ),
        ),
      ),
      // TODO 키보드가 없으면 추가 버튼이고
      // TODO 키보드가 있으면 생성 버튼으로
      bottomSheet: Container(
        color: Colors.red,
        height: 40,
        child: TextField(
          controller: new TextEditingController(),
        ),
      ),
    );
  }

  // createFooter
  // 입력 input 영역
  Widget createFooter() {
    var textEditingController = TextEditingController();

    return TextField(
      style: TextStyle(color: Colors.black),
      cursorColor: Colors.blue,
      expands: true,
      minLines: null,
      maxLines: null,
      onTap: () => {
        toggleKeyBoard()
      },
      decoration: InputDecoration(
          filled: true,
          suffixIcon: ElevatedButton(
              onPressed: () => {},
              // child: isShowKeyboard(context)
              child: flagKeyBoard
                  ?
              // 키보드가 나온 경우
              IconButton(
                alignment: Alignment.topLeft,
                icon: Icon(
                  Icons.add_box_rounded,
                  size: 30,
                ),
                onPressed: () => {print('add button')},
              )
              // 키보드가 들어간 경우
                  : IconButton(
                  onPressed: () => {

                  }, icon: Icon(Icons.done_outline)))),
      controller: textEditingController,
    );
  }

  toggleKeyBoard() {
    print("flagKeyBoard $flagKeyBoard");
    if (MediaQuery.of(context).viewInsets.bottom != 0.0) {
      setState(() {
        flagKeyBoard = false;
      });
    }else{
      setState(() {
        flagKeyBoard = true;
      });
    }
  }

}
