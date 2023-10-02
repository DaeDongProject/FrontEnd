import 'package:daedong3/model/context.dart';

class ChatRoom { // 로그인한 사용자의 가장 최근 채팅방, 사용자가 선택한 채팅방, 채팅방 제목 수정, 채팅방 삭제,
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
      id: json["_id"],
      userId: json["userId"],
      chatTitle: json["chatTitle"],
      contextUser: json["contextUser"],
      deleteYn: json["deleteYn"],
    );
  }

  Map<String, dynamic> toJson(){
    return{
      "_id": id,
      "userId": userId,
      "chatTitle": chatTitle,
      "contextUser": contextUser,
      "deleteYn": deleteYn
    };
  }
}