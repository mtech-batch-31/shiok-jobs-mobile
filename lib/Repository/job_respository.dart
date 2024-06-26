import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shiok_jobs_flutter/Data/request/apply_job_request.dart';
import 'package:shiok_jobs_flutter/Data/response/job_apply_response.dart';
import 'package:shiok_jobs_flutter/Data/response/job_detailed_response.dart';
import 'package:shiok_jobs_flutter/Data/response/job_listing_response.dart';
import 'package:shiok_jobs_flutter/NetworkClient/network_client.dart';

class JobRepository {
  final NetworkClient _networkClient = NetworkClient();
  final apiURL = dotenv.env['API_JOBS'];

  Future<List<JobSummary>?> getAllJobs() async {
    final jobApiEndPoint = '$apiURL/jobs';
    _networkClient.setHeaders({'Content-Type': 'application/json'});
    final response = await _networkClient.get(
      jobApiEndPoint,
    );
    return JobsListingResponse.fromJson(response).data;
  }

  Future<List<JobSummary>?> getJobsByKeyword(String keyword) async {
    final jobApiEndPoint = '$apiURL/jobs?keywords=$keyword';
    _networkClient.setHeaders({'Content-Type': 'application/json'});
    final response = await _networkClient.get(
      jobApiEndPoint,
    );
    return JobsListingResponse.fromJson(response).data;
  }

  Future<JobDetail> getJobById(int id) async {
    final jobApiEndPoint = '$apiURL/jobs/details?id=$id';
    _networkClient.setHeaders({'Content-Type': 'application/json'});
    final response = await _networkClient.get(
      jobApiEndPoint,
    );
    return JobDetail.fromJson(response);
  }

  Future<JobApplyResponse> applyJob(int id, String token) async {
    final jobApiEndPoint = '$apiURL/jobs/apply';
    final bearerToken = token;
    _networkClient.setHeaders({'Content-Type': 'application/json'});
    _networkClient.setHeaders({'Authorization': 'Bearer $bearerToken'});
    final request = JobApplyRequest(id: id);
    final response = await _networkClient.post(
      jobApiEndPoint,
      body: request.toJson(),
    );
    return JobApplyResponse.fromJson(response);
  }
}
