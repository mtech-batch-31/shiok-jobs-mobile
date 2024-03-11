import 'dart:async';
import 'package:shiok_jobs_flutter/Data/response/api_response.dart';
import 'package:shiok_jobs_flutter/Data/response/confirm_sign_up_response.dart';
import 'package:shiok_jobs_flutter/Repository/sign_up_repository.dart';

class ConfirmSignUpBloc {
  final SignUpRepository _signUpRepository = SignUpRepository();
  final StreamController<ApiResponse<ConfirmSignUpResponse>> _signUpController =
      StreamController<ApiResponse<ConfirmSignUpResponse>>();

  StreamSink<ApiResponse<ConfirmSignUpResponse>> get signUpSink =>
      _signUpController.sink;

  Stream<ApiResponse<ConfirmSignUpResponse>> get signUpStream {
    return _signUpController.stream;
  }

  sendEmailVerification({required String email, required String pin}) async {
    signUpSink.add(ApiResponse.loading('Sending Email Verification'));
    try {
      ConfirmSignUpResponse response =
          await _signUpRepository.sendEmailVerification(user: email, pin: pin);
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
