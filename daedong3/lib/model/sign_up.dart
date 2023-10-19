class SignUp{ // 회원 가입
  String name;
  String phoneNumber;
  String schoolEmail;
  String schoolName;
  String password;
  bool pushAlarm;
  bool personalInformation;

  SignUp({
    required this.name,
    required this.phoneNumber,
    required this.schoolEmail,
    required this.schoolName,
    required this.password,
    required this.pushAlarm,
    required this.personalInformation
  });


  Map<String, dynamic> toJson(){
    return{
      "name": name,
      "phoneNumber": phoneNumber,
      "schoolEmail": schoolEmail,
      "schoolName": schoolName,
      "password": password,
      "pushAlarm": pushAlarm,
      "personalInformation": personalInformation
    };
  }
}