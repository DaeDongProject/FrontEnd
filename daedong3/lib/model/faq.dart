import 'package:daedong3/model/faq_data.dart';

class Faq{
  String id;
  String topic;
  String subTopic;
  List<FaqData> faq;

  Faq({
    required this.id,
    required this.topic,
    required this.subTopic,
    required this.faq
  });

  factory Faq.fromJson(Map<String, dynamic> json){
    return Faq(
      id: json["id"],
      topic: json["topic"],
      subTopic: json["subTopic"],
      faq: json["faq"],
    );
  }
}