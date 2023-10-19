//회원가입
import '../personal_information.dart';
import 'package:flutter/material.dart';
import 'package:daedong3/view/login.dart';

class  Join extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(primary: Colors.black)
        ),

      ),
      debugShowCheckedModeBanner: false,
      home: JoinScreen(),
    );
  }
}
class JoinScreen extends StatefulWidget {

  @override
  State<JoinScreen> createState() => _JoinScreenState();
}

class _JoinScreenState extends State<JoinScreen> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final password_check_Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Container(
        margin: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            TextField(
              controller: emailController,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                labelText: 'email',
                hintText: '이메일를 입력하세요',
                hintStyle: TextStyle(color: Colors.black26),
                labelStyle: TextStyle(color: Colors.black26),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(width: 1, color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(width: 1, color: Colors.white),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
            SizedBox(height: 12.0,),

            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'password',
                hintText: '비밀번호를 입력하세요',
                hintStyle: TextStyle(color: Colors.black26),
                labelStyle: TextStyle(color: Colors.black26),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(width: 1, color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(width: 1, color: Colors.white),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              obscureText: true,
            ),

            SizedBox(height: 12.0,),

            TextField(
              controller: password_check_Controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'password',
                hintText: '비밀번호를 한번더 입력하세요',
                hintStyle: TextStyle(color: Colors.black26),
                labelStyle: TextStyle(color: Colors.black26),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(width: 1, color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(width: 1, color: Colors.white),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              obscureText: true,
            ),

            SizedBox(height: 12.0,),

            ButtonBar(
              children: <Widget>[

                ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_)=>
                        LoginScreen()));
                  },//매개변수를 설정해서 홈페이지에 보내야함
                  child: Text('회원가입'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

