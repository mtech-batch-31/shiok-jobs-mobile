import 'dart:async';
import 'package:shiok_jobs_flutter/Data/response/api_response.dart';
import 'package:shiok_jobs_flutter/Data/response/login_response.dart';
import 'package:shiok_jobs_flutter/Repository/login_repository.dart';
import 'package:shiok_jobs_flutter/Bloc/token_bloc.dart';

class LoginBloc {
  final _loginController = StreamController<ApiResponse<LoginResponse>>();
  final _loginRepository = LoginRepository();

  Stream<ApiResponse<LoginResponse>> get login => _loginController.stream;

  String? validateEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (emailRegex.hasMatch(email)) {
      return null;
    } else {
      return 'Email invalid';
    }
  }

  String? validatePassword(String password) {
    final RegExp passwordRegex = RegExp(r'^[A-Za-z0-9!@#$%^&*-]{12,}$');
    if (passwordRegex.hasMatch(password)) {
      return null;
    } else {
      return 'Password must be at least 12 characters with special characters';
    }
  }

  loginAuthenticate({
    required String email,
    required String password,
  }) {
    String? isEmailError = validateEmail(email);
    String? isPasswordError = validatePassword(password);
    if (isEmailError != null || isPasswordError != null) {
      _loginController.add(ApiResponse.error(isEmailError ?? isPasswordError));
      return;
    }

    try {
      _loginController.sink.add(ApiResponse.loading('Logging In'));
      _loginRepository.login(email: email, password: password).then((response) {
        _loginController.sink.add(ApiResponse.completed(response));
        TokenBloc().setToken(response.authenticationResult?.accessToken ?? '');
      }).catchError((error) {
        _loginController.sink.add(ApiResponse.error(error.toString()));
      });
    } catch (e) {
      _loginController.sink.add(ApiResponse.error(e.toString()));
    }
  }

  dispose() {
    _loginController.close();
  }
}
