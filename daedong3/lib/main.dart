import 'package:daedong3/view/login.dart';
import 'package:daedong3/viewmodel/hamburger_view_model.dart';
import 'package:flutter/material.dart';
import 'package:daedong3/view/home_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'personal_information.dart';


void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_)=>HamburgerViewModel()),],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return MaterialApp(
        theme: ThemeData(
          appBarTheme: AppBarTheme(backgroundColor: Colors.lightBlueAccent)
        ),
        debugShowCheckedModeBanner: false,
      //home: HomePage(PersonalInformation('로그인 필요','')),
      home : Login(),
      initialRoute: '/login',
      onGenerateRoute: _getRoute,

    );

  }
}
//navigator 사용위한 루트
Route<dynamic>? _getRoute(RouteSettings settings){
  if(settings.name != '/login'){
    return null;
  }

  return MaterialPageRoute<void>(
      settings: settings,
      builder: (BuildContext context) => Login(),
      fullscreenDialog: true,
  );
}

