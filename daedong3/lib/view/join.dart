//회원가입
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:daedong3/view/login.dart';
import '../viewmodel/login_view_model.dart';

class  Join extends StatefulWidget {

  @override
  State<Join> createState() => _JoinState();
}

class _JoinState extends State<Join> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final password_check_Controller = TextEditingController();

  final nameController = TextEditingController();

  final phoneNumberController = TextEditingController();

  final schoolController = TextEditingController();

  final  _formKey = GlobalKey<FormState>();

  String textName = "";
  String textEmail = "";
  String textPassword = "";
  String textSchool = "";
  String textPhoneNumber = "";

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
            Navigator.pop(context);//이전 페이지로 돌아가기
          },
        ),
      ),
      backgroundColor: Colors.lightBlueAccent,
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 70,),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    //title: Text('이름',style: TextStyle(color: Colors.black38)),
                    subtitle: TextFormField(
                      // controller: nameController,
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onSaved: (value){
                        setState(() {
                          textName = value as String;
                        });
                      },
                      validator: (val){
                        if(val == null || val.isEmpty){
                          return "이름은 필수 입력 사항입니다.";
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(width: 5,),

                Expanded(
                  child:ListTile(
                    //title: Text('학교',style: TextStyle(color: Colors.black38),),
                    subtitle:  TextFormField(
                      // controller: schoolController,
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      onSaved: (value){
                        setState(() {
                          textSchool = value as String;
                        });
                      },
                      validator: (value){
                        if(value == null || value.isEmpty){
                          return "학교명을 입력해주세요.";
                        }
                        return null;
                      },
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
                  TextFormField(
                    // controller: phoneNumberController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      labelText: '전화번호',
                      hintText: '01012345678',
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(11),
                    ],
                    onSaved: (value){
                      setState(() {
                        textPhoneNumber = value as String;
                      });
                    },
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "전화번호 11자리를 입력해주세요.";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 24,),
                  Divider(color: Colors.white,),
                  SizedBox(height: 12,),

                  TextFormField(
                    // controller: emailController,
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
                    autovalidateMode: AutovalidateMode.always,
                    onChanged: (value){
                      textEmail = value;
                    },
                    onSaved: (value){
                      setState(() {
                        textEmail = value as String;
                      });
                    },
                    validator: (value) { // 사용자 이메일 입력 값에 따른 검증 조건식
                      if(value == null || value.isEmpty){ // 공백일 때
                        return "이메일은 필수 입력 사항입니다.";
                      }
                      if(!loginViewModel.isEmailValid(value)){
                        return "이메일 형식이 올바르지 않습니다.";
                      }
                      Logger().d("textEmail = $textEmail");
                      return null;
                    },
                  ),
                  SizedBox(height: 12.0,),

                  TextFormField(
                    // controller: passwordController,
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    onChanged: (value){
                      textPassword = value;
                    },
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "비밀번호를 입력해주세요";
                      }
                      if(value.length < 4){
                        return "비밀번호 4자리 이상 입력해주세요.";
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 12.0,),

                  TextFormField(
                    // controller: password_check_Controller,
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
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "비밀번호를 입력해주세요.";
                      }
                      if(value != textPassword){
                        return "비밀번호가 일치하지 않습니다.";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 12,),
                  Divider(color: Colors.white,),
                  SizedBox(height: 12,),

                  ButtonBar(
                    children: <Widget>[

                      ElevatedButton(
                        onPressed: () async {
                          await loginViewModel.checkDuplicatedEmail(textEmail); // 이메일 중복이라면 이메일 validator에서 검증

                          if(loginViewModel.emailChecking){ // 중복되지 않은 경우에만 폼 검증
                            if(_formKey.currentState!.validate()){
                              _formKey.currentState!.save();

                              if(!context.mounted) return;
                              bool signupResponse = await loginViewModel.signup(textName, textPhoneNumber,
                                textEmail, textSchool, textPassword, true, true);

                              if(!context.mounted) return;
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context){
                                    return AlertDialog(
                                      title: Text("회원 가입 성공"),
                                      actions: [
                                        ElevatedButton(
                                            onPressed: (){
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                            },
                                            child: Text("확인"))
                                      ],
                                    );
                                  });
                            }
                          }else{ // 중복된 이메일인 경우 팝업 창 알림
                            if(!context.mounted) return;
                            showDialog(
                                context: context,
                                builder: (BuildContext context){
                                  return AlertDialog(
                                    title: Text("수정 실패"),
                                    content: Text("이미 사용 중인 이메일입니다."),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: (){
                                            Navigator.pop(context);
                                          },
                                          child: Text("확인"))
                                    ],
                                  );
                                });
                          }


                          // if(loginViewModel.isEmailValid(emailController.text) &&
                          // passwordController.text == password_check_Controller.text){ // 형식이 올바를 때
                          //
                          //   print("회원가입 가능\n");
                          //   //await loginViewModel.loginFunc(emailController.text, passwordController.text);
                          //
                          //   //Logger().d("로그인 유저 아이디 = ${loginViewModel.user.id}");
                          //   //회원가입시 칸에 있는 정보를 넘기는 view_model 필요할듯
                          //   Navigator.push(
                          //       context, MaterialPageRoute(builder: (_)=>
                          //       LoginScreen()));
                          // }
                          // else if (
                          // !(loginViewModel.isEmailValid(emailController.text)) &&
                          // passwordController.text == password_check_Controller.text){
                          //   showDialog(
                          //       context: context,
                          //       builder: (BuildContext context){
                          //         return AlertDialog( // 이메일의 형식이 틀렸을 때 실패 팝업 띄우기
                          //           title: Text("회원가입 실패!"),
                          //           content: Text("이메일 형식이 아닙니다."),
                          //           actions: <Widget>[
                          //             ElevatedButton(
                          //               child: Text("확인"),
                          //               onPressed: (){
                          //                 Navigator.pop(context);
                          //               },
                          //             )
                          //           ],
                          //         );
                          //       }
                          //   );
                          // }
                          // else if(loginViewModel.isEmailValid(emailController.text) &&
                          // passwordController.text != password_check_Controller.text){
                          //   showDialog(
                          //       context: context,
                          //       builder: (BuildContext context){
                          //         return AlertDialog( // 비밀번호가 일치하지 않을때
                          //           title: Text("회원가입 실패!"),
                          //           content: Text("비밀번호가 일치하지 않습니다."),
                          //           actions: <Widget>[
                          //             ElevatedButton(
                          //               child: Text("확인"),
                          //               onPressed: (){
                          //                 Navigator.pop(context);
                          //               },
                          //             )
                          //           ],
                          //         );
                          //       }
                          //   );
                          // }
                          // if( emailController.text == '' ||
                          //     passwordController.text == '' ||
                          //     password_check_Controller.text == '' ||
                          //     nameController.text == '' ||
                          //     schoolController.text == '' ||
                          //     phoneNumberController.text == ''
                          // ){//이메일 유효검사랑 알림 중복이 됨 해결할게..
                          //   showDialog(
                          //       context: context,
                          //       builder: (BuildContext context){
                          //         return AlertDialog( // 공백이 존재할때
                          //           title: Text("회원가입 실패!"),
                          //           content: Text("모든 항목의 작성이 필요합니다."),
                          //           actions: <Widget>[
                          //             ElevatedButton(
                          //               child: Text("확인"),
                          //               onPressed: (){
                          //                 Navigator.pop(context);
                          //               },
                          //             )
                          //           ],
                          //         );
                          //       }
                          //   );
                          // }
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
      ),
    );
  }
}
