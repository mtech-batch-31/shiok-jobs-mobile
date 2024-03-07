class ConfirmSignUpRequest {
  final String username;
  final String code;

  ConfirmSignUpRequest({
    required this.username,
    required this.code,
  });

  toJson() {
    return {
      'username': username,
      'code': code,
    };
  }
}
