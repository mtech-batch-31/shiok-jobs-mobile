import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shiok_jobs_flutter/Model/job_model.dart';
import 'package:shiok_jobs_flutter/View/job_detail.dart';

class JobList extends StatefulWidget {
  JobList({super.key});
  @override
  State<StatefulWidget> createState() => _JobListState();
}

class _JobListState extends State<JobList> {
  List<Job> jobList = [
    const Job(
      company: 'Google',
      jobTitle: 'Software Engineer',
      level: 'Senior',
      postedAt: '2022-01-01',
      employeeType: 'Full-time',
      location: 'Singapore',
      skills: ['Java', 'Python', 'Dart'],
    ),
    const Job(
      company: 'Facebook',
      jobTitle: 'Product Manager',
      level: 'Mid',
      postedAt: '2022-01-01',
      employeeType: 'Full-time',
      location: 'Singapore',
      skills: ['Product Management', 'Project Management'],
    ),
    const Job(
      company: 'Amazon',
      jobTitle: 'Data Scientist',
      level: 'Junior',
      postedAt: '2022-01-01',
      employeeType: 'Full-time',
      location: 'Singapore',
      skills: ['Python', 'R', 'SQL'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: jobList.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
            title: Text(jobList[index].company),
            subtitle:
                Text('${jobList[index].jobTitle} - ${jobList[index].level}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => JobDetail(job: jobList[index]),
                ),
              );
            });
      },
    );
  }

  Future<void> readJson() async {
    final String response =
        await DefaultAssetBundle.of(context).loadString('test/jobs-mock.json');

    final List<dynamic> data = json.decode(response);
    final List<Job> jobs =
        data.map((dynamic item) => Job.fromJson(item)).toList();
    setState(() {
      jobList = jobs;
    });
  }
}
