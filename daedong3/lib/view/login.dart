import 'package:daedong3/main.dart';
import 'package:daedong3/view/home_page.dart';
import 'package:daedong3/viewmodel/hamburger_view_model.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../viewmodel/chat_view_model.dart';
import '../viewmodel/login_view_model.dart';
import 'package:daedong3/view/join.dart';


class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(primary: Colors.black)
        ),
        // elevatedButtonTheme: ElevatedButtonThemeData(
        //   style: ElevatedButton.styleFrom(primary: Colors.black)
        // )
      ),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget{
  LoginScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    LoginViewModel loginViewModel = Provider.of<LoginViewModel>(context);
    ChatViewModel chatViewModel = Provider.of<ChatViewModel>(context);
    HamburgerViewModel hamburgerViewModel = Provider.of<HamburgerViewModel>(context);

    return WillPopScope(onWillPop: () async => false,
    child: Scaffold(
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

            ButtonBar(
              children: <Widget>[
                TextButton(
                  onPressed: (){
                    Navigator.push(
                        context, MaterialPageRoute(builder: (_)=>
                        JoinScreen()));
                  },
                  child: Text('회원가입'),
                ),
                ElevatedButton( // 로그인 버튼
                  onPressed: () async { // 로그인 버튼 클릭 시
                    if(loginViewModel.isEmailValid(emailController.text)){ // 형식이 올바를 때

                      print("로그인 형식 맞았음\n");

                      // 로그인 실패 시 AlertDialog 띄우기 구현 필요
                      try{
                        await loginViewModel.loginFunc(emailController.text, passwordController.text); // 로그인 요청 보내기

                        // 로그인 성공 시
                        await chatViewModel.requestChatRoomInfo(userId: loginViewModel.user.id); // 입장 시 띄울 채팅방 선택

                        Logger().d("로그인 유저 이름 = ${loginViewModel.user.name}");

                        if(!context.mounted) return; // 비동기 처리 후 navigator 쌓을 때 위젯이 안 쌓이는 것을 방지

                        Navigator.push(
                            context, MaterialPageRoute(builder: (_)=>
                            HomePage()));
                      }catch(e){
                        if(!context.mounted) return;
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("로그인 실패"),
                              content: Text(e.toString().replaceAll("Exception: ", "")), // 실패 이유를 표시
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("확인"),
                                ),
                              ],
                            );
                          },
                        );
                      }


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