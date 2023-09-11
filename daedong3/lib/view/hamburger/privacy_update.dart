import 'package:daedong3/personal_information.dart';
import 'package:flutter/material.dart';
import '../../config/sp_helper.dart';

class PrivacyUpdate extends StatefulWidget {
  const PrivacyUpdate({Key? key, required PersonalInformation information}) : super(key: key);

  @override
  State<PrivacyUpdate> createState() => _PrivacyUpdate();
}

class _PrivacyUpdate extends State<PrivacyUpdate> {

  final TextEditingController txtName = TextEditingController();
  // 대학교 명은 '수원대학교'로 초기값 놓고 고정시킴
  final TextEditingController txtUniversity = TextEditingController(text: "수원대학교"); // 초기값 설정
  final SPHelper helper = SPHelper();

  String textName='';
  String textUniversity='';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    helper.init();
  }

  Future updatePersonalInformation() async{
    PersonalInformation newPersonalInformation = PersonalInformation(txtName.text, txtUniversity.text);
    helper.writePersonalInformation(newPersonalInformation);
    txtName.text = '';
    txtUniversity.text = '';
    Navigator.pop(context, newPersonalInformation);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("개인정보 변경"),
      content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                onChanged: (text){
                  setState(() {
                    textName = text;
                  });
                },
                controller: txtName,
                decoration: InputDecoration(labelText: "이름"),
              ),
              TextField(
                onChanged: (text){
                  setState(() {
                    textUniversity = text;
                  });
                },
                controller: txtUniversity,
                readOnly: true, // 변경 불가 프로퍼티
                decoration: InputDecoration(labelText: "소속 학교"), //학교 입력 시 코드
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
            textName.isNotEmpty? // && textUniversity.isNotEmpty -> 대학 변경 가능 시 바꿀 코드
            updatePersonalInformation()
                : null;
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: (textName.isNotEmpty) ? Colors.blue : Colors.grey,
          ),
          child: Text("Save"),
        ),
      ],
    );
  }
}