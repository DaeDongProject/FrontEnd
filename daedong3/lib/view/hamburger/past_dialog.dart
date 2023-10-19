import 'package:daedong3/model/chatRoom.dart';
import 'package:daedong3/model/past_chat.dart';
import 'package:flutter/material.dart';
import 'package:daedong3/repository/repository.dart';
import 'package:daedong3/viewmodel/hamburger_view_model.dart';

// ctqom


class PastDialog extends StatefulWidget {
  const PastDialog({Key? key}) : super(key: key);

  @override
  State<PastDialog> createState() => _PastDialogState();
}

class _PastDialogState extends State<PastDialog> {


  int selectedValue = 0;
  late Repository _repository = Repository();

  List<String> datas = [];
  List<String> objectChatId =[];

  final HamburgerViewModel _viewModel = HamburgerViewModel();


  @override
  void initState(){
    super.initState();
    _repository = Repository();
    //데이터를 가져와서 data리스트에 추가
    loadListData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('이전 대화 내용'),
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            //이전 페이지로 돌아가기
          },
        ),
      ),
      body: ListView.separated(
          physics: BouncingScrollPhysics(),
          itemCount: datas.length,
          itemBuilder: (BuildContext context, int index ){
              return ListView(
                children: <Widget>[
                  ...LoadList(),
                ],
              );
            }, separatorBuilder: (BuildContext context, int index){
            return Divider(thickness: 1,);},

          ),

      );
  }

  Future<void> loadListData() async {
    try{
      final pastChatList = await _viewModel.pastChatList(PastChat(chatTitle: "chatTitle", objectId: "objectId"));//userId 실제 우리가 쓰는걸로
      setState(() {
        //받아온 데이터를 각각의 리스트 맞게 넣음
        datas = pastChatList.map((chat) => chat.chatTitle).toList();
        objectChatId = pastChatList.map((chat) => chat.objectId).toList();
      });
    }catch(e){
      print("Error: $e");
    }
  }

  List<Widget> LoadList() {
    List<Widget> loadList = [];
    if(datas.length == 0){
      ListTile(
        title: Text('대화내역이 없습니다.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black.withOpacity(0.4)),
        ),
      );
    }
    else{
      for (int i = 0; i < datas.length;i++){
        loadList.add(
          ListTile(
            title: Text(datas[i]),
            onTap: () {
              //objectchatId를 datas에 맞게 인덱스별로 받아서 해당 인덱스로 이동
              //머리로 생각한거여서 될지가 ㅈㄴ게 의문이긴함
            },
            //다른거 추가 가능 나는 날짜정도를 넣고 싶은데
          ),
        );
      }
    }
    return loadList;
  }
}