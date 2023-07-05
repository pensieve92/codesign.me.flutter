import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart'; // 스크롤 다룰때 유용
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:get_it/get_it.dart';
import 'package:me/db/daos/datasource.dart';
import 'package:me/db/tables/DocType.dart';
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
    return Scaffold(
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
      bottomSheet:
          Container(color: Colors.red, height: 40, child: createFooter()),
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
      onTap: () => {},
      decoration: InputDecoration(
          filled: true,
          suffixIcon: ElevatedButton(
              onPressed: () => {},
              child: flagKeyBoard
                  ?
                  // 키보드가 올라온 경우, 저장
                  IconButton(
                      alignment: Alignment.topLeft,
                      icon: Icon(
                        Icons.done_outline,
                        size: 30,
                      ),
                      onPressed: () async =>  {
                        print('save button'),
                        // TODO 저장로직 개발
                        // TODO SQLite 추가하기
                        await GetIt.I<LocalDataBase>().docTypeDao.createDocTypeGroup(
                            DocTypeGroupCompanion(
                                typeGroupId: Value('2'),
                                typeGroupNm: Value('BASE2'),
                                useYn: Value('N')
                            )
                        ),

                      },
                    )
                  // 키보드가 들어간 경우, Dialog 띄우기
                  : DialogExample()
              // IconButton(
              //   onPressed: () => {
              //     print('open dialog button'),
              //   },
              //   icon: Icon(size: 30, Icons.add_box_rounded)
              // )
              )),
      controller: textEditingController,
    );
  }
}
