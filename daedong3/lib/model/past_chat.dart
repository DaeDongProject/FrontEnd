class PastChat {
  String chatTitle;
  String objectId;

  PastChat({
    required this.chatTitle,
    required this.objectId
  });

  factory PastChat.fromJson(Map<String, dynamic> json){
    return PastChat(
        chatTitle: json["chatTitle"],
        objectId: json["objectId"]
    );
  }
}