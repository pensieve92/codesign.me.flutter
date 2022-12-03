import 'package:flutter/material.dart';
import 'package:me/pages/calendar/Calendar.dart';
import 'package:me/pages/home/Home.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: "/",
    routes: {
      "/": (context) => Home(),
      "/calendar": (context) => Calendar(),
    },
  ));
}