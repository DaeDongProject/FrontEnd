import 'package:flutter/material.dart';
import 'package:daedong3/home_page.dart';
import 'package:intl/intl.dart';
import 'package:bubble/bubble.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          appBarTheme: AppBarTheme(backgroundColor: Colors.lightBlueAccent)
        ),
        debugShowCheckedModeBanner: false,
      home: HomePage(),

    );

  }
}

