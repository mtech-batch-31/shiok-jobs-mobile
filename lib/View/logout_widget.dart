import 'package:flutter/material.dart';
import 'package:shiok_jobs_flutter/Bloc/login_bloc.dart';

class LogoutIcon extends StatelessWidget {
  const LogoutIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final logoutBloc = LoginBloc();

    return IconButton(
        icon: const Icon(Icons.logout),
        onPressed: () {
          logoutBloc.logout();
          Navigator.popUntil(context, (route) => route.isFirst);
        });
  }
}
