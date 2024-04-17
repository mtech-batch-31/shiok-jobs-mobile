import 'dart:async';

import 'package:shiok_jobs_flutter/Bloc/token_bloc.dart';
import 'package:shiok_jobs_flutter/Data/response/api_response.dart';
import 'package:shiok_jobs_flutter/Data/response/user_profile_response.dart';
import 'package:shiok_jobs_flutter/Repository/user_repository.dart';

class UserProfileBloc {
  final UserProfileRepository _userProfileRepository = UserProfileRepository();

  final _userProfileController = StreamController<ApiResponse<UserProfileResponse>>();

  Stream<ApiResponse<UserProfileResponse>> get userProfileStream {
    return _userProfileController.stream;
  }

  getUserProfileAsync() async {
    try {
      _userProfileController.sink.add(ApiResponse.loading('Fetching User profile'));
      final token = await TokenBloc().getToken();
      UserProfileResponse? userProfileResponse = await _userProfileRepository.getUserProfile(token);
      _userProfileController.sink.add(ApiResponse.completed(userProfileResponse));
    } catch (e) {
      _userProfileController.sink.add(ApiResponse.error(e.toString()));
    }
  }
}