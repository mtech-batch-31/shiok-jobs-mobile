import 'package:flutter/material.dart';
import 'package:shiok_jobs_flutter/Data/response/api_response.dart';
import 'package:shiok_jobs_flutter/Bloc/job_listing_bloc.dart';
import 'package:shiok_jobs_flutter/View/logout_widget.dart';

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
        actions: const [LogoutIcon()],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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

  @override
  void dispose() {
    _jobApplyBloc.dispose();
    super.dispose();
  }

  void applyJob() async {
    _jobApplyBloc.applyJob(_jobId);
  }

  Widget completedView() {
    return Column(
      children: [
        Image.asset(
          'assets/images/success.png',
          width: 100,
          fit: BoxFit.cover,
        ),
        const SizedBox(
          height: 16,
        ),
        const Text('Job Applied Successfully'),
        const SizedBox(
          height: 50,
        ),
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
