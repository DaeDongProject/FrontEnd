

import 'package:daedong3/model/context.dart';

class ChatRoom {
  String id;
  String userId;
  String chatTitle;
  List<Context> contextUser;
  bool deleteYn;

  ChatRoom({
    required this.id,
    required this.userId,
    required this.chatTitle,
    required this.contextUser,
    required this.deleteYn
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json){
    return ChatRoom(
      id: json["id"],
      userId: json["userId"],
      chatTitle: json["chatTitle"],
      contextUser: json["contextUser"],
      deleteYn: json["deleteYn"],
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'id': id,
      'userId': userId,
      'chatTitle': chatTitle,
      'contextUser': contextUser,
      'deleteYn': deleteYn,
    };
  }
}