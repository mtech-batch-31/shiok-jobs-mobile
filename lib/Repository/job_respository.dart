import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shiok_jobs_flutter/Data/response/job_detailed_response.dart';
import 'package:shiok_jobs_flutter/Data/response/job_listing_response.dart';
import 'package:shiok_jobs_flutter/NetworkClient/network_client.dart';

class JobRepository {
  final NetworkClient _networkClient = NetworkClient();
  final apiURL = dotenv.env['API_JOBS'];

  Future<List<JobSummary>?> getAllJobs() async {
    final jobApiEndPoint = '$apiURL/jobs/all';
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
    final jobApiEndPoint = '$apiURL/jobs/$id';
    _networkClient.setHeaders({'Content-Type': 'application/json'});
    final response = await _networkClient.get(
      jobApiEndPoint,
    );
    return JobDetail.fromJson(response);
  }
}
