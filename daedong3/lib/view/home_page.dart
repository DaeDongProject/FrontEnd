import 'package:daedong3/view/chat/chat_message.dart';
import 'package:daedong3/viewmodel/chat_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import '../repository/repository.dart';
import 'hamburger/hamburger_menu.dart';
import '../personal_information.dart';


class HomePage extends StatefulWidget {
  final String chatRoomId;// 채팅방 ID
  PersonalInformation information;
  //이거 필요한가??
  HomePage(this.chatRoomId, this.information, {Key? key}) : super(key: key);

  // HomePage(this.information, {Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<AnimatedListState> _animListKey = GlobalKey<AnimatedListState>();
  final messageController = TextEditingController();
  final ChatViewModel _chatViewModel = ChatViewModel();
  late Repository _repository = Repository();

  // 넘어 오는 데이터로 하기

  @override
  void initState(){
    //TODO: implement initState
    super.initState();
    _repository = Repository();
    // ChatViewModel에서 채팅방 정보를 요청
    _chatViewModel.requestChatRoomInfo(chatRoomId: widget.chatRoomId);
  }

  List<String> _chats = [];
  List<String> _daedongchats = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text("대동이",style: TextStyle(
            fontSize: 20
        )),
        centerTitle: true,
        elevation: 0.0 ,


      ),
      body: Container(
        child: Column(

          children: [
            Text("Today, ${DateFormat("Hm").format(DateTime.now())}",style: TextStyle(
                fontSize: 15
            ),
            ),

            Center(
              child: Container(
                padding:  EdgeInsets.only(top: 15,bottom: 10),

              ),
            ),

            Expanded(
              child: AnimatedList(
                key: _animListKey,
                reverse: true,
                itemBuilder: _buildItem,
              ),
            ),


            Divider(
              height: 5,
              color: Colors.lightBlueAccent,
            ),
            Container(
              child: ListTile(
                title: Container(
                  height: 35, decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color : Color.fromRGBO(220, 220, 220, 1)
                ),
                  padding: EdgeInsets.only(left : 15),
                  child: TextFormField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: "메세지를 입력하세요",
                      hintStyle: TextStyle(
                          color: Colors.black26
                      ),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                    ),
                    //onFieldSubmitted: _handleSunbmitted //모바일 어플리케이션에서의 키패트 전송버튼 활용
                    style: TextStyle(
                        fontSize: 16,
                        color : Colors.black
                    ),

                  ),
                ),
                trailing: IconButton(
                  icon: Icon(Icons.send, size: 30, color: Colors.lightBlueAccent,
                  ),
                  onPressed: (){
                    if(messageController.text.isEmpty){
                      print("메세지를 입력하세요.");
                    }
                    else{
                      _handleSunbmitted(messageController.text);
                      _chatViewModel.sendMessage(widget.chatRoomId, messageController.text);
                      messageController.clear();


                    }
                  },
                ),
              ),
            )

          ],
        ),
      ),

      drawer: HamburgerMenu(chatRoomId: widget.chatRoomId),
    );

  }
  Widget _buildItem(context, index, animation){
    return ChatMessage(_chats[index], animation:animation);
  }

  void _handleSunbmitted(String text){
    Logger().d(text);

    messageController.clear();
    _chats.insert(0,text);
    _animListKey.currentState?.insertItem(0);
  }
}