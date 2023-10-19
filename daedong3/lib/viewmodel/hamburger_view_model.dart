import 'package:daedong3/model/past_chat.dart';
import 'package:flutter/cupertino.dart';

import '../model/chatRoom.dart';
import '../model/user.dart';
import '../model/past_chat.dart';
import '../repository/repository.dart';

class HamburgerViewModel with ChangeNotifier{
  late final Repository _repository;

  // HamburgerViewModel(){
  //   _repository = Repository();
  // }

  Future<String> createChatRoom(User user){
    _repository = Repository();

    Future<String> newChatId = _repository.createChatRoom(user);

    return newChatId;
  }

  Future<List<PastChat>> pastChatList(PastChat pastChat) async {
    _repository = Repository();

    try{
      List<PastChat> chatList = await _repository.pastChatList(pastChat.toString());
      return chatList;
    }catch(e){
      throw Exception('Error: $e');
    }


  }
}