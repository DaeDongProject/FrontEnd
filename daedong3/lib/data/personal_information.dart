class PersonalInformation{ // 임시 작성 클래스
  late String name;
  late String university;

  PersonalInformation(this.name, this.university);

  PersonalInformation.fromJson(Map<String, String> personalInformationMap){
    name = personalInformationMap['name'] ?? "익명";
    university = personalInformationMap['university'] ?? "익명학교";
  }

  Map<String, String> toJson(){
    return {
      'name' : name,
      'university' : university
    };
  }

  String getName(){
    return name;
  }

  String getUniversity(){
    return university;
  }
}