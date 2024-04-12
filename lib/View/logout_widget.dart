import 'package:flutter/material.dart';

class logoutIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.logout),
        onPressed: () {
          Navigator.popUntil(context, (route) => route.isFirst);
        });
  }
}
