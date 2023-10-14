
import 'package:flutter/material.dart';
import '../model/login.dart';
import '../model/user.dart';
import '../repository/repository.dart';

class LoginViewModel with ChangeNotifier{
  late final Repository _repository;

  bool emailValidator = false; // 로그인 아이디 유효 확인 변수
  bool passwordValidator = false; // 로그인 비밀번호 유효 확인 변수

  bool loginValidator = false; // 위 두 개를 검사해서 이 변수로 로그인 버튼 활성화.

  late User user;

  // 이메일의 형식이 유효한지 검사하는 함수
  isEmailValid(String email){

    RegExp emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$'); // 이메일 유효성을 검사하는 정규 표현식

    // 정규 표현식과 User가 타이핑한 email이 부합하다면 true 값 할당
    if(emailRegExp.hasMatch(email)){
      emailValidator = true;
    }else{
      emailValidator = false;
    }

    isLoginValid();
  }

  // 비밀번호의 형식이 유효한지 검사하는 함수
  isPasswordValid(String password){

    // User가 타이핑한 비밀번호가 4자리 이상이라면 true 값 할당
    if(password.length >= 4){
      passwordValidator = true;
    }

    isLoginValid();
  }

  // 이메일과 비밀번호가 모두 유효한지 검사하는 함수(로그인 버튼 활성화 목적)
  isLoginValid(){
    if(emailValidator && passwordValidator == true){
      loginValidator = true;
    }else{
      loginValidator = false;
    }

    notifyListeners();
  }

  // 입력된 정보로 로그인하는 함수
  Future login(String email, String password) async {
    Login loginQuery = Login(schoolEmail: email, password: password);

    user = await _repository.login(loginQuery);

    notifyListeners();
  }
}