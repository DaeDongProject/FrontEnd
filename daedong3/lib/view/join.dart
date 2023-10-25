//회원가입
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../personal_information.dart';
import 'package:flutter/material.dart';
import 'package:daedong3/view/login.dart';

import '../viewmodel/login_view_model.dart';

class  Join extends StatelessWidget {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final password_check_Controller = TextEditingController();
  final nameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final schoolController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    LoginViewModel loginViewModel = Provider.of<LoginViewModel>(context);
    //ChatViewModel chatViewModel = Provider.of<ChatViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입'),
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
//이전 페이지로 돌아가기
          },
        ),
      ),
      backgroundColor: Colors.lightBlueAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 70,),
          Row(
            children: [
              Expanded(
                child: ListTile(
                  //title: Text('이름',style: TextStyle(color: Colors.black38)),
                  subtitle: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(width: 1, color: Colors.white),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      hintText: '이름',
                      hintStyle: TextStyle(color: Colors.black26),

                    ),
                  ),
                ),
              ),
              SizedBox(width: 5,),

              Expanded(
                child:ListTile(
                  //title: Text('학교',style: TextStyle(color: Colors.black38),),
                  subtitle:  TextFormField(
                    controller: schoolController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(width: 1, color: Colors.white),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      hintText: '학교',
                      hintStyle: TextStyle(color: Colors.black26),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.all(17),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: phoneNumberController,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: '전화번호',
                    hintText: '010-xxxx-xxxx',
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
                SizedBox(height: 24,),
                Divider(color: Colors.white,),
                SizedBox(height: 12,),

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

                TextField(
                  controller: password_check_Controller,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    labelText: 'password',
                    hintText: '비밀번호를 한번더 입력하세요',
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

                SizedBox(height: 12,),
                Divider(color: Colors.white,),
                SizedBox(height: 12,),

                ButtonBar(
                  children: <Widget>[

                    ElevatedButton(
                      onPressed: () async {
                        if(loginViewModel.isEmailValid(emailController.text) &&
                        passwordController.text == password_check_Controller.text){ // 형식이 올바를 때

                          print("회원가입 가능\n");
                          //await loginViewModel.loginFunc(emailController.text, passwordController.text);

                          //Logger().d("로그인 유저 아이디 = ${loginViewModel.user.id}");
                          //회원가입시 칸에 있는 정보를 넘기는 view_model 필요할듯


                          Navigator.push(
                              context, MaterialPageRoute(builder: (_)=>
                              LoginScreen()));
                        }
                        else if (
                        !(loginViewModel.isEmailValid(emailController.text)) &&
                        passwordController.text == password_check_Controller.text){
                          showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return AlertDialog( // 이메일의 형식이 틀렸을 때 실패 팝업 띄우기
                                  title: Text("회원가입 실패!"),
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
                        }
                        else if(loginViewModel.isEmailValid(emailController.text) &&
                        passwordController.text != password_check_Controller.text){
                          showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return AlertDialog( // 비밀번호가 일치하지 않을때
                                  title: Text("회원가입 실패!"),
                                  content: Text("비밀번호가 일치하지 않습니다."),
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
                        }
                        if( emailController.text == '' ||
                            passwordController.text == '' ||
                            password_check_Controller.text == '' ||
                            nameController.text == '' ||
                            schoolController.text == '' ||
                            phoneNumberController.text == ''
                        ){//이메일 유효검사랑 알림 중복이 됨 해결할게..
                          showDialog(
                              context: context,
                              builder: (BuildContext context){
                                return AlertDialog( // 공백이 존재할때
                                  title: Text("회원가입 실패!"),
                                  content: Text("모든 항목의 작성이 필요합니다."),
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
                        }
                      },
                      child: Text('회원가입'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
