import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shiok_jobs_flutter/Data/request/apply_job_request.dart';
import 'package:shiok_jobs_flutter/Data/response/job_apply_response.dart';
import 'package:shiok_jobs_flutter/Data/response/job_detailed_response.dart';
import 'package:shiok_jobs_flutter/Data/response/job_listing_response.dart';
import 'package:shiok_jobs_flutter/NetworkClient/network_client.dart';
import 'package:shiok_jobs_flutter/Storage/secure_storage.dart';

class JobRepository {
  final NetworkClient _networkClient = NetworkClient();
  final apiURL = dotenv.env['API_JOBS'];

  Future<List<JobSummary>?> getAllJobs() async {
    final jobApiEndPoint = '$apiURL/jobs';
    debugPrint('Fetching all Jobs from $jobApiEndPoint');
    _networkClient.setHeaders({'Content-Type': 'application/json'});
    final response = await _networkClient.get(
      jobApiEndPoint,
    );
    return JobsListingResponse.fromJson(response).data;
  }

  Future<List<JobSummary>?> getJobsByKeyword(String keyword) async {
    final jobApiEndPoint = '$apiURL/jobs?keywords=$keyword';
    debugPrint('Fetching Jobs based on keywords from $jobApiEndPoint');
    _networkClient.setHeaders({'Content-Type': 'application/json'});
    final response = await _networkClient.get(
      jobApiEndPoint,
    );
    return JobsListingResponse.fromJson(response).data;
  }

  Future<JobDetail> getJobById(int id) async {
    final jobApiEndPoint = '$apiURL/jobs/details?id=$id';
    debugPrint('Fetching Job details from $jobApiEndPoint');
    _networkClient.setHeaders({'Content-Type': 'application/json'});
    final response = await _networkClient.get(
      jobApiEndPoint,
    );
    return JobDetail.fromJson(response);
  }

  Future<JobApplyResponse> applyJob(int id) async {
    final jobApiEndPoint = '$apiURL/jobs/apply';
    _networkClient.setHeaders({'Content-Type': 'application/json'});
    final bearerToken = await getAccessToken();
    if (bearerToken == null) {
      throw Exception('Bearer token is null');
    } else {
      _networkClient.setHeaders({'Authorization': 'Bearer $bearerToken'});
    }
    final request = JobApplyRequest(id: id);
    final response = await _networkClient.post(
      jobApiEndPoint,
      body: request.toJson(),
    );
    return JobApplyResponse.fromJson(response);
  }

  Future<String?> getAccessToken() async {
    return readAccessToken();
  }
}
