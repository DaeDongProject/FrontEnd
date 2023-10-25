import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String txt;
  final Animation<double> animation;
  final bool isMe;

  const ChatMessage(
      this.txt, this.isMe ,{
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
            mainAxisAlignment: isMe ?  MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              SizedBox(
                width:  16,
              ),
              Flexible(
                  child: Column(
                    crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                    children: [
                      Text("나", style: TextStyle(fontWeight: FontWeight.bold),),
                      Container(
                        child: Text(txt,style: TextStyle(color: isMe ? Colors.white : Colors.black, fontWeight: FontWeight.w500),),
                        padding: EdgeInsets.all(7.0),
                        decoration: BoxDecoration(
                          color: isMe ? Colors.lightBlueAccent : Colors.grey.shade400,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                            bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
                            bottomLeft: isMe ? Radius.circular(12) : Radius.circular(0),
                          ),
                          border : Border.all(color: isMe ? Colors.lightBlueAccent : Colors.grey.shade200,)
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

