class User {
  String id;
  String name;
  String phoneNumber;
  String schoolEmail;
  String password;
  String schoolName;
  bool pushAlarm;
  bool personalInformation;
  List<String> chatRoomOid;

  User({
  required this.id,
  required this.name,
  required this.phoneNumber,
  required this.schoolEmail,
  required this.password,
  required this.schoolName,
  required this.pushAlarm,
  required this.personalInformation,
  required this.chatRoomOid
  });



  Map<String, dynamic> toJson(){
    return{
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'schoolEmail': schoolEmail,
      'password': password,
      'schoolName': schoolName,
      'pushAlarm': pushAlarm,
      'personalInformation': personalInformation,
      'chatRoomOid': chatRoomOid,
    };
  }

}