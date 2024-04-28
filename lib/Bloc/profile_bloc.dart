import 'dart:async';

import 'package:shiok_jobs_flutter/Bloc/token_bloc.dart';
import 'package:shiok_jobs_flutter/Data/request/user_profile_request.dart';
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

  updateUserEmail(String email, UserProfileResponse u ) async{
    try {
      print("trying to update email: " + email);
      // userProfileResponse.setEmail(email);
      UserProfileRequest userProfileRequest = UserProfileRequest(
          email: email,
          fullName: u.fullName,
          isSeekingJob: u.isSeekingJob,
          jobTitle: u.jobTitle,
          imageUrl: u.imageUrl,
          about: u.about,
          workExperiences: u.workExperiences,
          educationHistories: u.educationHistories
      );
      print("trying to update email: " + userProfileRequest.toJson().toString());

      final token = await TokenBloc().getToken();
      UserProfileResponse? newProfile = await _userProfileRepository.updateUserProfile(token, userProfileRequest);
      _userProfileController.sink.add(ApiResponse.completed(newProfile));
    } catch (e) {
      _userProfileController.sink.add(ApiResponse.error(e.toString()));
    }

  }
}