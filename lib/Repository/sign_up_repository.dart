import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shiok_jobs_flutter/NetworkClient/network_client.dart';
import 'package:shiok_jobs_flutter/Data/request/confirm_sign_up_request.dart';
import 'package:shiok_jobs_flutter/Data/response/confirm_sign_up_response.dart';
import 'package:shiok_jobs_flutter/Data/response/signup_response.dart';
import 'package:shiok_jobs_flutter/Data/request/sign_up_request.dart';

class SignUpRepository {
  final NetworkClient _networkClient = NetworkClient();
  final apiURL = dotenv.env['API_URL'];

  Future<CodeDeliveryResponse> signUp(
      {required password, required email}) async {
    final request = SignUpRequest(
      password: password,
      email: email,
    );
    String signupApiEndPoint = '$apiURL/auth/SignUp';
    _networkClient.setHeaders({'Content-Type': 'application/json'});
    final response = await _networkClient.post(
      signupApiEndPoint,
      body: request.toJson(),
    );

    return CodeDeliveryResponse.fromJson(response);
  }

  Future<ConfirmSignUpResponse> sendEmailVerification(
      {required String email, required String pin}) async {
    // Send email verification
    final request = ConfirmSignUpRequest(email: email, code: pin);
    final String confimSignUpURL = "$apiURL/auth/confirmsignup";
    _networkClient.setHeaders({'Content-Type': 'application/json'});
    final response = await _networkClient.post(
      confimSignUpURL,
      body: request.toJson(),
    );

    return ConfirmSignUpResponse.fromJson(response);
  }
}
