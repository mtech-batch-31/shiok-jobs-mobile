import 'package:flutter/material.dart';
import 'package:shiok_jobs_flutter/Data/response/api_response.dart';
import 'package:shiok_jobs_flutter/Bloc/job_listing_bloc.dart';

class JobApplyView extends StatefulWidget {
  const JobApplyView({required this.jobId, super.key});
  final int jobId;

  @override
  State<StatefulWidget> createState() => _JobApplyViewState();
}

class _JobApplyViewState extends State<JobApplyView> {
  final _jobApplyBloc = JobListingBloc();

  late int _jobId;

  @override
  initState() {
    _jobId = widget.jobId;
    applyJob();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Apply'),
      ),
      body: Center(
        child: Column(
          children: [
            StreamBuilder(
                stream: _jobApplyBloc.jobApplyStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    switch (snapshot.data?.status) {
                      case Status.loading:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      case Status.completed:
                        return completedView();
                      case Status.error:
                        return showSnackBar(
                            message: snapshot.data?.message.toString() ?? '');
                      case null:
                        return const Text('No Data');
                      default:
                        return Container();
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }

  void applyJob() async {
    _jobApplyBloc.applyJob(_jobId);
  }

  Widget completedView() {
    return Column(
      children: [
        const Text('Job Applied Successfully'),
        ElevatedButton(
          onPressed: () {
            Navigator.popUntil(context, ModalRoute.withName('/home'));
          },
          child: const Text('Home'),
        )
      ],
    );
  }

  showSnackBar({required String message}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
      ));
    });
  }
}
