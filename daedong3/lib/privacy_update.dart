import 'package:daedong3/data/personal_information.dart';
import 'package:flutter/material.dart';
import 'data/sp_helper.dart';

class PrivacyUpdate extends StatefulWidget {
  const PrivacyUpdate({Key? key, required PersonalInformation information}) : super(key: key);


  @override
  State<PrivacyUpdate> createState() => _PrivacyUpdate();
}

class _PrivacyUpdate extends State<PrivacyUpdate> {

  final TextEditingController txtName = TextEditingController();
  final TextEditingController txtUniversity = TextEditingController();
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
            textName.isNotEmpty && textUniversity.isNotEmpty ?
            updatePersonalInformation()
                : null;
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