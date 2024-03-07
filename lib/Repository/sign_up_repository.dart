import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shiok_jobs_flutter/NetworkClient/network_client.dart';
import 'package:shiok_jobs_flutter/Data/request/confirm_sign_up_request.dart';
import 'package:shiok_jobs_flutter/Data/response/confirm_sign_up_response.dart';

class SignUpRepository {
  final NetworkClient _networkClient = NetworkClient();
  final apiURL = dotenv.env['API_URL'];

  Future<ConfirmSignUpResponse> sendEmailVerification(
      {required String user, required String pin}) async {
    // Send email verification
    final request = ConfirmSignUpRequest(username: user, code: pin);
    _networkClient.setHeaders({'Content-Type': 'application/json'});
    final response = await _networkClient.post(
      '$apiURL/auth/ConfirmSignup',
      body: request.toJson(),
    );

    return ConfirmSignUpResponse.fromJson(response);
  }
}
