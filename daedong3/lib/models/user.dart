class User {
  String id;
  String name;
  String phoneNumber;
  String schoolEmail;
  String password;
  String schoolName;
  bool pushAlram;
  bool personalInformation;
  List<String> chatRoomOid;

  User({
  required this.id,
  required this.name,
  required this.phoneNumber,
  required this.schoolEmail,
  required this.password,
  required this.schoolName,
  required this.pushAlram,
  required this.personalInformation,
  required this.chatRoomOid
  });


}