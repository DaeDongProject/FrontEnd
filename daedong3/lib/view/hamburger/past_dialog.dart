import 'package:daedong3/viewmodel/hamburger_view_model.dart';
import 'package:daedong3/viewmodel/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PastDialog extends StatelessWidget{


  @override
  Widget build(BuildContext context) {

    final HamburgerViewModel hamburgerViewModel = Provider.of<HamburgerViewModel>(context);
    final LoginViewModel loginViewModel = Provider.of<LoginViewModel>(context);

    int selectedIndex = -1;

    // [1018] RenderViewport does not support returning intrinsic dimensions. 에러 생김
        return AlertDialog(
          title: const Text("대화창 열기"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                ListView.builder(
                  itemCount: hamburgerViewModel.chatList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(hamburgerViewModel.chatList[index].chatTitle),
                      tileColor: selectedIndex == index
                          ? Colors.blue
                          : Colors.white,
                      onTap: (){
                        // 항목 선택하면 인덱스 업데이트
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text("취소"),
              onPressed: (){
                Navigator.pop(context, );
              },
            ),
            ElevatedButton(
                onPressed: () => print("페이지 이동"),
                child: Text("확인"))
          ],
        );
  }
}