import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shiok_jobs_flutter/Data/response/api_response.dart';
import 'package:shiok_jobs_flutter/Data/response/job_listing_response.dart';
import 'package:shiok_jobs_flutter/View/job_detail_view.dart';
import 'package:shiok_jobs_flutter/Bloc/job_listing_bloc.dart';
import 'package:rxdart/rxdart.dart';

class JobList extends StatefulWidget {
  const JobList({super.key});
  @override
  State<StatefulWidget> createState() => _JobListState();
}

class _JobListState extends State<JobList> {
  List<JobSummary> jobList = [];
  final _jobSummaryBloc = JobListingBloc();
  final _textSubject = BehaviorSubject<String>();
  StreamSubscription<String>? _subscription;

  @override
  void initState() {
    super.initState();
    _jobSummaryBloc.getAllJobList();
    _subscription = _textSubject
        .debounceTime(const Duration(milliseconds: 500))
        .listen((String value) {
      _jobSummaryBloc.getJobListByKeyword(value);
    });
  }

  @override
  void dispose() {
    _jobSummaryBloc.dispose();
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JobSummary List'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(child: searchTextField()),
          ),
          // Expanded(
          //   child: jobList.isEmpty
          //       ? const Center(
          //           child: CircularProgressIndicator(),
          //         )
          //       : listViewBuilder(),
          // ),
          StreamBuilder(
              stream: _jobSummaryBloc.jobListStream,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  switch (snapshot.data?.status) {
                    case Status.loading:
                      const Center(
                        child: CircularProgressIndicator(),
                      );
                    case Status.completed:
                      if (snapshot.data?.data != null) {
                        jobList = snapshot.data?.data as List<JobSummary>;
                      }
                      return listViewBuilder();
                    case Status.error:
                      showSnackBar(
                          message: snapshot.data?.message ?? 'Error Occurred');
                    case null:
                  }
                }
                return Container();
              }),
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
        _textSubject.add(value);
      },
    );
  }

  ListView listViewBuilder() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: jobList.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
            title: Text('${jobList[index].jobTitle} - ${jobList[index].level}'),
            subtitle: Text('Company: ${jobList[index].company}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => JobDetailView(jobId: index + 1),
                ),
              );
            });
      },
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
