class Context {
  String question;
  String answer;
  bool isDialogflow;
  bool modifyRequest;
  String modifyText;

  Context(
      {required this.question,
      required this.answer,
      required this.isDialogflow,
      required this.modifyRequest,
      required this.modifyText});
}
