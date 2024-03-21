import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shiok_jobs_flutter/Data/response/api_response.dart';
import 'package:shiok_jobs_flutter/Data/response/job_detailed_response.dart';
import 'package:shiok_jobs_flutter/Repository/job_respository.dart';
import 'package:shiok_jobs_flutter/Data/response/job_listing_response.dart';

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

  getJobById(int id) async {
    try {
      _jobDetailController.sink.add(ApiResponse.loading('Fetching Job'));
      JobDetail job = await _jobRepository.getJobById(id);
      _jobDetailController.sink.add(ApiResponse.completed(job));
    } catch (e) {
      _jobDetailController.sink.add(ApiResponse.error(e.toString()));
    }
  }

  dispose() {
    _jobListController.close();
    _jobDetailController.close();
  }
}
