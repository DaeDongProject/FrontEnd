import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String txt;
  final Animation<double> animation;

  const ChatMessage(
      this.txt, {
        required this.animation,
        Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(

      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8 ),

      child: FadeTransition(
        opacity: animation,
        child: SizeTransition(
          sizeFactor: animation,
          axisAlignment: -1.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width:  16,
              ),
              Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("나", style: TextStyle(fontWeight: FontWeight.bold),),
                      Container(
                        child: Text(txt,style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
                        padding: EdgeInsets.all(7.0),
                        decoration: BoxDecoration(
                          color: Colors.lightBlueAccent,
                          borderRadius: BorderRadius.circular(20),
                          border : Border.all(color: Colors.lightBlueAccent,)
                        ),
                      )
                    ],
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}

