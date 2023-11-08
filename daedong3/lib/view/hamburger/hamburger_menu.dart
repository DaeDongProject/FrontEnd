import 'package:daedong3/personal_information.dart';
import 'package:daedong3/view/home_page.dart';
import 'package:daedong3/view/hamburger/past_dialog.dart';
import 'package:daedong3/view/hamburger/privacy_update.dart';
import 'package:daedong3/view/login.dart';
import 'package:daedong3/viewmodel/chat_view_model.dart';
import 'package:daedong3/viewmodel/hamburger_view_model.dart';
import 'package:daedong3/viewmodel/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HamburgerMenu extends StatelessWidget {
  const HamburgerMenu({super.key});

  @override
  Widget build(BuildContext context) {

    HamburgerViewModel hamburgerViewModel = Provider.of<HamburgerViewModel>(context);
    LoginViewModel loginViewModel = Provider.of<LoginViewModel>(context);
    ChatViewModel chatViewModel = Provider.of<ChatViewModel>(context);

    return Drawer(

      child: ListView(
        padding: EdgeInsets.zero,
        children : <Widget>[
          //StreamBuilder 확인
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.lightBlueAccent),
            accountName: Text(loginViewModel.user.name),
            accountEmail: Text(loginViewModel.user.schoolName),
            currentAccountPicture: CircleAvatar(
              // 프로필 사진 변경 미구현
              backgroundImage: AssetImage('assets/basic_profile.jpeg'),
              //backgroundColor: Colors.blueAccent,
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.settings,
              color: Colors.grey[850],
            ),
            title: Text("개인정보 수정"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        PrivacyUpdate(
                          )),
              );
            },
            trailing: Icon(Icons.arrow_right),
          ),
          ListTile(
            leading: Icon(
              Icons.add_box,
              color: Colors.grey[850],
            ),
            title: Text("New Chat"),
            onTap: () async {
              await hamburgerViewModel.createChatRoom(context, loginViewModel.user); // 새 채팅방 생성
              await chatViewModel.requestChatRoomInfo(chatRoomId: loginViewModel.user.chatRoomOid.last); // 새로 생성된 채팅방으로 채팅방 설정

              hamburgerViewModel.selectChatId(chatViewModel.selectedChatRoom.id);

              if(!context.mounted) return;
              Navigator.pop(context);
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (BuildContext context) =>
              //       HomePage()),
              // );
            },
            trailing: Icon(Icons.arrow_right),
          ),
          PastDialog(), // 이전 채팅 목록 불러오기
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.grey[850],
            ),
            title: Text("로그아웃"),
            onTap: () {
              hamburgerViewModel.logout();
              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false
              );
            },
            trailing: Icon(Icons.arrow_right),
          ),
        ],
      ),
    );
  }
}