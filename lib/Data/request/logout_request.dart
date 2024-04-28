class LogoutRequest {
  final String? accessToken;

  LogoutRequest({
    this.accessToken,
  });

  toJson() {
    return accessToken;
  }
}
