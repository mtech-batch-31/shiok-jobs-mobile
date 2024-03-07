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

  signUp(
      {required String user,
      required String password,
      required String email}) async {
    signUpSink.add(ApiResponse.loading('Signing Up'));
    try {
      CodeDeliveryResponse response = await _signUpRepository.signUp(
          userName: user, password: password, email: email);
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
