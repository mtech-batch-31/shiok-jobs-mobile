class LoginRequest {
  final String? username;
  final String? password;

  LoginRequest({
    this.username,
    this.password,
  });

  toJson() {
    return {
      'username': username,
      'password': password,
    };
  }
}
