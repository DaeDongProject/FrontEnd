class UserUpdate { // 회원 정보 수정, User와는 chatRoomOid 차이
  String id;
  String name;
  String phoneNumber;
  String schoolEmail;
  String password;
  String schoolName;
  bool pushAlarm;
  bool personalInformation;

  UserUpdate({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.schoolEmail,
    required this.password,
    required this.schoolName,
    required this.pushAlarm,
    required this.personalInformation,
  });

  Map<String, dynamic> toJson(){
    return{
      "_id": id,
      "name": name,
      "phoneNumber": phoneNumber,
      "schoolEmail": schoolEmail,
      "password": password,
      "schoolName": schoolName,
      "pushAlarm": pushAlarm,
      "personalInformation": personalInformation,
    };
  }



}