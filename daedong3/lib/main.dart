import 'package:flutter/material.dart';
import 'package:daedong3/ui/home_page.dart';
import 'app/data/personal_information.dart';
import 'ui/hamburger/hamburger_menu.dart';


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
      home: HomePage(PersonalInformation('로그인 필요','')),
    );

  }
}

