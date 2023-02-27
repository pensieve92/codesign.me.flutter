import 'package:flutter/material.dart';
import 'package:me/stores/CalendarStoreV2.dart';
import 'package:provider/provider.dart';

import 'package:me/pages/calendar/CalendarPage.dart';
import 'package:me/pages/calendar/CalendarPageV2.dart';

import 'package:me/stores/CalendarStore.dart';


void main() {
  runApp(MaterialApp(
    initialRoute: "/",
    routes: {
      "/": (context) => ChangeNotifierProvider(create: (context) => CalendarStoreV2(), child: CalendarPageV2()),
      "/calendar": (context) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => CalendarStore())
          ],
          child: CalendarPage()),
    },
  ));
}