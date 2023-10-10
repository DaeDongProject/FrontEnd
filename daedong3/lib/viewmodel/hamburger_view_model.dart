import 'package:flutter/cupertino.dart';

import '../model/chatRoom.dart';
import '../model/user.dart';
import '../repository/repository.dart';

class HamburgerViewModel with ChangeNotifier{
  late final Repository _repository;

  Future<String> createChatRoom(User user){
    _repository = Repository();

    Future<String> newChatId = _repository.createChatRoom(user);

    return newChatId;
  }

 /* Future<dynamic> pastChatList(ChatRoom chatRoom){
    _repository = Repository();

    response = _repository.pastChatList(chatRoom.userId);


  }*/
}