import 'package:daedong3/model/chat_room.dart';
import 'package:daedong3/view/chat/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_mongodb_realm/database/database.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../model/chat_item.dart';
import '../viewmodel/chat_view_model.dart';
import 'hamburger/hamburger_menu.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<AnimatedListState> _animListKey =
      GlobalKey<AnimatedListState>();
  final ScrollController _scrollController = ScrollController();

  final messageController = TextEditingController();

  List<String> question = [];

  List<String> answer = [];

  List<String> message = [];

  List<ChatItem> chatItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    if(_scrollController.hasClients){
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    }

    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });

    ChatViewModel chatViewModel = Provider.of<ChatViewModel>(context);

    Logger().d(chatViewModel.selectedChatRoom.chatTitle);

    int contextIdx = 0;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text("대동이", style: TextStyle(fontSize: 20)),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Center(
          child: Column(
            children: [
              Text(
                "Today, ${DateFormat("Hm").format(DateTime.now())}",
                style: TextStyle(fontSize: 15),
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.only(top: 15, bottom: 10),
                ),
              ),
              StreamBuilder(
                stream: chatViewModel.chatRoomController.stream,
                builder: (context, snapshot) {
                  return Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount:
                          // chatViewModel.selectedChatRoom.contextUser.length * 2,
                          snapshot.data!.contextUser.length*2,
                      itemBuilder: (BuildContext context, index) {
                        final contextIdx = index ~/ 2;
                        if (snapshot.hasError){
                          return Text("데이터 오류");
                        }
                        if (snapshot.connectionState == ConnectionState.waiting){
                          return Text("응답을 받아오는 중입니다");
                        }
                        // if(chatViewModel.selectedChatRoom.contextUser[contextIdx]! == null) {
                        //   return ChatMessage("응답을 받아오는 중입니다.", false);
                        // }
                        if (index % 2 == 0) {
                          // return ChatMessage(chatViewModel.selectedChatRoom.contextUser[contextIdx]['question'], true);
                          return ChatMessage(snapshot.data!.contextUser[contextIdx]['question'], true);

                        } else if (index % 2 == 1) {

                          return ChatMessage(snapshot.data!.contextUser[contextIdx]['answer'], false);
                        }
                      }

                      // child: AnimatedList(
                      //   key: _animListKey,
                      //   reverse: true,
                      //   itemBuilder: _buildItem,
                      // ),
                    ),
                  );
                }
              ),
              Divider(
                height: 5,
                color: Colors.lightBlueAccent,
              ),
              Container(
                child: ListTile(
                  title: Container(
                    height: 35,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Color.fromRGBO(220, 220, 220, 1)),
                    padding: EdgeInsets.only(left: 15),
                    child: TextFormField(
                      maxLines: null,
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: "메세지를 입력하세요",
                        hintStyle: TextStyle(color: Colors.black26),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                      //onFieldSubmitted: _handleSunbmitted //모바일 어플리케이션에서의 키패트 전송버튼 활용
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    onPressed: () {
                      if (messageController.text.isEmpty) {
                        print("메세지를 입력하세요.");
                      } else {
                        _handleSubmitted(messageController.text, context);
                        messageController.clear();
                      }
                    },
                  ),

                  trailing: IconButton(
                    icon: Icon(
                      Icons.send,
                      size: 30,
                      color: Colors.lightBlueAccent,
                    ),
                    onPressed: () {
                      if (messageController.text.isEmpty) {
                        print("메세지를 입력하세요.");
                      } else {
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

  // Widget _buildItem(context, index, animation){ // 위젯 위에 채팅을 그려주는 아이템빌더
  void _handleSubmitted(String text, BuildContext context) async {
    // 메시지 제출 함수
    Logger().d(text);

    ChatViewModel chatViewModel =
        Provider.of<ChatViewModel>(context, listen: false);

    // messageController.clear();
    // _chats.insert(0,text); // 유저 context의 question 집합들
    await chatViewModel.sendMessage(
        chatViewModel.selectedChatRoom.id, text);

    await chatViewModel.requestChatRoomInfo(chatRoomId: chatViewModel.selectedChatRoom.id);

    // // if (chatViewModel.requestMessage != null && chatViewModel.responseMessage != "") {
    // ChatItem newItem =
    //     ChatItem(chatViewModel.requestMessage, chatViewModel.responseMessage);
    // chatItems.insert(0, newItem);
    //
    // chatViewModel.notifyListeners();
    //
    // _scrollController.animateTo(
    //   0.0,
    //   duration: Duration(milliseconds: 300),
    //   curve: Curves.easeOut,
    // );
    // _animListKey.currentState?.insertItem(0);
  }
}
