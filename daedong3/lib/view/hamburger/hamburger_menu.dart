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
            onTap: () async {
              PersonalInformation updateInformation = await Navigator.push(
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
            onTap: () async => {
              await hamburgerViewModel.createChatRoom(context, loginViewModel.user), // 새 채팅방 생성
              await chatViewModel.requestChatRoomInfo(chatRoomId: loginViewModel.user.chatRoomOid.last),

              Navigator.push(
                context,
                MaterialPageRoute(builder: (BuildContext context) =>
                    HomePage()),
              )
            },
            trailing: Icon(Icons.arrow_right),
          ),

          ListTile(
            leading: Icon(
              Icons.content_paste_go,
              color: Colors.grey[850],
            ),
            title: Text("이전 대화 내용"),
            onTap: () async {
              await hamburgerViewModel.pastChatList(loginViewModel.user); // 채팅 리스트 서버에서 가져오기

              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          PastDialog()
                  ));
            },
            trailing: Icon(Icons.arrow_right),
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.grey[850],
            ),
            title: Text("로그아웃"),
            onTap: () {
              hamburgerViewModel.logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen())
              );
            },
            trailing: Icon(Icons.arrow_right),
          ),
        ],
      ),
    );
  }
}