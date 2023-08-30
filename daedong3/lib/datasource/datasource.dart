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
  Future<String> answerQuestion(Question question) async{
    final responseAnswerQuestion = await http
        .post(Uri.parse('http://13.125.221.81:8080/daedong/chatroom/question'),
              body: question.toJson());
    return jsonDecode(responseAnswerQuestion.body)
        .toString();
  }

  // 잘못된 정보 수정 요청
  Future<String> requestModifyInfo() async{
    final requestModifyInfo = await http
        .post(Uri.parse('http://13.125.221.81:8080/daedong/chatroom/modify'),
              body: /* id, contextIndex, text */ );
    return jsonDecode(requestModifyInfo.body)
        .toString();
  }

  // 채팅방 제목 수정
  Future<String> updateTitle(ChatRoom chatRoom, String title) async{
    final responseUpdateTitle = await http
        .post(Uri.parse('http://13.125.221.81:8080/daedong/updatetitle/$title'),
                body: chatRoom.toJson());
    return jsonDecode(responseUpdateTitle.body)
        .toString();
  }

  // 채팅방 삭제
  Future<String> deleteChatRoom(ChatRoom chatRoom) async{
    final responseDeleteChatRoom = await http
        .post(Uri.parse('http://13.125.221.81:8080/daedong/deletechatroom'),
              body: chatRoom.toJson());
    return jsonDecode(responseDeleteChatRoom.body)
        .toString();
  }

  // 로그인한 사용자의 최근 채팅방
  Future<ChatRoom> latestChatRoom(String userId) async{
    final latestChatRoom = await http
        .get(Uri.parse('http://13.125.221.81:8080/daedong/$userId'));
    return jsonDecode(latestChatRoom.body);
  }

  // 사용자가 선택한 채팅방
  Future<ChatRoom> chosenChatRoom(String chatRoomId) async{
    final chosenChatRoom = await http
        .get(Uri.parse('http://13.125.221.81:8080/daedong/chatroom/$chatRoomId'));
    return jsonDecode(chosenChatRoom.body);
  }

  // 과거 채팅 내용 조회
  Future<dynamic> pastChatList(String userId) async{
    final pastChatList = await http
        .get(Uri.parse('http://13.125.221.81:8080/daedong/pastList/$userId'));
    return jsonDecode(pastChatList.body);
  }


}