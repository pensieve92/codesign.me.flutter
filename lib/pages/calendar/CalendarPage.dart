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
      title: ElevatedButton(
        onPressed: (){
          print('show modal');
        },
        style: ElevatedButton.styleFrom(
          fixedSize: Size(130, 45),
          backgroundColor: Colors.black,
          textStyle: TextStyle(fontSize: 20),
          padding: EdgeInsets.only(left: 0),
        ),
        child: Row(
          children: [Text(context.watch<CalendarStore>().selectedYearMonth), Icon(Icons.arrow_drop_down)],
        ),
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
      backgroundColor: Colors.black,
    );
  }
}
