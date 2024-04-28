
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shiok_jobs_flutter/Data/request/user_profile_request.dart';
import 'package:shiok_jobs_flutter/Data/response/user_profile_response.dart';
import 'package:shiok_jobs_flutter/NetworkClient/network_client.dart';

class UserProfileRepository {
  final NetworkClient _networkClient = NetworkClient();
  final apiURL = dotenv.env['API_JOBS'];

  Future<UserProfileResponse?> getUserProfile(String token) async {
    final userProfileApiEndpoint = '$apiURL/users/v1/users/me';
    _networkClient.setHeaders({'Content-Type': 'application/json'});
    _networkClient.setHeaders({'Authorization': 'Bearer $token'});

    final response = await _networkClient.get(
      userProfileApiEndpoint,
    );

    return UserProfileResponse.fromJson(response);
  }

  Future<UserProfileResponse?> updateUserProfile(String token, UserProfileRequest userProfileRequest) async {
    final userProfileApiEndpoint = '$apiURL/users/v1/users';
    _networkClient.setHeaders({'Content-Type': 'application/json'});
    _networkClient.setHeaders({'Authorization': 'Bearer $token'});

    final response = await _networkClient.post(
      userProfileApiEndpoint, body: userProfileRequest.toJson()
    );
    print("update profile response " + response.toString());

    return UserProfileResponse.fromJson(response);
  }
}