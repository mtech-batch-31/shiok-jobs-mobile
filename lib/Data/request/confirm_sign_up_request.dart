class ConfirmSignUpRequest {
  final String email;
  final String code;

  ConfirmSignUpRequest({
    required this.email,
    required this.code,
  });

  toJson() {
    return {
      'email': email,
      'code': code,
    };
  }
}
