import 'dart:convert';
import 'dart:io';
import 'package:daedong3/model/info_modify_request.dart';
import 'package:logger/logger.dart';
import '../model/chat_room.dart';
import '../model/login.dart';
import '../model/past_chat.dart';
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
      }else{ // 에러 처리 미흡. 예하 동일
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
          body: null/* id, contextIndex, text */ );
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

  // 로그인
  Future<bool> login(Login login) async {
    try {
      final response = await http.post(
          Uri.parse('http://13.209.50.197:8080/daedong/login'),
          headers: {"Content-Type": "application/x-www-form-urlencoded"},
          body: login.toJson());
      // User result = User.fromJson(jsonDecode(response.body)); // json 방식이 아닌 x-www-form-urlencoded 방식으로 주고받기 때문에 디코딩 필요없음
      Logger().d(response.statusCode);
      if(response.statusCode == 200){
        return true;
      }else{
        return false;
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // 회원 정보 수정
  Future<bool> updateUserInfo(UserUpdate userUpdate, String id) async {
    // id 는 UserId
    try {
      final response = await http.put(
          Uri.parse(
              'http://13.209.50.197:8080/daedong/updateuserinformation/$id'),
          // #Uri 상 _id 이지만 private 처리 문제로 일단 id로 적어둠
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(userUpdate.toJson()));
      if (response.body == "success") {
        return true;
      } else {
        return false;
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