import 'dart:convert';
import '../model/chat_room.dart';
import '../model/question.dart';
import '../model/user.dart';
import 'package:http/http.dart' as http;

class Repository{
  // 새 채팅 생성
  Future<String> createChatRoom(User user) async{
    try {
      final response = await http
          .post(
          Uri.parse('http://13.125.221.81:8080/daedong/menu/createchatroom'),
          body: {user.toJson()});
      if(response.statusCode == 200){
        return jsonDecode(response.body)
            .toString();
      }else{
        throw Exception('Request Error: ${response.statusCode}');
      }
    } catch(e){
      throw Exception('Error: $e');
    }
  }

  // 사용자 질문
  Future<String> answerQuestion(Question question) async{
    try{
      final response = await http
          .post(Uri.parse('http://13.125.221.81:8080/daedong/chatroom/question'),
          body: question.toJson());
      if(response.statusCode == 200){
        return jsonDecode(response.body)
            .toString();
      }else{
        throw Exception('Request Error: ${response.statusCode}');
      }
    }catch(e){
      throw Exception('Error: $e');
    }
  }

  // 잘못된 정보 수정 요청
  Future<String> requestModifyInfo() async{
    try{
      final response = await http
          .post(Uri.parse('http://13.125.221.81:8080/daedong/chatroom/modify'),
          body: /* id, contextIndex, text */ );
      if(response.statusCode == 200){
        return jsonDecode(response.body)
            .toString();
      }else{
        throw Exception('Request Error: ${response.statusCode}');
      }
    }catch(e){
      throw Exception('Error: $e');
    }
  }

  // 채팅방 제목 수정
  Future<String> updateTitle(ChatRoom chatRoom, String title) async{
    try{
      final response = await http
          .post(Uri.parse('http://13.125.221.81:8080/daedong/updatetitle/$title'),
          body: chatRoom.toJson());
      if(response.statusCode == 200){
        return jsonDecode(response.body)
            .toString();
      }else{
        throw Exception('Request Error: ${response.statusCode}');
      }
    }catch(e){
      throw Exception('Error: $e');
    }
  }

  // 채팅방 삭제
  Future<String> deleteChatRoom(ChatRoom chatRoom) async{
    try{
      final response = await http
          .post(Uri.parse('http://13.125.221.81:8080/daedong/deletechatroom'),
          body: chatRoom.toJson());
      if(response.statusCode == 200){
        return jsonDecode(response.body)
            .toString();
      }else{
        throw Exception('Request Error: ${response.statusCode}');
      }
    }catch(e){
      throw Exception('Error: $e');
    }
  }

  // 로그인한 사용자의 최근 채팅방
  Future<ChatRoom> latestChatRoom(String userId) async{
    try{
      final response = await http
          .get(Uri.parse('http://13.125.221.81:8080/daedong/$userId'));
      if(response.statusCode == 200){
        return jsonDecode(response.body);
      }else{
        throw Exception('Request Error: ${response.statusCode}');
      }
    }catch(e){
      throw Exception('Error: $e');
    }
  }

  // 사용자가 선택한 채팅방
  Future<ChatRoom> chosenChatRoom(String chatRoomId) async{
    try{
      final response = await http
          .get(Uri.parse('http://13.125.221.81:8080/daedong/chatroom/$chatRoomId'));
      if(response.statusCode == 200){
        return jsonDecode(response.body);
      }else{
        throw Exception('Request Error: ${response.statusCode}');
      }
    }catch(e){
      throw Exception('Error: $e');
    }
  }

  // 과거 채팅 내용 조회
  Future<dynamic> pastChatList(String userId) async{
    try{
      final response = await http
          .get(Uri.parse('http://13.125.221.81:8080/daedong/pastList/$userId'));
      if(response.statusCode == 200){
        return jsonDecode(response.body);
      }else{
        throw Exception('Request Error: ${response.statusCode}');
      }
    }catch(e){
      throw Exception('Error: $e');
    }
  }

}