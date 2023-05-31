import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp( DaeDong());
}

class DaeDong extends StatelessWidget {
  //const DaeDong({Key? key}) : super(key: key);

  final messageController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Today, ${DateFormat("Hm").format(DateTime.now())}",style: TextStyle(
            fontSize: 20
          )),
          centerTitle: true,
          elevation: 0.0 ,



        ),
        body: Container(
          child: Column(

            children: [
              Center(
                child: Container(
                  padding:  EdgeInsets.only(top: 15,bottom: 10),

                ),
              ),

              Flexible(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: 0,
                    itemBuilder: (context, index){},
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




                      }
                    },
                  ),
                ),
              )

            ],
          ),
        ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text("김승민"),
              accountEmail: Text("수원대학교"),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/'),
                backgroundColor: Colors.lightBlueAccent,
              ),


            ),
            ListTile(
              leading: Icon(Icons.settings, color: Colors.grey[850],),
              title: Text("개인정보 수정"),
              onTap: () => {
                print("개인정보 수정 창 ")
              },
              trailing: Icon(Icons.arrow_right),
            ),
            ListTile(
              leading: Icon(Icons.add_box, color: Colors.grey[850],),
              title: Text("New Chat"),
              onTap: () => {
                print("채팅창 리프레쉬")
              },
              trailing: Icon(Icons.arrow_right),
            ),

            ListTile(
              leading: Icon(Icons.content_paste_go, color: Colors.grey[850],),
              title: Text("이전 대화 내용"),
              onTap: () => {
              print("팝업창을 이용하여 대화내역 불러오기")
            },
              trailing: Icon(Icons.arrow_right),
            ),





          ],
        ),
      ),
      )
    );
  }
}








