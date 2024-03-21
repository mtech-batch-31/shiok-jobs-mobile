import 'package:flutter/material.dart';
import 'package:shiok_jobs_flutter/Data/response/job_listing_response.dart';

class JobDetail extends StatelessWidget {
  const JobDetail({required this.job, super.key});

  final JobSummary job;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Detail'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(job.company ?? ''),
            Text(job.jobTitle ?? ''),
            Text(job.level ?? ''),
            Text(job.postedAt.toString() ?? ''),
            Text(job.employmentType ?? ''),
            Text(job.location ?? ''),
            Text(job.skills.toString()),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  debugPrint('Apply for job');
                },
                child: const Text('Apply'))
          ],
        ),
      ),
    );
  }
}
