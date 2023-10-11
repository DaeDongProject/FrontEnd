import 'package:daedong3/view/hamburger/past_dialog.dart';
import 'package:daedong3/view/hamburger/privacy_update.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../personal_information.dart';
import '../home_page.dart';

class HamburgerMenu extends StatefulWidget {
  PersonalInformation information;
  HamburgerMenu(this.information, {Key? key}) : super(key: key);

  @override
  State<HamburgerMenu> createState() => _HamburgerMenuState();
}

class _HamburgerMenuState extends State<HamburgerMenu> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

  }
  @override
  Widget build(BuildContext context) {
    return Drawer(

      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          //StreamBuilder 확인
          UserAccountsDrawerHeader( // 개인 정보란
            decoration: BoxDecoration(color: Colors.lightBlueAccent),
            accountName: Text(widget.information.getName()),
            accountEmail: Text(widget.information.getUniversity()),
            currentAccountPicture: CircleAvatar(
              // 프로필 사진 변경 미구현
              backgroundImage: AssetImage('assets/basic_profile.jpeg'),
              //backgroundColor: Colors.blueAccent,
            ),
          ),
          ListTile( // 개인 정보 수정 버튼
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
                          information: widget.information,)),
              );
              setState(() {
                widget.information = updateInformation;
              });
            },
            trailing: Icon(Icons.arrow_right),
          ),
          ListTile( // New Chat 버튼
            leading: Icon(
              Icons.add_box,
              color: Colors.grey[850],
            ),
            title: Text("New Chat"),
            onTap: () => {
              // 채팅 내역 데이터 보내기

              // circularProgressIndicator

              // 새로운 화면 띄우기
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) =>
                      HomePage(widget.information)),
                )
            },
            trailing: Icon(Icons.arrow_right),
          ),

          ListTile( // 이전 대화 내용 버튼
            leading: Icon(
              Icons.content_paste_go,
              color: Colors.grey[850],
            ),
            title: Text("이전 대화 내용"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          PastDialog() // 매개변수로 유저 데이터 넘기기
                  ));


            },
            trailing: Icon(Icons.arrow_right),
          ),
        ],
      ),
    );
  }
}