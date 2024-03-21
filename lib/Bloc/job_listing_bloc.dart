import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shiok_jobs_flutter/Data/response/api_response.dart';
import 'package:shiok_jobs_flutter/Repository/job_respository.dart';
import 'package:shiok_jobs_flutter/Data/response/job_listing_response.dart';

class JobListingBloc {
  final JobRepository _jobRepository = JobRepository();
  final _jobListController = StreamController<ApiResponse<List<JobSummary>>>();

  Stream<ApiResponse<List<JobSummary>>> get jobListStream {
    return _jobListController.stream;
  }

  getAllJobList() async {
    try {
      debugPrint('Fetching Jobs');
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

  dispose() {
    _jobListController.close();
    _jobListController.sink.close();
  }
}
