import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shiok_jobs_flutter/Data/response/api_response.dart';
import 'package:shiok_jobs_flutter/Bloc/job_listing_bloc.dart';
import 'package:shiok_jobs_flutter/Data/response/job_detailed_response.dart';
import 'package:shiok_jobs_flutter/View/job_apply_view.dart';

class JobDetailView extends StatefulWidget {
  const JobDetailView({required this.jobId, super.key});
  final int jobId;

  @override
  State<StatefulWidget> createState() => _JobDetailViewState();
}

class _JobDetailViewState extends State<JobDetailView> {
  final _jobSummaryBloc = JobListingBloc();

  late int _jobId;

  @override
  initState() {
    _jobId = widget.jobId;
    _jobSummaryBloc.getJobById(_jobId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Detail'),
      ),
      body: Center(
        child: Column(
          children: [
            StreamBuilder(
                stream: _jobSummaryBloc.jobDetailStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    switch (snapshot.data?.status) {
                      case Status.loading:
                        return const Center(child: CircularProgressIndicator());
                      case Status.completed:
                        return Column(
                          children: [
                            showJobDetail(snapshot.data!.data as JobDetail),
                          ],
                        );
                      case Status.error:
                        return Text(snapshot.data?.message.toString() ?? '');
                      case null:
                    }
                  }
                  return const SizedBox();
                }),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  routeToHomePage();
                },
                child: const Text('Apply'))
          ],
        ),
      ),
    );
  }

  Widget showJobDetail(JobDetail job) {
    return Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(job.jobTitle.toString(),
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
            Text("Company: ${job.companyName.toString()}"),
            Text("Industry: ${job.jobCategory.toString()}"),
            Text("Experience: ${job.level.toString()}"),
            Text("Employment Type: ${job.employmentType.toString()}"),
            const Text("Skills:"),
            for (var skill in job.skills!)
              Text(skill, style: const TextStyle(color: Colors.blueGrey)),
            const Divider(thickness: 1, color: Colors.grey),
            Text(job.jobSummary ?? ''),
            const SizedBox(height: 50),
            Text(
                "Posted on ${DateFormat.yMMMMEEEEd().format(job.postedDate ?? DateTime.now())}",
                style: const TextStyle(color: Colors.blue)),
          ],
        ));
  }

  routeToHomePage() {
    return WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => JobApplyView(jobId: _jobId)),
      );
    });
  }

  @override
  void dispose() {
    _jobSummaryBloc.dispose();
    super.dispose();
  }
}
