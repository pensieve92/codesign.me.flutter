import 'package:flutter/material.dart';
import 'package:me/stores/CalendarStoreV2.dart';
import 'package:provider/provider.dart';

import 'package:me/pages/calendar/CalendarPage.dart';
import 'package:me/pages/calendar/CalendarPageV2.dart';

import 'package:me/stores/CalendarStore.dart';


void main() {
  runApp(GestureDetector(
    onTap: () => {FocusManager.instance.primaryFocus?.unfocus()},
    child: MaterialApp(
      initialRoute: "/",
      theme: ThemeData(
        primaryColor: Colors.black,
            backgroundColor: Colors.black,
            textTheme: TextTheme(
              headline1: TextStyle(color: Colors.white),
              headline2: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              subtitle1: TextStyle(color: Colors.white),
              bodyText1: TextStyle(color: Colors.white),
              bodyText2: TextStyle(color: Colors.white)
            )
      ),
      routes: {
        "/": (context) => ChangeNotifierProvider(create: (context) => CalendarStoreV2(), child: CalendarPageV2()),
        // "/": (context) => ChangeNotifierProvider(create: (context) => CalendarStore(), child: CalendarPage()),
        "/calendar": (context) => MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => CalendarStore())
            ],
            child: CalendarPage()),
      },
    ),
  ));
}