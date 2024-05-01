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
  bool _isEditingEmail = false;

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
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
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
                        return showUserProfile(
                            snapshot.data!.data as UserProfileResponse);
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
    final TextEditingController emailController = TextEditingController(text: userProfileResponse.email);
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    String? emailError;

    return Container(
      padding: const EdgeInsets.all(20.0),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userProfileResponse.fullName.toString(),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 10,
              ),
              Form (
              key: formKey,
              child: Row(
                children: [
                  Expanded(
                    child: _isEditingEmail
                        ?
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        errorText: emailError,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        }
                        // print("email to validate " + value.toString());
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                          return 'Invalid email format';
                        }
                        // print("something else happened " + value.toString());
                        return null;
                      },
                    )
                        : Text(
                      userProfileResponse.email.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {

                        _isEditingEmail = !_isEditingEmail;
                        // _emailError = null; // Clear previous error message
                        if (!_isEditingEmail) {
                          // Save changes
                          final newEmail = emailController.text;
                          // Validate email input

                          if (formKey.currentState!.validate()) {
                            // Send POST request to update email

                            _userProfileBloc.updateUserEmail(newEmail,userProfileResponse);
                          }
                        }
                      });
                    },
                    icon: Icon( _isEditingEmail  ? Icons.done : Icons.edit),
                  ),
                ],
              )),
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
                height: 15,
              ),
              const Text("Work Experiences",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: userProfileResponse.workExperiences?.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          userProfileResponse.workExperiences?[index].company
                                  .toString() ??
                              "",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18)),
                      Text(userProfileResponse.workExperiences![index].jobTitle.toString()),
                      const SizedBox(
                        height: 5,
                      ),
                      Text("${userProfileResponse.workExperiences![index].yearStart} - ${userProfileResponse.workExperiences![index].yearStart}"),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(userProfileResponse.workExperiences![index].experience.toString()),
                      const SizedBox(
                        height: 20,
                      ),
                    ]);
              }),
          const SizedBox(
            height: 15,
          ),
          const Text("Education",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold)),
          ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: userProfileResponse.educationHistories?.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          userProfileResponse.educationHistories?[index].school
                              .toString() ??
                              "",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 18)),
                      const SizedBox(
                        height: 5,
                      ),
                      Text("${userProfileResponse.educationHistories![index].yearStart} - ${userProfileResponse.educationHistories![index].yearStart}"),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(userProfileResponse.educationHistories![index].description.toString()),
                      const SizedBox(
                        height: 20,
                      ),
                    ]);
              })
        ],
      ),
    );
  }
}
