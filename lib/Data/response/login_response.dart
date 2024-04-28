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
      authenticationResult: json['authenticationResult'] != null
          ? AuthenticationResult(
              accessToken: json['authenticationResult']['accessToken'],
              expiresIn: json['authenticationResult']['expiresIn'],
              idToken: json['authenticationResult']['idToken'],
              newDeviceMetadata: json['authenticationResult']
                  ['newDeviceMetadata'],
              refreshToken: json['authenticationResult']['refreshToken'],
              tokenType: json['authenticationResult']['tokenType'],
            )
          : null,
      challengeParameters:
          json['challengeParameters'] != null ? ChallengeParameters() : null,
      clientMetadata:
          json['clientMetadata'] != null ? ChallengeParameters() : null,
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
}

class ChallengeParameters {
  ChallengeParameters();
}
