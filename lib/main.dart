import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:me/pages/calendar/Calendar.dart';
import 'package:me/pages/home/Home.dart';

import 'package:me/stores/CalendarStore.dart';


void main() {
  runApp(MaterialApp(
    initialRoute: "/",
    routes: {
      "/": (context) => ChangeNotifierProvider(create: (context) => CalendarStore(), child: Home()),
      "/calendar": (context) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => CalendarStore())
          ],
          child: Calendar()),
    },
  ));
}