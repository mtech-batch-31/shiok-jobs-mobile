import 'package:flutter/material.dart';

class LogoutIcon extends StatelessWidget {
  const LogoutIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.logout),
        onPressed: () {
          Navigator.popUntil(context, (route) => route.isFirst);
        });
  }
}
