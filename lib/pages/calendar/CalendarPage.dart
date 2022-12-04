import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../stores/CalendarStore.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CalendarAppBar(context),
      body: Text('Body'), // TODO Calendar 만들기
    );
  }

  AppBar CalendarAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          print('click menu icon');
        },
        icon: Icon(Icons.menu_rounded),
      ),
      actions: [
        TextButton(
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('오늘',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey, )]),
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
      title: DropdownButton<String>( // TODO Calendar Popup띄우기
        style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        items: context.watch<CalendarStore>().yearMonthList.map<DropdownMenuItem<String>>((String item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        value: context.watch<CalendarStore>().selectedYearMonth,
        onChanged: (value) => context.read<CalendarStore>().setYearMonth(value),
      ),
      backgroundColor: Colors.black,
    );
  }
}
