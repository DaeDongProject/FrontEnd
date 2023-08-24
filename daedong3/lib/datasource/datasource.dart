import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/question.dart';
import '../model/chat_room.dart';
import '../model/user.dart';

class DataSource {
  // 새 채팅 생성
  Future<String> createChatRoom(User user) async{
    final responseCreateChatRoom = await http
        .post(Uri.parse('http://13.125.221.81:8080/daedong/menu/createchatroom'),
              body: {user.toJson()});
    return jsonDecode(responseCreateChatRoom.body)
        .toString();
  }

  // 사용자 질문
  Future<String> answerQuestion() async{
    final responseAnswerQuestion = await http
        .post(Uri.parse('http://13.125.221.81:8080/daedong/chatroom/question'),
              body: Question(id: /*id*/, question: /*question*/).toJson();
        );
    return jsonDecode(responseAnswerQuestion.body)
        .toString();
  }

  // 잘못된 정보 수정 요청

  // 채팅방 제목 수정
  Future<String> updateTitle() async{

    final responseUpdateTitle = await http
        .post(Uri.parse('http://13.125.221.81:8080/daedong/updatetitle/${chatTitle}'),
              // body: ChatRoom().toJson;
        );
    return jsonDecode(responseUpdateTitle.body)
        .toString();
  }

  // 채팅방 삭제
  Future<String> deleteChatRoom() async{
    final responseDeleteChatRoom = await http
        .post(Uri.parse('http://13.125.221.81:8080/daedong/deletechatroom'),
              body: ChatRoom().toJson());
    return jsonDecode(responseDeleteChatRoom.body)
        .toString();
  }

  // pastList
}