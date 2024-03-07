import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shiok_jobs_flutter/Data/response/job_response.dart';
import 'package:shiok_jobs_flutter/View/job_detail.dart';

class JobList extends StatefulWidget {
  const JobList({super.key});
  @override
  State<StatefulWidget> createState() => _JobListState();
}

class _JobListState extends State<JobList> {
  List<Job> jobList = [];
  List<Job> filteredJobList = [];

  Future<void> getJobs() async {
    final String response =
        await rootBundle.loadString('assets/json/jobs.json');

    final List<dynamic> data = json.decode(response);
    final List<Job> jobs =
        data.map((dynamic item) => Job.fromJson(item)).toList();
    setState(() {
      debugPrint(jobs.toString());
      jobList = jobs;
      filteredJobList = jobList;
    });
  }

  @override
  void initState() {
    super.initState();
    getJobs();
    filteredJobList = jobList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Job List'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(child: searchTextField()),
          ),
          Expanded(
            child: filteredJobList.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : listViewBuilder(),
          ),
        ],
      ),
    );
  }

  TextField searchTextField() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Search',
        hintText: 'Search',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onChanged: (String value) {
        setState(() {
          filteredJobList = jobList
              .where((Job job) =>
                  job.jobTitle.toLowerCase().contains(value.toLowerCase()))
              .toList();
          debugPrint(filteredJobList.length.toString());
          debugPrint(value.toString());
        });
      },
    );
  }

  ListView listViewBuilder() {
    return ListView.builder(
      itemCount: filteredJobList.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
            title: Text(
                '${filteredJobList[index].jobTitle} - ${filteredJobList[index].level}'),
            subtitle: Text('Company: ${filteredJobList[index].company}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => JobDetail(job: filteredJobList[index]),
                ),
              );
            });
      },
    );
  }
}
