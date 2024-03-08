class LoginResponse {
  final dynamic sessionId;
  final dynamic challengeName;
  final AuthenticationResult? authenticationResult;
  final ChallengeParameters? challengeParameters;
  final ChallengeParameters? clientMetadata;

  LoginResponse({
    this.sessionId,
    this.challengeName,
    this.authenticationResult,
    this.challengeParameters,
    this.clientMetadata,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      sessionId: json['sessionId'],
      challengeName: json['challengeName'],
      authenticationResult: json['authenticationResult'],
      challengeParameters: json['challengeParameters'],
      clientMetadata: json['clientMetadata'],
    );
  }
}

class AuthenticationResult {
  final String? accessToken;
  final int? expiresIn;
  final String? idToken;
  final dynamic newDeviceMetadata;
  final String? refreshToken;
  final String? tokenType;

  AuthenticationResult({
    this.accessToken,
    this.expiresIn,
    this.idToken,
    this.newDeviceMetadata,
    this.refreshToken,
    this.tokenType,
  });

  toJson() {
    return {
      'accessToken': accessToken,
      'expiresIn': expiresIn,
      'idToken': idToken,
      'newDeviceMetadata': newDeviceMetadata,
      'refreshToken': refreshToken,
      'tokenType': tokenType,
    };
  }
}

class ChallengeParameters {
  ChallengeParameters();
}
