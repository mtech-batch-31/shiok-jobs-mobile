import 'dart:async';
import 'package:shiok_jobs_flutter/Data/response/api_response.dart';
import 'package:shiok_jobs_flutter/Repository/sign_up_repository.dart';
import 'package:shiok_jobs_flutter/Data/response/signup_response.dart';

class SignUpBloc {
  final SignUpRepository _signUpRepository = SignUpRepository();
  final StreamController<ApiResponse<CodeDeliveryResponse>> _signUpController =
      StreamController<ApiResponse<CodeDeliveryResponse>>();

  StreamSink<ApiResponse<CodeDeliveryResponse>> get signUpSink =>
      _signUpController.sink;
  Stream<ApiResponse<CodeDeliveryResponse>> get signUpStream {
    return _signUpController.stream;
  }

  validateEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (emailRegex.hasMatch(email)) {
      return email;
    } else {
      return 'Email invalid';
    }
  }

  validatePassword(String password) {
    final RegExp passwordRegex = RegExp(r'^[A-Za-z0-9!@#$%^&*-]{12,}$');
    if (passwordRegex.hasMatch(password)) {
      return password;
    } else {
      return 'Password must be at least 12 characters with special characters';
    }
  }

  signUp({required String password, required String email}) async {
    signUpSink.add(ApiResponse.loading('Signing Up'));
    try {
      CodeDeliveryResponse response =
          await _signUpRepository.signUp(password: password, email: email);
      signUpSink.add(ApiResponse.completed(response));
    } catch (e) {
      signUpSink.add(ApiResponse.error(e.toString()));
      //debugPrint(g);
    }
  }

  dispose() {
    _signUpController.close();
  }
}
