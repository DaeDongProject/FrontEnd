import 'package:daedong3/viewmodel/hamburger_view_model.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:daedong3/model/faq_item.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 8,),
            DropdownButton<FaqItem>(
                value: hamburgerViewModel.selectedFaq,
                items: hamburgerViewModel.faqDataList.map<DropdownMenuItem<FaqItem>>((FaqItem faqItem) {
                  return DropdownMenuItem<FaqItem>(
                    value: faqItem,
                    child: Text(faqItem.topic),
                  );
                }).toList(),
                onChanged: (value){
                  setState(() {
                    hamburgerViewModel.selectedFaq = value!;
                    hamburgerViewModel.faqExpandedList = List.generate(hamburgerViewModel.selectedFaq.faq.length, (index) => false);
                  });
                }
            ),
            SizedBox(height: 10,),
            Column(
              children: [
                ExpansionPanelList(
                  elevation: 1,
                  expandedHeaderPadding: EdgeInsets.all(0),
                  expansionCallback: (int index, bool isExpanded){
                    // ExpansionPanelList 펼침/닫힘 로직 구현
                    setState(() {
                      hamburgerViewModel.faqExpandedList[index] = isExpanded;
                    });

                  },
                  children: hamburgerViewModel.selectedFaq.faq.asMap().entries.map((entry) {
                    final int index = entry.key;
                    final Map<String, dynamic> faqItem = entry.value;

                    return ExpansionPanel(
                      canTapOnHeader: true,
                      headerBuilder: (BuildContext context, bool isExpanded){
                        return ListTile(
                          title: Text(faqItem['faqTitle']),
                        );
                      },
                      isExpanded: hamburgerViewModel.faqExpandedList[index],
                      body: ListTile(
                        title: Text(faqItem['faqAnswer']),
                      ),
                    );
                  }).toList(),
                ),
              ]

              ),

          ],
        ),
      ),
    );
  }
}
