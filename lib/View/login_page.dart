import 'package:flutter/material.dart';
import 'package:shiok_jobs_flutter/View/job_list.dart';
import 'package:shiok_jobs_flutter/View/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final userController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    userController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
                controller: userController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                )),
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
              child: const Text('Login'),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterPage()),
                  );
                },
                child: const Text('Register'))
          ],
        ),
      ),
    );
  }

  void textFieldValidation() {
    debugPrint('Text Field Validation');
    if (userController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      debugPrint('Text Field Validation Success');
      postLoginAPI();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const JobList()),
      );
    }
  }

  void postLoginAPI() {
    debugPrint('Login API');
  }
}
