import 'package:flutter/material.dart';
import 'package:shiok_jobs_flutter/View/logout_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [logoutIcon()],
      ),
      body: const Center(
        child: Text('Profile Page'),
      ),
    );
  }
}
