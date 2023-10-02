import 'dart:convert';

import 'package:daedong3/model/login.dart';
import 'package:daedong3/repository/repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

class MockClient extends Mock implements http.Client {}

// 테스트 코드 실행 예외 처리 발생, 처리 못 함
@GenerateMocks([http.Client])
void main(){

  test('[API] 로그인 테스트', () async {
    final client = MockClient();
    final repository = Repository();

    Login testLogin = Login(schoolEmail: "qqq111@suwon.ac.kr", password: "1111");
    var encodedBody = jsonEncode(testLogin);

    when(client
    .post(Uri.parse('http://13.209.50.197:8080/daedong/login'),
    headers: {"Content-Type": "application/json"},
    body: encodedBody)).
        thenAnswer(
            (_) async => http.Response('{body:"success"}', 200));

    expect(await login(testLogin, client), isA<Login>());

  });
}