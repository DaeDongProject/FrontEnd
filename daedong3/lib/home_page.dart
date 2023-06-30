import 'package:daedong3/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

import 'hamburger_menu.dart';
import 'models/user.dart';


class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<AnimatedListState> _animListKey = GlobalKey<AnimatedListState>();
  final messageController = TextEditingController();

    // 넘어 오는 데이터로 하기

  List<String> _chats = [];
  List<String> _daedongchats = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
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

                        }
                      },
                    ),
                  ),
                )

              ],
            ),
          ),

          drawer: HamburgerMenu(),
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

