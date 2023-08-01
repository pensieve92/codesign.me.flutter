import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:me/widgets/calendar/CalendarBodyV4.dart';
import 'package:me/widgets/calendar/CalendarHeaderV2.dart';

class CalendarPageV2 extends StatefulWidget {
  const CalendarPageV2({Key? key}) : super(key: key);

  @override
  State<CalendarPageV2> createState() => _CalendarPageV2State();
}

class _CalendarPageV2State extends State<CalendarPageV2> {
  var gridCellRatio = 1 / 2; // 가로 제로 비율
  final _docContentEditController = TextEditingController();

  // Drag Up, Down
  int dragCount = 0; // -1: calendar full size, 리스트 제로, 0: default, 1: 리스트 full
  String dragDirection = '';
  double startDXPoint = 50.0;
  double startDYPoint = 50.0;
  double dXPoint = 0.0;
  double dYPoint = 0.0;

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
        if (isOpened) FocusManager.instance.primaryFocus?.unfocus();
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
      body: GestureDetector(
        behavior: HitTestBehavior.deferToChild,
        onVerticalDragStart: handleVerticalDragStart,
        onVerticalDragUpdate: handleVerticalDragUpdate,
        onVerticalDragEnd: handleVerticalDragEnd,
        child: SingleChildScrollView(
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
                  Expanded(child: CalendarBodyV4(dragCount: dragCount))
                  // CONTENT HERE
                ],
              ),
            ),
          ),
        ),
      ),
      bottomSheet: BottomAppBar(
        color: Colors.redAccent,
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 300,
              child: TextField(
                style: TextStyle(color: Colors.black),
                cursorColor: Colors.blue,
                controller: _docContentEditController,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
        childrenButtonSize: const Size(70.0, 70.0),
        icon: flagKeyBoard ? Icons.check : Icons.add,
        activeIcon: Icons.close,
        openCloseDial: isDialOpen,
        onPress: () async {
          print('onPress');
          if (flagKeyBoard) {
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
          } else {
            isDialOpen.value = !isDialOpen.value;
          }
        },
        onOpen: () {
          print('onOpen');
        },
        onClose: () {
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
              child: const Icon(
                Icons.check,
                color: Colors.white,
              ),
              label: "일정",
              labelStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                  fontSize: 14.0),
              backgroundColor: Colors.indigo.shade900,
              labelBackgroundColor: Colors.black.withOpacity(0.0),
              labelShadow: [],
              // shadow 없애기
              onTap: () {}),
          SpeedDialChild(
              child: const Icon(
                Icons.settings_sharp,
                color: Colors.white,
              ),
              label: "TODO",
              labelStyle: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                  fontSize: 14.0),
              backgroundColor: Colors.indigo.shade900,
              labelBackgroundColor: Colors.black.withOpacity(0.0),
              foregroundColor: Colors.black.withOpacity(0.0),
              labelShadow: [],
              onTap: () {}),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }

  /// dragCount 변경
  /// -1: calendar full size, 리스트 제로,
  ///  0: default,
  ///  1: 리스트 full
  void handleVerticalDragEnd(DragEndDetails details) {
    setState(() {
      if (dYPoint - startDYPoint == 0.0) {
        // print('drag zero');
      } else if (dYPoint - startDYPoint > 0.0) {
        print('drag down');
        if (dragCount > -1) dragCount--;
      } else {
        print('drag up');
        if (dragCount < 1) dragCount++;
      }
    });
    print('dragCount: $dragCount');
  }

  void handleVerticalDragUpdate(DragUpdateDetails details) {
    setState(() {
      dragDirection = "VERTICAL UPDATING";
      dXPoint = details.globalPosition.dx.floorToDouble();
      dYPoint = details.globalPosition.dy.floorToDouble();
    });
  }

  void handleVerticalDragStart(DragStartDetails details) {
    setState(() {
      dragDirection = "VERTICAL";
      startDXPoint = details.globalPosition.dx.floorToDouble();
      startDYPoint = details.globalPosition.dy.floorToDouble();
    });
  }
}
