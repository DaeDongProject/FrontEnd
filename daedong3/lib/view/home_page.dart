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
              Align(
                alignment: Alignment(0.95,1),
                child: FloatingActionButton.small(
                  onPressed: () {
                    showhelp(context);
                  },
                  child: Icon(Icons.question_mark, color: Colors.white,),
                  backgroundColor: Colors.lightBlueAccent,
                  shape: CircleBorder(),


                ),
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
  void showhelp(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('대동이는요...?',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
            textAlign: TextAlign.center,),
          content: Text('학교와 관련된 정보는 다음 항목들의 정보를 제공해주고 있어 !\n\n\n'
              '* 학교소개\n'
              '- 대중교통(버스)안내 / 상징동물 / 슬로건 / 건학이념 / 전화번호\n\n'
              '* 대학생활\n'
              '- 시설대관 / 장애학생 지원센터 / 주차등록 / 학생증발급 / 보건실 / 학군단 / 학생보험\n\n'
              '* 학사/행정\n'
              '- 등록 / 복학 / 수업 / 예비군 / 자퇴 / 장학 / 학자금대출 / 재입학 / 전과 / 제적 /\n'
              '  졸업 / 편입학 / 학사일정 / 학적기재사항정정 / 학점포기 / 휴학\n\n'
              '사용방법은 예를 들어 "장학 / 학자금대출"에 대한 정보를 알고 싶다면 채팅창에 "장학/학자금대출"이라고 입력하면 돼.\n\n'
              '이 외의 질문에도 대답해줄 수 있어!', style: TextStyle(fontSize: 15),),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('대화하기',
                    style: TextStyle(color: Colors.white, fontSize: 20),),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlueAccent,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(20)
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
