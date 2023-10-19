import 'package:daedong3/viewmodel/chat_view_model.dart';
import 'package:daedong3/viewmodel/login_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../model/chat_room.dart';
import '../model/past_chat.dart';
import '../model/user.dart';
import '../model/past_chat.dart';
import '../repository/repository.dart';

class HamburgerViewModel with ChangeNotifier{
  late final Repository _repository = Repository();
  late LoginViewModel loginViewModel;
  late ChatViewModel chatViewModel;

  String newChatOid = ""; // 새 채팅방 아이디

  // New Chat 버튼 클릭 시 user 채팅 목록에 새 채팅 id 추가
  Future createChatRoom(BuildContext context, User user) async {
    newChatOid = await _repository.createChatRoom(user);

    if(!context.mounted) return; // 비동기 처리 후 Provider를 쓸 때 위젯이 마운트되지 않는 걸 방지
    loginViewModel = Provider.of<LoginViewModel>(context, listen:false);

    loginViewModel.user.chatRoomOid.add(newChatOid); // user의 채팅 리스트에 새로운 채팅방id 추가

    notifyListeners(); // Provider Listener에게 변화 알리기
  }

  List<PastChat> chatList = []; // 채팅방 목록을 담을 변수

  // 채팅방 목록 반환하는 함수
  Future pastChatList(User user) async {
    chatList = await _repository.pastChatList(user.id);

    notifyListeners();
  }

  Future logout() async {
    await _repository.logout();
  }
}