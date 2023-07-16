import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart'; // 스크롤 다룰때 유용
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get_it/get_it.dart';
import 'package:me/db/daos/datasource.dart';
import 'package:me/db/tables/DocTypeGroups.dart';
import 'package:me/widgets/calendar/CalendarBodyV2.dart';
import 'package:me/widgets/calendar/CalendarBodyV3.dart';
import 'package:me/widgets/calendar/CalendarBodyV4.dart';
import 'package:me/widgets/calendar/CalendarFooterV2.dart';
import 'package:me/widgets/calendar/CalendarHeaderV2.dart';
import 'package:provider/provider.dart';

import './dialog/DialogExample.dart';


import '../../stores/CalendarStore.dart';

class CalendarPageV2 extends StatefulWidget {
  const CalendarPageV2({Key? key}) : super(key: key);

  @override
  State<CalendarPageV2> createState() => _CalendarPageV2State();
}

class _CalendarPageV2State extends State<CalendarPageV2> {
  var gridCellRatio = 1 / 2; // 가로 제로 비율
  final _docContentEditController = TextEditingController();

  // keyboard show/hide listener
  late StreamSubscription<bool> keyboardSubscription;
  var flagKeyBoard = false;

  @override
  void initState() {
    super.initState();

    // keyboard show/hide listener
    var keyboardVisibilityController = KeyboardVisibilityController();
    // Query
    print(
        'Keyboard visibility direct query: ${keyboardVisibilityController.isVisible}');
    // Subscribe
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      print('Keyboard visibility update. Is visible: $visible');
      flagKeyBoard = visible;
    });
  }

  @override
  void dispose() {
    _docContentEditController.dispose();

    // keyboard show/hide listener
    keyboardSubscription.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var isDialOpen = ValueNotifier<bool>(false);
    return Scaffold(
      onDrawerChanged: (isOpened) {
        if(isOpened) FocusManager.instance.primaryFocus?.unfocus();
      },
      appBar: CalendarHeaderV2(),
      drawer: Drawer(
        backgroundColor: Colors.greenAccent,
        child: Container(
          color: Colors.red,
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
      bottomSheet:BottomAppBar(
        color: Colors.redAccent,
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 300,
              child : TextField(
                style: TextStyle(color: Colors.black),
                cursorColor: Colors.blue,
                controller: _docContentEditController,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton:
      SpeedDial(
        childrenButtonSize: const Size(70.0, 70.0),
        icon: flagKeyBoard ? Icons.check : Icons.add,
        activeIcon: Icons.close,
        openCloseDial: isDialOpen,
        onPress: () async {
          print('onPress');
          if(flagKeyBoard){
            print('TODO save');
            // TODO 저장로직 개발
            // TODO SQLite 추가하기
            // TODO 저장할 테이블 만들기
            var text = _docContentEditController.text;
            print(text);
            // await GetIt.I<LocalDataBase>()
            //     .docTypeDaoㅡ
            //     .createDocTypeGroup(
            //       DocTypeGroupsCompanion(
            //         typeGroupId: Value('2'),
            //         typeGroupNm: Value('BASE2'),
            //         useYn: Value('N')
            //       )
            //     );
          }else{
            isDialOpen.value = !isDialOpen.value;
          }
        },
        onOpen: (){
          print('onOpen');
        },
        onClose: (){
          print('onClose');
        },
        visible: true,
        curve: Curves.bounceIn,
        backgroundColor: Colors.indigo.shade900,
        activeBackgroundColor: Colors.indigo.shade900,
        switchLabelPosition: false,
        childMargin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        childPadding: const EdgeInsets.symmetric(vertical: 8),
        overlayColor: Colors.black,
        overlayOpacity: 0.8,
        children: [
          SpeedDialChild(
              child: const Icon(Icons.check, color: Colors.white,),
              label: "일정",
              labelStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                  fontSize: 14.0
              ),
              backgroundColor: Colors.indigo.shade900,
              labelBackgroundColor: Colors.black.withOpacity(0.0),
              labelShadow: [], // shadow 없애기
              onTap: (){}
          ),
          SpeedDialChild(
              child: const Icon(Icons.settings_sharp, color: Colors.white,),
              label: "TODO",
              labelStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                  fontSize: 14.0
              ),
              backgroundColor: Colors.indigo.shade900,
              labelBackgroundColor: Colors.black.withOpacity(0.0),
              foregroundColor: Colors.black.withOpacity(0.0),
              labelShadow: [],
              onTap: (){}
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

}
