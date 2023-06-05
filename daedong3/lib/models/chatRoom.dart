class ChatRoom {
  String id;
  String userId;
  String chatTitle;
  List<Object> contextUser;
  bool deleteYn;

  ChatRoom({required this.id, required this.userId, required this.chatTitle, required this.contextUser, required this.deleteYn});
}