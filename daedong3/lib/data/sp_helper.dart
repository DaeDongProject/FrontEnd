import 'package:daedong3/data/personal_information.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SPHelper{
  static late SharedPreferences prefs;

  Future init() async{
    prefs = await SharedPreferences.getInstance();
  }

  Future writePersonalInformation(PersonalInformation personalInformation) async{
    prefs.setString(
        personalInformation.name.toString(),
        json.encode(personalInformation.toJson())
    );
  }
}