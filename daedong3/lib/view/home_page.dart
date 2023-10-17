import 'package:daedong3/view/chat/chat_message.dart';
import 'package:daedong3/view/chat/chat_message_deadong.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../viewmodel/chat_view_model.dart';
import 'hamburger/hamburger_menu.dart';


class HomePage extends StatelessWidget{
  GlobalKey<AnimatedListState> _animListKey = GlobalKey<AnimatedListState>();
  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ChatViewModel chatViewModel = Provider.of<ChatViewModel>(context);

    return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.lightBlueAccent,
            title: Text("대동이",style: TextStyle(
                fontSize: 20
            )),
            centerTitle: true,
            elevation: 0.0 ,


          ),
          body: Center(
            child: Container(
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
                            _handleSunbmitted(messageController.text, context);

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
  Widget _buildItem(context, index, animation){
    // return ChatMessage(_chats[index], animation:animation);

    ChatViewModel chatViewModel = Provider.of<ChatViewModel>(context);

    return ChatMessage(chatViewModel.selectedChatRoom.contextUser[index].question, animation: animation,);
  }

  void _handleSunbmitted(String text, BuildContext context){
    Logger().d(text);
    ChatViewModel chatViewModel = Provider.of<ChatViewModel>(context);

    messageController.clear();
    // _chats.insert(0,text);
    chatViewModel.selectedChatRoom;
    _animListKey.currentState?.insertItem(0);
  }
}

