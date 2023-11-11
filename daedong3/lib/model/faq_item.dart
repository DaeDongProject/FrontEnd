import 'package:daedong3/model/faq_data.dart';

class FaqItem{
  String id;
  String topic;
  String subTopic;
  List<dynamic> faq; // List의 데이터 타입은 FaqData
  bool isExpanded;

  FaqItem({
    required this.id,
    required this.topic,
    required this.subTopic,
    required this.faq,
    this.isExpanded = false,
  });

  factory FaqItem.fromJson(Map<String, dynamic> json){
    return FaqItem(
      id: json["id"],
      topic: json["topic"],
      subTopic: json["subTopic"],
      faq: json["faq"],
    );
  }
}