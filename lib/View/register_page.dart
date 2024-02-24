import 'package:flutter/material.dart';
import 'package:shiok_jobs_flutter/View/job_list.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  final passwordTextField = const TextField(
    decoration: InputDecoration(
      labelText: 'Password',
    ),
    obscureText: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        TextField(
          controller: userNameController,
          decoration: const InputDecoration(
            labelText: 'Username',
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: passwordController,
          decoration: const InputDecoration(
            labelText: 'Password',
          ),
          obscureText: true,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
            onPressed: () {
              textFieldValidation();
            },
            child: const Text('Register')),
      ])),
    );
  }

  void textFieldValidation() {
    debugPrint('Text Field Validation');
    if (userNameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      debugPrint('Text Field Validation Success');
      postRegisterAPI();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const JobList()),
      );
    }
  }

  void postRegisterAPI() {
    debugPrint('Register API');
  }
}
