class SignUpRequest {
  final String? username;
  final String? password;
  final String? email;

  SignUpRequest({
    this.username,
    this.password,
    this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'email': email,
    };
  }
}
