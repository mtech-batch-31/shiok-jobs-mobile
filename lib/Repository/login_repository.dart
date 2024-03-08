import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shiok_jobs_flutter/Data/request/login_request.dart';
import 'package:shiok_jobs_flutter/Data/response/login_response.dart';
import 'package:shiok_jobs_flutter/NetworkClient/network_client.dart';

class LoginRepository {
  final NetworkClient _networkClient = NetworkClient();
  final apiURL = dotenv.env['API_URL'];

  Future<LoginResponse> login(
      {required String userName, required String password}) async {
    final loginApiEndPoint = '$apiURL/auth/login';
    _networkClient.setHeaders({'Content-Type': 'application/json'});
    final request = LoginRequest(username: userName, password: password);
    final response = await _networkClient.post(
      loginApiEndPoint,
      body: request.toJson(),
    );
    return LoginResponse.fromJson(response);
  }
}
