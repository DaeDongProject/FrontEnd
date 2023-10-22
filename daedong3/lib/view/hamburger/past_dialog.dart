import 'package:daedong3/viewmodel/hamburger_view_model.dart';
import 'package:daedong3/viewmodel/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PastDialog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final HamburgerViewModel hamburgerViewModel =
    Provider.of<HamburgerViewModel>(context);
    final LoginViewModel loginViewModel = Provider.of<LoginViewModel>(context);

    int selectedIndex = -1;

    return Scaffold(
      appBar: AppBar(
        title: Text('이전 대화 내용'),
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            //이전 페이지로 돌아가기
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder(
          future: hamburgerViewModel.pastChatList(loginViewModel.user),
          builder: (context, snapshot) {
            if (snapshot.connectionState ==
                ConnectionState.waiting) { // 데이터를 받아오는 중
              return CircularProgressIndicator(); // 데이터 로딩 표시기
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            } else {
              return Column(
                children: [
                  Expanded(
                      child: ListView.separated(
                        itemCount: hamburgerViewModel.chatList.length,
                        itemBuilder: (context, index) {
                          return ExpansionPanelRadio(
                              headerBuilder: (context, (context, isExpanded) {

                              })
                          )
                        },
                        separatorBuilder: (context, index) { // ListView의 구분선 속성
                          Divider(
                            color: Colors.lightBlue,
                            thickness: 3,
                          );
                        },
                      )
                  ),
                ],
              );
            }
          }
      ),

    );
  }
}
