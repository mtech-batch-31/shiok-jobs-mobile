import 'dart:async';
import 'package:shiok_jobs_flutter/Repository/secure_token_repository.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

enum SignInFlow { google, email }

class TokenBloc {
  TokenBloc._privateConstructor();

  static final TokenBloc _instance = TokenBloc._privateConstructor();

  factory TokenBloc() {
    return _instance;
  }

  final _tokenController = StreamController<String>.broadcast();
  Stream<String> get tokenStream => _tokenController.stream;

  final _tokenRepository = SecureRepository();

  late SignInFlow _signInflow;

  void setSignInFlow(SignInFlow signInFlow) {
    _signInflow = signInFlow;
  }

  void setToken(String token) async {
    await _tokenRepository.saveSecureToken(token);
    _tokenController.sink.add(token);
  }

  void deleteToken() async {
    await _tokenRepository.deleteSecureToken();
    _tokenController.sink.add('');
  }

  Future<String> getToken() async {
    if (_signInflow == SignInFlow.google) {
      final token = await getAmplifySignInToken();
      return token ?? '';
    } else {
      return await _tokenRepository.getSecureToken();
    }
  }

  Future<String?> getAmplifySignInToken() async {
    try {
      final cognitoPlugin =
          Amplify.Auth.getPlugin(AmplifyAuthCognito.pluginKey);
      final result = await cognitoPlugin.fetchAuthSession();
      final accessToken =
          result.userPoolTokensResult.valueOrNull?.accessToken.raw;
      return accessToken;
    } on AuthException catch (e) {
      safePrint('Error retrieving auth session: ${e.message}');
    }
    return null;
  }

  void dispose() {
    _tokenController.close();
  }
}
