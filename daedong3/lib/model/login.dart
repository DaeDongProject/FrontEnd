class Login{
  String schoolEmail;
  String password;

  Login(
      {
        required this.schoolEmail,
        required this.password
      }
      );

  Map<String, dynamic> toJson(){
    return{
      "schoolEmail": schoolEmail,
      "password": password
    };
  }
}