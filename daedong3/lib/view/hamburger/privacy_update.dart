import 'package:daedong3/personal_information.dart';
import 'package:flutter/material.dart';
import '../../config/sp_helper.dart';
import 'package:daedong3/personal_information.dart';
import 'package:flutter/material.dart';

class PrivacyUpdate extends StatelessWidget{
  PrivacyUpdate({super.key});

  final TextEditingController txtName = TextEditingController();
  //대학교 명은 '수원대학교'로 초기값 놓고 고정시킴
  final TextEditingController txtUniversity = TextEditingController();
  final SPHelper helper = SPHelper();

  String textName='';
  String textUniversity='';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("개인정보 변경"),
      content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                onChanged: (text){

                },
                controller: txtName,
                decoration: InputDecoration(labelText: "이름"),
              ),
              TextField(
                onChanged: (text){

                },
                controller: txtUniversity,
                readOnly: true,
                decoration: InputDecoration(labelText: "소속 학교"),
              )
            ],
          )
      ),
      actions: [
        TextButton(
          child: Text("Cancel"),
          onPressed: (){
            Navigator.pop(context, );
          },
        ),
        SizedBox(height: 16,),
        ElevatedButton(
          onPressed: (){

          },
          style: ElevatedButton.styleFrom(
            backgroundColor: (textName.isNotEmpty && textUniversity.isNotEmpty) ? Colors.blue : Colors.grey,
          ),
          child: Text("Save"),
        ),
      ],
    );
  }
}