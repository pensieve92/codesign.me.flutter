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

    return AppBar(title: Text(CalendarUtil.getYYYYMM(thisMonth)));
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
