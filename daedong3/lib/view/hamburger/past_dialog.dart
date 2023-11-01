import 'package:daedong3/viewmodel/chat_view_model.dart';
import 'package:daedong3/viewmodel/hamburger_view_model.dart';
import 'package:daedong3/viewmodel/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../model/past_chat.dart';
import '../home_page.dart';
import 'hamburger_menu.dart';

class PastDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HamburgerViewModel hamburgerViewModel = Provider.of<HamburgerViewModel>(context);
    final LoginViewModel loginViewModel = Provider.of<LoginViewModel>(context);
    final ChatViewModel chatViewModel = Provider.of<ChatViewModel>(context);

    TextEditingController newTitle = TextEditingController();

    return ExpansionTile(
      title: Text('이전 대화 내용'),
      leading: Icon(
        Icons.content_paste_go,
        color: Colors.grey[850],
      ),
      onExpansionChanged: (bool expanded)  { // 드랍다운 아이콘 눌렀을 때
        if (expanded) {
          hamburgerViewModel.pastChatList(loginViewModel.user); // 채팅 리스트 가져오기
        }
      },
      children: [
        Column(
          children: [
            for (int index = hamburgerViewModel.chatList.length - 1;
                index >= 0;
                index--) // 최근 채팅방을 위쪽에 표시하기 위해 역으로 순환
              ListTile(
                title: Text(hamburgerViewModel.chatList[index].chatTitle),

                onTap: (){
                  chatViewModel.requestChatRoomInfo(chatRoomId: hamburgerViewModel.chatList[index].objectId);

                  Navigator.pushReplacement(
                      context,MaterialPageRoute(
                      builder: (_)=>HomePage()));

                }, // 눌렀을 때 수행할 동작
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      child: Icon(Icons.edit),
                      onTap: () {
                        // 수정 아이콘 클릭 시 수행할 동작
                        // 제목 수정 Dialog
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("채팅방 제목 수정"),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: newTitle,
                                    decoration: InputDecoration(
                                      hintText: hamburgerViewModel.chatList[index].chatTitle,

                                    ),
                                  )
                                ],
                              ),
                              actions: [
                                ElevatedButton(
                                    onPressed: (){
                                      Navigator.pop(context);
                                    },
                                    child: Text("취소")),
                                ElevatedButton(
                                    onPressed: () async {
                                      // newTitle 을 updateTitle로 요청
                                      await hamburgerViewModel.updateTitle(newTitle.text,
                                          hamburgerViewModel.chatList[index].objectId);

                                      // 채팅방 다시 조회하기
                                      await hamburgerViewModel.pastChatList(loginViewModel.user);

                                      Logger().d(hamburgerViewModel.chatList[index].chatTitle);
                                      if(!context.mounted) return;
                                      Navigator.pop(context, );
                                    },
                                    child: Text("수정"),
                                  // 빈칸이면 버튼 비활성화

                                ),
                              ],
                            );
                          }
                        );
                      },
                    ),
                    InkWell(
                      child: Icon(Icons.delete),
                      onTap: () {
                        // 삭제 아이콘 클릭 시 수행할 동작
                        // 확인 버튼 채팅방 삭제 Dialog
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("채탕방 삭제"),
                              actions: [
                                TextButton(
                                  child: Text("취소"),
                                  onPressed: (){
                                    Navigator.pop(context, );
                                  },
                                ),
                                TextButton(
                                  child: Text("삭제"),
                                  onPressed: () async {
                                    await hamburgerViewModel.deleteChatRoom( // 채팅방 Id를 보내서 삭제하기
                                        hamburgerViewModel.chatList[index].objectId);

                                    await hamburgerViewModel.pastChatList(loginViewModel.user); // 채팅 다시 조회하기

                                    if(!context.mounted) return;
                                    Navigator.pop(context, ); // 팝업창 이전 화면으로 돌아가기
                                  },
                                )
                              ],
                            );
                          }
                        );
                      },
                    ),
                  ],
                ),
              ),
          ],
        )

        // FutureBuilder<List<PastChat>>(
        //   future: hamburgerViewModel.pastChatList(loginViewModel.user), // 유저의 채팅 목록 불러오기
        //   builder: (context, snapshot) {
        //     if(snapshot.connectionState == ConnectionState.waiting){ // 데이터 가져오는 중이라면
        //       return CircularProgressIndicator(); // 데이터 로딩 표시기 띄우기
        //     }else if(snapshot.hasError){
        //       return Text('${snapshot.error}'); // 에러라면 에러메시지 띄우기
        //     }else if(snapshot.hasData){ // 데이터를 가져왔다면
        //       List<PastChat> itemList = snapshot.data!;
        //
        //       return Column(
        //         children: [
        //           for (int index = itemList.length - 1; index >= 0; index--) // 최신 채팅방을 위로 오게 하기 위해 역으로 순환
        //             ListTile(
        //               title: Text(itemList[index].chatTitle),
        //               trailing: Row(
        //                 mainAxisSize: MainAxisSize.min,
        //                 children: [
        //                   InkWell(
        //                     child: Icon(Icons.edit),
        //                     onTap: () {
        //                       // 수정 아이콘 클릭 시 수행할 동작
        //                     },
        //                   ),
        //                   InkWell(
        //                     child: Icon(Icons.delete),
        //                     onTap: () {
        //                       // 삭제 아이콘 클릭 시 수행할 동작
        //
        //                     },
        //                   ),
        //                 ],
        //               ),
        //             ),
        //         ],
        //       );
        //     }else{ // 데이터가 없다면
        //       return Text('채팅방 없음');
        //     }
        //   },
        // ),
      ],
    );
  }
}
