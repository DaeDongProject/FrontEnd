import 'package:daedong3/main.dart';
import 'package:daedong3/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../viewmodel/chat_view_model.dart';
import '../viewmodel/login_view_model.dart';
import 'package:daedong3/view/join.dart';


class LoginScreen extends StatelessWidget{
  LoginScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    LoginViewModel loginViewModel = Provider.of<LoginViewModel>(context);
    ChatViewModel chatViewModel = Provider.of<ChatViewModel>(context);

    return WillPopScope(onWillPop: () async => false,
    child: Scaffold(

      backgroundColor: Colors.lightBlueAccent,
      body: Container(

        margin: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('로그인',style: TextStyle(fontSize: 24.0),),

            SizedBox(height: 36,),

            TextField(
              controller: emailController,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                labelText: 'email',
                hintText: '이메일를 입력하세요',
                hintStyle: TextStyle(color: Colors.black26),
                labelStyle: TextStyle(color: Colors.black26),
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
                TextButton(
                  onPressed: (){
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_)=>
                        Join()));
                  },
                  child: Text('회원가입'),
                ),
                ElevatedButton( // 로그인 버튼
                  onPressed: () async { // 로그인 버튼 클릭 시
                    if(loginViewModel.isEmailValid(emailController.text)){ // 형식이 올바를 때

                      print("로그인 형식 맞았음\n");
                      await loginViewModel.loginFunc(emailController.text, passwordController.text); // 로그인 요청 보내기

                      Logger().d("로그인 유저 아이디 = ${loginViewModel.user.id}");

                      // 로그인 실패 시 AlertDialog 띄우기 구현 필요

                      // 로그인 성공 시
                      

                      Navigator.push(
                          context, MaterialPageRoute(builder: (_)=>
                          HomePage()));
                    }else{
                      showDialog(
                          context: context,
                          builder: (BuildContext context){
                            return AlertDialog( // 이메일의 형식이 틀렸을 때 실패 팝업 띄우기
                              title: Text("로그인 실패!"),
                              content: Text("이메일 형식이 아닙니다."),
                              actions: <Widget>[
                                ElevatedButton(
                                  child: Text("확인"),
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            );
                          }
                      );
                      print("로그인 형식 틀렸음");

                    }
                  },//매개변수를 설정해서 홈페이지에 보내야함
                  child: Text('로그인'),
                ),
              ],
            )
          ],
        ),
      ),
    ),
    );
  }
}