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
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  var errorMessage = '';

  final _signUpBloc = SignUpBloc();

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    _signUpBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var emailTextField = Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: TextField(
        controller: emailController,
        decoration: const InputDecoration(
          labelText: 'Email',
        ),
      ),
    );

    var passwordTextField = Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: TextField(
        controller: passwordController,
        decoration: const InputDecoration(
          labelText: 'Password',
        ),
        obscureText: true,
      ),
    );

    return Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
        ),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const SizedBox(height: 16),
          emailTextField,
          const SizedBox(height: 16),
          passwordTextField,
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
                    case Status.loading:
                      return const Center(child: CircularProgressIndicator());
                    case Status.completed:
                      routeToEmailVerificationView();
                    case Status.error:
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
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      _signUpBloc.signUp(
          password: passwordController.text, email: emailController.text);
    }
  }

  routeToEmailVerificationView() {
    return WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => EmailVerificationView(
                  email: emailController.text,
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
