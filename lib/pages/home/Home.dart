import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var list = ['2022.10', '2022.11', '2022.12', '2023.01'];

  var YYYYMM = '2022.11';

  setYearMonth(value) {
    setState(() {
      print(value);
      YYYYMM = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              onPressed: () {
                print('click 오늘');
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
        title: DropdownButton<String?>(
          style: TextStyle(color: Colors.white),
          items: list.map<DropdownMenuItem<String?>>((String? i) {
            return DropdownMenuItem<String?>(
              value: i,
              child: Text(i.toString()),
            );
          }).toList(),
          value: YYYYMM,
          onChanged: (value) => setYearMonth(value),
        ),
        backgroundColor: Colors.black,
      ),
      body: Text('Body'),
    );
  }
}
