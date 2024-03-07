import 'package:flutter/material.dart';
import 'package:shiok_jobs_flutter/Data/response/job_response.dart';

class JobDetail extends StatelessWidget {
  const JobDetail({required this.job, super.key});

  final Job job;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job Detail'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(job.company),
            Text(job.jobTitle),
            Text(job.level),
            Text(job.postedAt),
            Text(job.employeeType),
            Text(job.location),
            Text(job.skills.join(', ')),
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
