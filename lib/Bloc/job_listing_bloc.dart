import 'dart:async';
import 'package:shiok_jobs_flutter/Data/response/api_response.dart';
import 'package:shiok_jobs_flutter/Data/response/job_apply_response.dart';
import 'package:shiok_jobs_flutter/Data/response/job_detailed_response.dart';
import 'package:shiok_jobs_flutter/Repository/job_respository.dart';
import 'package:shiok_jobs_flutter/Data/response/job_listing_response.dart';
import 'package:shiok_jobs_flutter/Bloc/token_bloc.dart';

class JobListingBloc {
  final JobRepository _jobRepository = JobRepository();

  final _jobListController = StreamController<ApiResponse<List<JobSummary>>>();
  Stream<ApiResponse<List<JobSummary>>> get jobListStream {
    return _jobListController.stream;
  }

  final _jobDetailController = StreamController<ApiResponse<JobDetail>>();
  Stream<ApiResponse<JobDetail>> get jobDetailStream {
    return _jobDetailController.stream;
  }

  final _jobApplyController = StreamController<ApiResponse<JobApplyResponse>>();
  Stream<ApiResponse<JobApplyResponse>> get jobApplyStream {
    return _jobApplyController.stream;
  }

  getAllJobList() async {
    try {
      _jobListController.sink.add(ApiResponse.loading('Fetching Jobs'));
      List<JobSummary> jobList =
          await _jobRepository.getAllJobs() as List<JobSummary>;
      _jobListController.sink.add(ApiResponse.completed(jobList));
    } catch (e) {
      _jobListController.sink.add(ApiResponse.error(e.toString()));
    }
  }

  getJobListByKeyword(String keyword) async {
    try {
      _jobListController.sink.add(ApiResponse.loading('Fetching Jobs'));
      List<JobSummary> jobList =
          await _jobRepository.getJobsByKeyword(keyword) as List<JobSummary>;
      _jobListController.sink.add(ApiResponse.completed(jobList));
    } catch (e) {
      _jobListController.sink.add(ApiResponse.error(e.toString()));
    }
  }

  getJobById(int id) async {
    try {
      _jobDetailController.sink.add(ApiResponse.loading('Fetching Job'));
      JobDetail job = await _jobRepository.getJobById(id);
      _jobDetailController.sink.add(ApiResponse.completed(job));
    } catch (e) {
      _jobDetailController.sink.add(ApiResponse.error(e.toString()));
    }
  }

  applyJob(int id) async {
    try {
      _jobApplyController.sink
          .add(ApiResponse.loading('Applying Job In Progress'));
      final token = await TokenBloc().getToken();
      JobApplyResponse jobResponse = await _jobRepository.applyJob(id, token);
      _jobApplyController.sink.add(ApiResponse.completed(jobResponse));
    } catch (e) {
      _jobDetailController.sink.add(ApiResponse.error(e.toString()));
    }
  }

  dispose() {
    _jobListController.close();
    _jobDetailController.close();
    _jobApplyController.close();
  }
}
