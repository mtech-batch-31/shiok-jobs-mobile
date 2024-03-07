import 'package:flutter/material.dart';
import 'package:shiok_jobs_flutter/Bloc/sign_up_bloc.dart';
import 'package:shiok_jobs_flutter/View/email_verification_view.dart';
import 'package:shiok_jobs_flutter/Data/response/api_response.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  var errorMessage = '';

  SignUpBloc _signUpBloc = SignUpBloc();

  @override
  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    emailController.dispose();
    _signUpBloc.dispose();
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
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextField(
            controller: userNameController,
            decoration: const InputDecoration(
              labelText: 'Username',
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
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
          StreamBuilder(
              stream: _signUpBloc.signUpStream,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  switch (snapshot.data?.status) {
                    case Status.LOADING:
                      return const Center(child: CircularProgressIndicator());
                    case Status.COMPLETED:
                      routeToEmailVerificationView();
                    case Status.ERROR:
                      showSnackBar(
                          message: snapshot.data?.message ?? 'Error Occurred');
                    case null:
                    // TODO: Handle this case.
                  }
                }
                return const SizedBox.shrink();
              }),
        ])));
  }

  void textFieldValidation() {
    if (userNameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      _signUpBloc.signUp(
          user: userNameController.text,
          password: passwordController.text,
          email: emailController.text);
    }
  }

  routeToEmailVerificationView() {
    return WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EmailVerificationView(
                  userName: userNameController.text,
                )),
      );
    });
  }

  showSnackBar({required String message}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    });
  }
}
