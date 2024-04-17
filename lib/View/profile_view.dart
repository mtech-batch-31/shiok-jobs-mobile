import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shiok_jobs_flutter/Bloc/profile_bloc.dart';
import 'package:shiok_jobs_flutter/Data/response/api_response.dart';
import 'package:shiok_jobs_flutter/Data/response/user_profile_response.dart';
import 'package:shiok_jobs_flutter/View/logout_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _userProfileBloc = UserProfileBloc();

  @override
  void initState() {
    super.initState();
    _userProfileBloc.getUserProfileAsync();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: const [LogoutIcon()],
      ),
      body: Center(
        child: Column(
          children: [
            StreamBuilder(
                stream: _userProfileBloc.userProfileStream,
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    switch (snapshot.data?.status) {
                      case Status.loading:
                        return const Center(child: CircularProgressIndicator());
                      case Status.completed:
                        return Column(
                          children: [
                            showUserProfile(
                                snapshot.data!.data as UserProfileResponse),
                          ],
                        );
                      case Status.error:
                        return Text(snapshot.data?.message.toString() ?? '');
                      case null:
                    }
                  }
                  return const SizedBox();
                })
          ],
        ),
      ),
    );
  }

  Widget showUserProfile(UserProfileResponse userProfileResponse) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(userProfileResponse.fullName.toString(),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 10,
              ),
              Text(
                "${userProfileResponse.isSeekingJob! ? "" : "Not "}Open to Jobs",
                style: const TextStyle(color: Color.fromRGBO(116, 219, 251, 1)),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(userProfileResponse.jobTitle.toString()),
              const SizedBox(
                height: 10,
              ),
              Text(userProfileResponse.about.toString()),
              const SizedBox(
                height: 10,
              ),
              const Text("Work Experiences",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: userProfileResponse.workExperiences?.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          userProfileResponse.workExperiences?[index].jobTitle
                                  .toString() ??
                              "",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 28,
                              fontWeight: FontWeight.bold)),
                    ]);
              }),
        ),
        Expanded(
            child: ListView.builder(
                itemCount: userProfileResponse.educationHistories?.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            userProfileResponse
                                    .educationHistories?[index].school
                                    .toString() ??
                                "",
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                                fontWeight: FontWeight.bold)),
                      ]);
                }))
      ],
    );
  }
}
