import '../datasource/datasource.dart';
import '../model/question.dart';
import '../model/user.dart';

class Repository{
  final DataSource _dataSource = DataSource();

  // 채팅 생성
  Future<String> createChatRoom(User user) async {
    return _dataSource.createChatRoom(user);
  }

  // 사용자 질문
  Future<String> answerQuestion(Question question) async {
    return _dataSource.answerQuestion(question);
  }
}