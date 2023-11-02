import 'dart:js_util';

import 'package:daedong3/view/chat/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../model/chat_item.dart';
import '../repository/repository.dart';
import '../viewmodel/chat_view_model.dart';
import 'hamburger/hamburger_menu.dart';

class HomePage extends StatelessWidget{
  final GlobalKey<AnimatedListState> _animListKey = GlobalKey<AnimatedListState>();
  final messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<String> question = [];
  List<String> answer = [];
  List<String> message = [];
  List<ChatItem> chatItems = [];


  @override
  Widget build(BuildContext context) {
    late Repository repository = Repository();
    ChatViewModel chatViewModel = Provider.of<ChatViewModel>(context);

    Logger().d("현재 채팅방 제목 = ${chatViewModel.selectedChatRoom.chatTitle}, id = ${chatViewModel.selectedChatRoom.id}");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text("대동이",style: TextStyle(
            fontSize: 20
        )),
        centerTitle: true,
        elevation: 0.0 ,

          ),
          body: WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Center(
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
                          maxLines: null,
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
                            _handleSubmitted(messageController.text, context);
                            messageController.clear();
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
        ),
      drawer: HamburgerMenu(),
    );
  }

  Widget _buildItem(context, index, animation){ // 위젯 위에 채팅을 그려주는 아이템빌더
    // return ChatMessage(_chats[index], animation:animation);
    ChatItem chatItem = chatItems[index];

    //ChatViewModel chatViewModel = Provider.of<ChatViewModel>(context);

    // if (chatViewModel.requestMessage != null && chatViewModel.responseMessage == ""){
    //   message.insert(0, chatViewModel.requestMessage);
    // }else if(chatViewModel.requestMessage != null && chatViewModel.responseMessage != ""){
    //   message.insert(0, chatViewModel.responseMessage);
    // }
    //첫 답변 뷰에 안올라오고 인덱스 의심할것
    //1번째 싸이클은 잘 돌아가나 두번째부터 등차수열로 들어감

    // question.insert(0, chatViewModel.requestMessage);
    // answer.insert(0, chatViewModel.responseMessage);
    // message.insert(0, chatViewModel.requestMessage);
    // message.insert(0, chatViewModel.responseMessage);
    // message.insert(0, chatViewModel.responseMessage);

    // print(message);
    //
    // return  chatViewModel.delayMessage ?
    // ChatMessage(message[0], false, animation: animation) :
    // ChatMessage(message[1], true,animation: animation);
    //return ChatMessage(message, true, animation: animation);

    return ChatMessage(chatItem, true, animation: animation);


  }

  void _handleSubmitted(String text, BuildContext context){ // 메시지 제출 함수
    Logger().d(text);

    ChatViewModel chatViewModel = Provider.of<ChatViewModel>(context, listen: false);
    // messageController.clear();
    // _chats.insert(0,text); // 유저 context의 question 집합들
    chatViewModel.requestMessage = text;
    chatViewModel.sendMessage(chatViewModel.selectedChatRoom.id, chatViewModel.requestMessage);

    // if (chatViewModel.requestMessage != null && chatViewModel.responseMessage != "") {
    ChatItem newItem = ChatItem(chatViewModel.requestMessage, chatViewModel.responseMessage);
    chatItems.insert(0, newItem);


    chatViewModel.notifyListeners();


    _scrollController.animateTo(
      0.0,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
    _animListKey.currentState?.insertItem(0);
  }
}