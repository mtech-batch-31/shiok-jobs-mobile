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
    debugPrint('Applying Job for $_jobId');
    _jobApplyBloc.applyJob(_jobId);
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
                  Text('Applying Job for $_jobId');
                  if (snapshot.hasData && snapshot.data != null) {
                    switch (snapshot.data?.status) {
                      case Status.loading:
                        const Center(child: CircularProgressIndicator());
                      case Status.completed:
                        return Column(
                          children: [
                            Text(snapshot.data?.data?.message.toString() ?? ''),
                            if (snapshot.data?.data?.status == 'success')
                              Image.asset(
                                'assets/images/success.png',
                                width: 200,
                                height: 200,
                                fit: BoxFit.contain,
                              ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.popUntil(
                                    context, (route) => route.isFirst);
                              },
                              child: const Text('Home'),
                            )
                          ],
                        );
                      case Status.error:
                        showSnackBar(
                            message: snapshot.data?.message.toString() ?? '');
                      case null:
                        return const Text('No Data');
                      default:
                        return Container();
                    }
                  }
                  return Container();
                }),
          ],
        ),
      ),
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
