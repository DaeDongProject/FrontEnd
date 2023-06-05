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
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.lightBlueAccent,
                    child: Text("나"),
                  ),
                ],
              ),
              SizedBox(
                width:  16,
              ),
              Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text("ID or Name", style: TextStyle(fontWeight: FontWeight.bold),),
                      Text(txt),
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
