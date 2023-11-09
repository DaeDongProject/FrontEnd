import 'package:daedong3/viewmodel/hamburger_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Faq extends StatefulWidget {
  const Faq({Key? key}) : super(key: key);

  @override
  State<Faq> createState() => _FaqState();
}

class _FaqState extends State<Faq> {
  @override
  Widget build(BuildContext context) {
    HamburgerViewModel hamburgerViewModel =
        Provider.of<HamburgerViewModel>(context);

    Faq selectedFaq = hamburgerViewModel.faqDataList;

    return Scaffold(
      appBar: AppBar(
        title: Text('자주 묻는 질문'),
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); //이전 페이지로 돌아가기
          },
        ),
      ),
      body: Column(
        children: [
          DropdownButton<String>(
              value: selectedCategory,
              items: hamburgerViewModel.faqDataList.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value.topic,
                  child: Text(value.topic),
                );
              }),
              onChanged: (String? newValue){
                setState(() {
                  selectedCategory = newValue!;
                });
              }
          )
        ],
      ),
    );
  }
}
