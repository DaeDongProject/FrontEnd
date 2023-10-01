class InfoModifyRequest{
  String id;
  int contextIndex;
  String text;

  InfoModifyRequest({
    required this.id,
    required this.contextIndex,
    required this.text
  });

  Map<String, dynamic> toJson(){
    return{
      "_id": id,
      "contextIndex": contextIndex,
      "text": text
    };
  }
}