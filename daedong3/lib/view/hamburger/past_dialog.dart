import 'package:flutter/material.dart';

class PastDialog extends StatefulWidget {
  const PastDialog({Key? key}) : super(key: key);

  @override
  State<PastDialog> createState() => _PastDialogState();
}

class _PastDialogState extends State<PastDialog> {
  int selectedValue = 0;

  List<String> datas = ['data 1', 'data 2', 'data 3'];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("대화창 열기"),
      content: SingleChildScrollView(
        child: Column(
          children: datas.map((String data) {
            int index = datas.indexOf(data);
            return RadioListTile<int>(
              title: Text(data),
              value: index,
              groupValue: selectedValue,
              onChanged: (value){
                setState(() {
                  selectedValue = value!;
                });
              },
              activeColor: Colors.lightBlue,
              controlAffinity: ListTileControlAffinity.trailing,

            );
          }).toList(),
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