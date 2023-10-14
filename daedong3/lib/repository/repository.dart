import 'dart:convert';
import 'package:daedong3/model/info_modify_request.dart';
import 'package:logger/logger.dart';
import '../model/chat_room.dart';
import '../model/login.dart';
import '../model/past_chat.dart';
import '../model/question.dart';
import '../model/sign_up.dart';
import '../model/user.dart';
import 'package:http/http.dart' as http;
import '../model/user_update.dart';

class Repository {
  // API 순서대로 메소드 작성

  // 사용자 질문
  Future<String> answerQuestion(Question question) async {
    try {
      final response = await http.post(
          Uri.parse('http://13.209.50.197:8080/daedong/chatroom/question'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(question.toJson()));
      return response.body; // response가 String이어서 그대로 return
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // 로그인한 사용자의 최근 채팅방
  Future<ChatRoom> latestChatRoom(String userId) async {
    try {
      final response = await http.get(
        Uri.parse('http://13.209.50.197:8080/daedong/$userId'),
      );
      return ChatRoom.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // 사용자가 선택한 채팅방
  Future<ChatRoom> chosenChatRoom(String chatRoomId) async {
    try {
      final response = await http.get(
          Uri.parse('http://13.209.50.197:8080/daedong/chatroom/$chatRoomId'));
      return ChatRoom.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // 잘못된 정보 수정 요청
  Future<bool> requestModifyInfo(InfoModifyRequest infoModifyRequest) async {
    // bool 값으로 리턴
    try {
      final response = await http.post(
          Uri.parse('http://13.209.50.197:8080/daedong/chatroom/modify'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(infoModifyRequest.toJson()));
      if (response.body == "success") {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // 새 채팅 생성
  Future<String> createChatRoom(User user) async {
    try {
      final response = await http.post(
          Uri.parse('http://13.209.50.197:8080/daedong/menu/createchatroom'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(user.toJson()));
      return response.body;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // 과거 채팅 내용 조회
  Future<List<PastChat>> pastChatList(String userId) async {
    try {
      final response = await http
          .get(Uri.parse('http://13.209.50.197:8080/daedong/pastList/$userId'));
      dynamic body = jsonDecode(response.body); // response 값 body에 디코딩해서 담기
      List<PastChat> chatList = body
          .map((dynamic item) => PastChat.fromJson(item))
          .toList(); // PastChat 객체로 변환해서 리스트 형태로 리턴
      return chatList;
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // 채팅방 제목 수정
  Future<bool> updateTitle(ChatRoom chatRoom, String newChatTitle) async {
    // bool 값으로 리턴
    try {
      final response = await http.post(
          Uri.parse(
              'http://13.209.50.197:8080/daedong/updatetitle/$newChatTitle'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(chatRoom.toJson()));
      if (response.body == "success") {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // 채팅방 삭제
  Future<bool> deleteChatRoom(ChatRoom chatRoom) async {
    // bool 값으로 리턴
    try {
      final response = await http.post(
          Uri.parse('http://13.209.50.197:8080/daedong/deletechatroom'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(chatRoom.toJson()));
      if (response.body == "success") {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // 로그인
  Future<User> login(Login login) async {
    try {
      final response = await http.post(
          Uri.parse('http://13.209.50.197:8080/daedong/login'),
          headers: {"Content-Type": "application/x-www-form-urlencoded"},
          body: login.toJson());
      // User result = User.fromJson(jsonDecode(response.body)); // json 방식이 아닌 x-www-form-urlencoded 방식으로 주고받기 때문에 디코딩 필요없음
      if(response.statusCode == 200){
        return result; // User 객체 리턴, 아직 form-urlencoded 처리 못함
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
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // 회원 탈퇴
  Future<bool> deleteUser(User user) async {
    try {
      final response = await http.post(
          Uri.parse('http://13.209.50.197:8080/daedong/deleteuser'),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(user.toJson()));
      if (response.body == "success") {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // 로그아웃
  Future<bool> logout() async {
    try {
      final response = await http.post(
          Uri.parse('http://13.209.50.197:8080/daedong/logout')
      );
      if (response.body == "success") {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  // 회원가입
  Future<bool> signup(SignUp signUp) async{
    try {
      final response = await http.post(
          Uri.parse('http://13.209.50.197:8080/daedong/join'),
          headers: {"Content-Type" : "application/json"},
          body: jsonEncode(signUp.toJson())
      );
      if (response.body == "success") {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
