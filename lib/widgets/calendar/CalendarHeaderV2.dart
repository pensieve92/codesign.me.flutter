import 'package:flutter/material.dart';
import 'package:me/utils/CalendarUtil.dart';
import 'package:provider/provider.dart';

import '../../stores/CalendarStoreV2.dart';

class CalendarHeaderV2 extends StatelessWidget implements PreferredSizeWidget {
  const CalendarHeaderV2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var store = context.watch<CalendarStoreV2>();
    DateTime thisMonth =  store.thisMonth;

    return AppBar(
      // leading: IconButton(
      //   onPressed: () {
      //     print('click menu icon');
      //   },
      //   icon: Icon(Icons.menu_rounded),
      // ),
      title: ElevatedButton(
        onPressed: () {
          print('show modal');
        },
        style: ElevatedButton.styleFrom(
          fixedSize: Size(100, 45),
          backgroundColor: Theme.of(context).backgroundColor,
          textStyle: TextStyle(fontSize: 20),
          padding: EdgeInsets.only(left: 0),
        ),
        child: Row(
          children: [
            Text(CalendarUtil.getYYYYMM(thisMonth)),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('오늘', style: Theme.of(context).textTheme.headline2),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.grey,
                )
              ]),
          // onPressed: () => context.read<CalendarStore>().setToday(),
          onPressed: () => {
            // TODO 캘린더 생성후 개발 예정
          },
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

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
