import 'package:daedong3/personal_information.dart';
import 'package:daedong3/viewmodel/hamburger_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../config/sp_helper.dart';
import 'package:daedong3/personal_information.dart';
import 'package:flutter/material.dart';

import '../../viewmodel/login_view_model.dart';

class PrivacyUpdate extends StatefulWidget{
  PrivacyUpdate({super.key});

  @override
  State<PrivacyUpdate> createState() => _PrivacyUpdateState();
}

class _PrivacyUpdateState extends State<PrivacyUpdate> {
  @override
  Widget build(BuildContext context) {

    LoginViewModel loginViewModel = Provider.of<LoginViewModel>(context);
    HamburgerViewModel hamburgerViewModel = Provider.of<HamburgerViewModel>(context);

    final TextEditingController nameController = TextEditingController(); // 사용자 이름 입력 Controller
    final TextEditingController emailController = TextEditingController(); // 사용자 이메일 입력 Controller
    final TextEditingController passwordController = TextEditingController(); // 사용자 비밀번호 입력 Controller
    final SPHelper helper = SPHelper();

    final _formKey = GlobalKey<FormState>(); // TextFormField validation을 위한 글로벌키 등록

    // 유저 정보를 담을 임시 변수, validation 후 onPress() 에서 user에 담겨 넘어감
    String textName = loginViewModel.user.name;
    String textEmail = loginViewModel.user.schoolEmail;
    String textPassword='';
    String textUniversity='';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text("개인정보 수정"),
        centerTitle: true,
        leading: InkWell(
          child: Icon(Icons.arrow_back),
          onTap: (){
            Navigator.pop(context);
          },
        ),
      ),
        body: Form(
          key: _formKey,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 8,),
                      Text("이름", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontStyle: FontStyle.normal,
                      ),),
                      SizedBox(width: 8,),
                      SizedBox(
                        width: 300,
                        child: TextFormField(// 이름 입력 Form
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: loginViewModel.user.name,
                            isDense: true,
                            contentPadding: EdgeInsets.all(8.0),
                          ),
                          initialValue: loginViewModel.user.name,
                          autovalidateMode: AutovalidateMode.always,
                          onSaved: (nameController){
                            setState(() {
                              textName = nameController as String;
                            });
                          },
                          validator: (nameController){ // 사용자 이름 입력 값에 따른 검증 조건식
                            if(nameController == null || nameController.isEmpty){ // 공백일 때
                              return "이름은 필수 입력 사항입니다.";
                            }
                            return null;
                          },
                          readOnly: hamburgerViewModel.isEditName,
                        ),
                      ),
                      SizedBox(width: 8,),
                      ElevatedButton(
                          child: Text("이름 변경"),
                          onPressed: (){
                            hamburgerViewModel.editName();
                          })
                    ],
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: TextFormField( // 이메일 입력 Form
                        decoration: InputDecoration(
                          hintText: loginViewModel.user.schoolEmail,
                          labelText: "이메일",
                        ),
                        autovalidateMode: AutovalidateMode.always,
                        onSaved: (emailController){
                          setState(() {
                            textEmail = emailController as String;
                          });
                        },
                        validator: (emailController){ // 사용자 이메일 입력 값에 따른 검증 조건식
                          if(emailController == null || emailController.isEmpty){ // 공백일 때
                            return "이메일은 필수 입력 사항입니다.";
                          }
                          if(!loginViewModel.isEmailValid(emailController)){ // 이메일 형식이 아닐 때
                            return "이메일 형식이 아닙니다.";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "비밀번호",
                        ),
                        autovalidateMode: AutovalidateMode.always,
                        obscureText: true, // 비밀번호 입력 시 문자를 '*'로 표시
                        onSaved: (passwordController){
                          setState(() {
                            textPassword = passwordController as String;
                          });
                        },
                        validator: (passwordController){
                          if(passwordController == null || passwordController.isEmpty) { // 공백일 때
                            return "비밀번호는 필수 입력 사항입니다.";
                          }
                          if(passwordController.length >= 4){
                            return "비밀번호는 최소 4자리 이상이어야 합니다.";
                          }
                          return null;
                        },
                      ),
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