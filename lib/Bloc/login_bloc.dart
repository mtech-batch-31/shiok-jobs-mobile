import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:shiok_jobs_flutter/Data/response/api_response.dart';
import 'package:shiok_jobs_flutter/Data/response/login_response.dart';
import 'package:shiok_jobs_flutter/Repository/login_repository.dart';
import 'package:shiok_jobs_flutter/Storage/secure_storage.dart';

class LoginBloc {
  final _userController = StreamController<String>();
  final _passwordController = StreamController<String>();
  final _loginController = StreamController<ApiResponse<LoginResponse>>();
  final _loginRepository = LoginRepository();

  Stream<String> get email => _userController.stream.transform(validateEmail);
  Stream<String> get password =>
      _passwordController.stream.transform(validatePassword);
  Stream<ApiResponse<LoginResponse>> get login => _loginController.stream;

  Stream<bool> get submitValid =>
      Rx.combineLatest2(email, password, (a, b) => true);

  Function(String) get changeUser => _userController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (emailRegex.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError('Email invalid');
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    final RegExp passwordRegex = RegExp(r'^[A-Za-z0-9!@#$%^&*-]{12,}$');
    if (passwordRegex.hasMatch(password)) {
      sink.add(password);
    } else {
      sink.addError('Password must be at least 4 characters');
    }
  });

  loginAuthenticate({
    required String email,
    required String password,
  }) {
    try {
      _loginController.sink.add(ApiResponse.loading('Logging In'));
      _loginRepository.login(email: email, password: password).then((response) {
        _loginController.sink.add(ApiResponse.completed(response));
        if (response.authenticationResult?.accessToken != null) {
          writeAccessToken(response.authenticationResult?.accessToken ?? '');
        }
      }).catchError((error) {
        _loginController.sink.add(ApiResponse.error(error.toString()));
      });
    } catch (e) {
      _loginController.sink.add(ApiResponse.error(e.toString()));
    }
  }

  dispose() {
    _userController.close();
    _passwordController.close();
    _loginController.close();
  }
}
