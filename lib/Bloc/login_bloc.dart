import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shiok_jobs_flutter/Data/response/api_response.dart';
import 'package:shiok_jobs_flutter/Data/response/login_response.dart';
import 'package:shiok_jobs_flutter/Repository/login_repository.dart';

class LoginBloc {
  final _userController = StreamController<String>();
  final _passwordController = StreamController<String>();
  final _loginController = StreamController<ApiResponse<LoginResponse>>();
  final _loginRepository = LoginRepository();

  Stream<String> get user => _userController.stream.transform(validateUser);
  Stream<String> get password =>
      _passwordController.stream.transform(validatePassword);
  Stream<ApiResponse<LoginResponse>> get login => _loginController.stream;

  Stream<bool> get submitValid =>
      Rx.combineLatest2(user, password, (a, b) => true);

  Function(String) get changeUser => _userController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  final validateUser =
      StreamTransformer<String, String>.fromHandlers(handleData: (user, sink) {
    if (user.length > 3) {
      sink.add(user);
    } else {
      sink.addError('Username must be at least 4 characters');
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length > 3) {
      sink.add(password);
    } else {
      sink.addError('Password must be at least 4 characters');
    }
  });

  loginAuthenticate({
    required String user,
    required String password,
  }) {
    debugPrint('user: $user, Password: $password');
    _loginRepository.login(userName: user, password: password).then((response) {
      _loginController.sink.add(ApiResponse.completed(response));
    }).catchError((error) {
      _loginController.sink.add(ApiResponse.error(error.toString()));
    });
  }

  dispose() {
    _userController.close();
    _passwordController.close();
    _loginController.close();
  }
}