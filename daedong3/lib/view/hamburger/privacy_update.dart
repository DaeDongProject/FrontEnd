import 'package:daedong3/view/login.dart';
import 'package:daedong3/viewmodel/hamburger_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mongodb_realm/database/database.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../../config/sp_helper.dart';

import '../../viewmodel/login_view_model.dart';

class PrivacyUpdate extends StatefulWidget {
  PrivacyUpdate({super.key});

  @override
  State<PrivacyUpdate> createState() => _PrivacyUpdateState();
}

class _PrivacyUpdateState extends State<PrivacyUpdate> {
  @override
  Widget build(BuildContext context) {
    LoginViewModel loginViewModel =
        Provider.of<LoginViewModel>(context, listen: false);
    HamburgerViewModel hamburgerViewModel =
        Provider.of<HamburgerViewModel>(context);

    final SPHelper helper = SPHelper();

    final _formKey =
        GlobalKey<FormState>(); // TextFormField validation을 위한 글로벌키 등록

    // 유저 정보를 담을 임시 변수, validation 후 onPress() 에서 user에 담겨 넘어감
    String textName = loginViewModel.user.name;
    String textEmail = loginViewModel.user.schoolEmail;
    String textPassword = "";
    String textPhoneNumber = loginViewModel.user.phoneNumber;
    String textSchool = loginViewModel.user.schoolName;

    String passwordForDelete = "";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text("개인정보 수정"),
        centerTitle: true,
        leading: InkWell(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "이름      ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      // 이름 입력 Form
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        contentPadding: EdgeInsets.all(8.0),
                      ),
                      initialValue: textName,
                      autovalidateMode: AutovalidateMode.always,
                      onSaved: (value) {
                        setState(() {
                          textName = value as String;
                        });
                      },
                      validator: (value) {
                        // 사용자 이름 입력 값에 따른 검증 조건식
                        if (value == null || value.isEmpty) {
                          // 공백일 때
                          return "이름은 필수 입력 사항입니다.";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "이메일   ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      // 이메일 입력 Form
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        contentPadding: EdgeInsets.all(8.0),
                      ),
                      initialValue: textEmail,
                      autovalidateMode: AutovalidateMode.always,
                      onChanged: (value) {
                        textEmail = value;
                      },
                      onSaved: (value) {
                        setState(() {
                          textEmail = value as String;
                        });
                      },
                      validator: (value) {
                        // 사용자 이메일 입력 값에 따른 검증 조건식
                        if (value == null || value.isEmpty) {
                          // 공백일 때
                          return "이메일은 필수 입력 사항입니다.";
                        }
                        if (!loginViewModel.isEmailValid(value)) {
                          return "이메일 형식이 올바르지 않습니다.";
                        }
                        // if(!loginViewModel.emailChecking){
                        //   return "이미 사용 중인 이메일입니다.";
                        // }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "비밀번호",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      // 비밀번호 입력 Form
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        contentPadding: EdgeInsets.all(8.0),
                      ),
                      // initialValue: loginViewModel.user.password,
                      obscureText: true,
                      autovalidateMode: AutovalidateMode.always,
                      onChanged: (value) {
                        textPassword = value;
                      },
                      onSaved: (value) {
                        setState(() {
                          textPassword = value as String;
                        });
                      },
                      validator: (value) {
                        // 사용자 비밀번호 입력 값에 따른 검증 조건식
                        if (value == null || value.isEmpty) {
                          // 공백일 때
                          return "비밀번호는 필수 입력 사항입니다.";
                        }
                        if (value.length < 4) {
                          return "비밀번호는 4자리 이상이어야합니다.";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "비밀번호\n 재확인",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      // 비밀번호 재확인 입력 Form
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        contentPadding: EdgeInsets.all(8.0),
                      ),
                      obscureText: true,
                      autovalidateMode: AutovalidateMode.always,

                      validator: (value) {
                        // 사용자 비밀번호 재입력 값에 따른 검증 조건식
                        if (value == null || value.isEmpty) {
                          return "비밀번호를 입력해주세요.";
                        }
                        if (value != textPassword) {
                          // 비밀번호와 값이 다를 때
                          return "비밀번호가 일치하지 않습니다.";
                        }
                        return null;
                      },
                     // textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "전화번호",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      // 전화번호 입력 Form
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        contentPadding: EdgeInsets.all(8.0),
                      ),
                      initialValue: textPhoneNumber,
                      autovalidateMode: AutovalidateMode.always,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(11),
                      ],
                      onSaved: (value) {
                        setState(() {
                          textPhoneNumber = value as String;
                        });
                      },
                      validator: (value) {
                        // 사용자 전화번호 입력 값에 따른 검증 조건식
                        if (value == null || value.isEmpty) {
                          return "전화번호를 입력해주세요.";
                        }
                        if (value.contains('-')) {
                          return "숫자만 입력해주세요.";
                        }
                        if (value.length != 11) {
                          return "전화번호 11자리를 입력해주세요.";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "대학교    ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  SizedBox(
                    width: 300,
                    child: TextFormField(
                      // 대학교 입력 Form
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        contentPadding: EdgeInsets.all(8.0),
                      ),
                      initialValue: textSchool,
                      autovalidateMode: AutovalidateMode.always,
                      onSaved: (value) {
                        setState(() {
                          textSchool = value as String;
                        });
                      },
                      validator: (value) {
                        // 사용자 대학교 입력 값에 따른 검증 조건식
                        if (value == null || value.isEmpty) {
                          return "대학교 이름을 입력해주세요.";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                buttonPadding: EdgeInsets.all(10),
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("취소")),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (textEmail != loginViewModel.user.schoolEmail) {
                          await loginViewModel.checkDuplicatedEmail(textEmail);
                        }

                        Logger().d("뷰에서 체크 ${textPassword}");

                        if (loginViewModel.emailChecking) {
                          // 중복되지 않은 경우에만 폼 검증
                          if (_formKey.currentState!.validate()) {
                            // 검증이 모두 통과된다면
                            _formKey.currentState!
                                .save(); // onSaved() 함수를 호출해서 변수 값 저장시키기

                            Logger().d(
                                "이름 $textName, 이메일 $textEmail, 비밀번호 $textPassword, 전화번호 $textPhoneNumber");

                            if (!context.mounted) return;
                            await hamburgerViewModel.updateUser(
                                context,
                                loginViewModel.user.id,
                                textName,
                                textEmail,
                                textPassword,
                                textPhoneNumber,
                                textSchool,
                                loginViewModel.user.pushAlarm,
                                loginViewModel.user.personalInformation,
                                loginViewModel.user.chatRoomOid);

                            if (!context.mounted) return;
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("알림"),
                                    content: Text("정보 수정 완료"),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.pop(context);
                                          },
                                          child: Text("확인"))
                                    ],
                                  );
                                });
                          }
                        } else {
                          // 이메일이 중복된 경우 팝업 창 알림
                          if (!context.mounted) return;
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("수정 실패"),
                                  content: Text("이미 사용 중인 이메일입니다."),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("확인"))
                                  ],
                                );
                              });
                        }
                      },
                      child: Text("수정")),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton( // 회원 탈퇴 버튼
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context){
                              return AlertDialog(
                                title: Text("회원 탈퇴"),
                                content: TextField(
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    filled: true,
                                    hintText: "비밀번호를 입력하세요",
                                    hintStyle: TextStyle(color: Colors.black26),
                                  ),
                                  obscureText: true,
                                  onChanged: (value){
                                    setState(() {
                                      passwordForDelete = value;
                                      Logger().d(passwordForDelete);
                                    });
                                  },
                                ),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () async {
                                        Logger().d(loginViewModel.userPassword);
                                        if(passwordForDelete == loginViewModel.userPassword){ // 입력 비밀번호가 유저 비밀번호와 같을 때 회원 탈퇴
                                          await hamburgerViewModel.deleteUser(loginViewModel.user);

                                          if(!context.mounted) return;
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context){
                                                return AlertDialog(
                                                  content: Text("탈퇴 성공"),
                                                  actions: [
                                                    ElevatedButton(
                                                      onPressed: (){
                                                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                                          builder: (BuildContext context) =>
                                                            LoginScreen()), (route) => false
                                                        );},
                                                      child: Text("확인"),
                                                    )
                                                  ],
                                                );
                                              }
                                          );
                                        }else{
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context){
                                              return AlertDialog(
                                                content: Text("비밀번호 틀림"),
                                                actions: [
                                                  ElevatedButton(
                                                    onPressed: (){
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("확인"),
                                                  )
                                                ],
                                              );
                                            }
                                          );
                                        }
                                      },
                                      child: Text("탈퇴"))
                                ],
                              );
                            });
                      },
                      child: Text("탈퇴"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
