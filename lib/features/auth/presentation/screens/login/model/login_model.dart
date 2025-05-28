class LoginModel {
  final String email;
  final String password;
  final String userToken;

  LoginModel({
    required this.email,
    required this.password,
    required this.userToken,
  });

  Map<String, dynamic> toJson() {
    return {'email': email, 'password': password, 'userToken': userToken};
  }
}
