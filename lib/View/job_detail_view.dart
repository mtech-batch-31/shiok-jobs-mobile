import 'package:flutter/material.dart';
import 'package:shiok_jobs_flutter/Data/response/api_response.dart';
import 'package:shiok_jobs_flutter/Bloc/job_listing_bloc.dart';
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
    debugPrint('Fetching Job Detail for $_jobId');
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
                            Text(snapshot.data?.data?.lastUpdatedTime
                                    .toString() ??
                                ''),
                            Text(snapshot.data?.data?.closingDate.toString() ??
                                ''),
                            Text(snapshot.data?.data?.location ?? ''),
                            Text(snapshot.data?.data?.companyName ?? ''),
                            Text(snapshot.data?.data?.postedDate.toString() ??
                                ''),
                            Text(snapshot.data?.data?.jobTitle ?? ''),
                            Text(snapshot.data?.data?.skills.toString() ?? ''),
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

  routeToHomePage() {
    return WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => JobApplyView(jobId: _jobId)),
      );
    });
  }
}
