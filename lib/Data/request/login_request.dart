class LoginRequest {
  final String? email;
  final String? password;

  LoginRequest({
    this.email,
    this.password,
  });

  toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}
