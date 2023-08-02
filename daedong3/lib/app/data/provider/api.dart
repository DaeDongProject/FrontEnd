import 'package:http/http.dart' as http;
import 'dart:convert';

var createChatRoomUri = Uri.parse('http://13.125.221.81:8080/daedong/menu/createchatroom');

class Api {

  createChatRoom() async{
    try{
      var response = await http.post(createChatRoomUri);
      if(response.statusCode == 200){

      }else if{

      }else{

      }
    }
  }
}