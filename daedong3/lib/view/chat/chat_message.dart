import 'package:daedong3/model/chat_item.dart';
import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  //final List<String> messages;
  //final String txt;
  final Animation<double> animation;
  final bool isMe;
  final ChatItem chatItem;

  const ChatMessage(
      this.chatItem, this.isMe ,{
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
                      Text(isMe ? "나" : "대동이", style: TextStyle(fontWeight: FontWeight.bold),),
                      // for (String message in messages)
                      Container(
                        child: Text(chatItem.question,style: TextStyle(color: isMe ? Colors.white : Colors.black, fontWeight: FontWeight.w500),),
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
                      ),
                      if (chatItem.answer.isNotEmpty)
                        // 답변이 비어 있지 않은 경우에만 표시
                        Container(
                          child: Text(chatItem.answer, style: TextStyle(color: isMe ? Colors.white : Colors.black, fontWeight: FontWeight.w500),),
                          padding: EdgeInsets.all(7.0),
                          decoration: BoxDecoration(
                            color: isMe ? Colors.lightBlueAccent : Colors.grey.shade400,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                              bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
                              bottomLeft: isMe ? Radius.circular(12) : Radius.circular(0),
                            ),
                            border: Border.all(color: isMe ? Colors.lightBlueAccent : Colors.grey.shade200,),
                          ),
                        ),
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

