import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shiok_jobs_flutter/Data/request/login_request.dart';
import 'package:shiok_jobs_flutter/Data/request/logout_request.dart';
import 'package:shiok_jobs_flutter/Data/response/login_response.dart';
import 'package:shiok_jobs_flutter/Data/response/logout_response.dart';
import 'package:shiok_jobs_flutter/NetworkClient/network_client.dart';

class LoginRepository {
  final NetworkClient _networkClient = NetworkClient();
  final apiURL = dotenv.env['API_URL'];

  Future<LoginResponse> login(
      {required String email, required String password}) async {
    final loginApiEndPoint = '$apiURL/auth/login';
    _networkClient.setHeaders({'Content-Type': 'application/json'});
    final request = LoginRequest(email: email, password: password);
    final response = await _networkClient.post(
      loginApiEndPoint,
      body: request.toJson(),
    );
    return LoginResponse.fromJson(response);
  }

  Future<LogoutResponse> logout({required String accessToken}) async {
    final logoutApiEndPoint = '$apiURL/auth/logout';
    _networkClient
        .setHeaders({'Content-Type': 'application/json', 'Accept': '*/*'});
    _networkClient.setHeaders({'Authorization': 'Bearer $accessToken'});
    _networkClient.setHeaders({'Cookie': 'accessToken=$accessToken'});
    final request = LogoutRequest(accessToken: accessToken);
    final response =
        await _networkClient.post(logoutApiEndPoint, body: request.toJson());
    return LogoutResponse.fromJson(response);
  }
}
