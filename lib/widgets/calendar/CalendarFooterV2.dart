import 'package:flutter/material.dart';
import 'package:me/utils/CalendarUtil.dart';
import 'package:provider/provider.dart';
import 'package:me/utils/commonUtil.dart';

import '../../stores/CalendarStoreV2.dart';

class CalendarFooterV2 extends StatefulWidget {
  const CalendarFooterV2({Key? key}) : super(key: key);

  @override
  State<CalendarFooterV2> createState() => _CalendarFooterV2State();
}

class _CalendarFooterV2State extends State<CalendarFooterV2> {
  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            controller: _textEditingController,
            onSubmitted: (value)  => {
              // 키보드에 오른쪽아래 v 버튼클릭 이벤트
              print('onSubmitted : $value'),
            },
            textInputAction: TextInputAction.done,
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

              // context.read<CalendarStore>().addCount2();

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
              : IconButton(icon: Icon(Icons.add),
                onPressed: () {
                  // TODO 상세 입력폼 나오게 분리하기
                  print('click add butotn ');
                },
          ),
        ),
      ],
    );
  }
}
