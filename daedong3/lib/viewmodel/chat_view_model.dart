import 'dart:async';
import 'dart:io';
import 'package:daedong3/model/context.dart';
import 'package:daedong3/viewmodel/hamburger_view_model.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import '../model/chat_room.dart';
import '../model/question.dart';
import '../repository/repository.dart';

class ChatViewModel with ChangeNotifier{
  late final Repository _repository = Repository();

  HamburgerViewModel hamburgerViewModel = HamburgerViewModel();
  bool delayMessage = false;
  String requestMessage = ""; // 사용자 질문 string
  String responseMessage = ""; // 사용자 질문에 대한 대동이의 답변

  // User의 메시지를 보내 대동이의 응답을 받는 함수
  sendMessage(String id, String request) async { // id는 ChatRoomOid, request는 사용자 질문 String
    requestMessage = request;
    responseMessage =""; // 이전 질문에 대한 답변을 초기화

    delayMessage = false;

    Question question = Question(id: id, question: request); // 매개변수 받아서 Question 객체화

    responseMessage = await _repository.answerQuestion(question); // API 응답 받아서 responseMessage에 할당

    addChatData(responseMessage);
    chatDataController.add(chatData);


    notifyListeners();

    // return responseMessage;
  }

  final StreamController<List<String>> chatDataController = BehaviorSubject<List<String>>(); // Error : Stream has already been listened to 에 대한 해결책 BehaviorSubject를 인스턴스화시킴

  late ChatRoom selectedChatRoom = ChatRoom(id: "초기화채팅방", userId: "", deleteYn: false, contextUser: [], chatTitle: ""); // 초기화/ User가 현재 선택한, 사용 중인 채팅방(채팅 목록에서 선택 중인 채팅방 아님)

  // 화면에 띄울 채팅방 정보를 selectedChatRoom에 할당하는 함수
  Future<ChatRoom> requestChatRoomInfo({String? userId, String? chatRoomId}) async { // 매개변수 둘 중 하나만 입력, Named Parameter임을 유의
    ChatRoom newChatRoom;

    if((userId != null) && (chatRoomId == null)){ // 로그인 시 처음 띄울 채팅방의 조건
      newChatRoom = await _repository.latestChatRoom(userId);
    }else if((userId == null) && (chatRoomId != null)){ // 채팅 목록에서 선택할 때의 조건
      newChatRoom = await _repository.chosenChatRoom(chatRoomId);
    }else{ // 매개변수가 둘 다 들어왔거나 안 들어왔을 때 => 바로 return : 원래 selectedChatRoom 그대로 유지
      return selectedChatRoom;
    }

    selectedChatRoom = newChatRoom;

    setChatData();

    notifyListeners();

    return selectedChatRoom;
  }

  List<String> chatData = [];

  setChatData(){
    for(int i=0; i<selectedChatRoom.contextUser.length; i++){
      chatData.add(selectedChatRoom.contextUser[i]['question']);
      chatData.add(selectedChatRoom.contextUser[i]['answer']);
    }

    chatDataController.add(chatData);
  }

  addChatData(String text){
    chatData.add(text);

    chatDataController.add(chatData);
  }

  clearChatData(){
    chatData.clear();
  }
}