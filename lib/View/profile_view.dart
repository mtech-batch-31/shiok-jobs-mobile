import 'package:flutter/material.dart';
import 'package:shiok_jobs_flutter/View/logout_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [LogoutIcon()],
      ),
      body: const Center(
        child: Text('Profile Page'),
      ),
    );
  }
}
