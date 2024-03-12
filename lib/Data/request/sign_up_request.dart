class SignUpRequest {
  final String? password;
  final String? email;

  SignUpRequest({
    this.password,
    this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'password': password,
      'email': email,
    };
  }
}
