import 'package:daedong3/view/home_page.dart';
import 'package:flutter/material.dart';
import 'personal_information.dart';


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

