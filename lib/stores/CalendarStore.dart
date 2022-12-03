import 'package:flutter/material.dart';

class CalendarStore extends ChangeNotifier {
  var yearMonthList = ['2022.11', '2022.12', '2023.01', '2023.02'];
  var selectedYearMonth;

  CalendarStore(): selectedYearMonth = '2022.12';

  setYearMonth(String? value) {
    selectedYearMonth = value;
    notifyListeners();
  }
}
