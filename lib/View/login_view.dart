import 'package:flutter/material.dart';
import 'package:shiok_jobs_flutter/View/home_view.dart';
import 'package:shiok_jobs_flutter/View/register_view.dart';
import 'package:shiok_jobs_flutter/Bloc/login_bloc.dart';
import 'package:shiok_jobs_flutter/Data/response/api_response.dart';

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
  final _loginBloc = LoginBloc();

  @override
  void dispose() {
    userController.dispose();
    passwordController.dispose();
    _loginBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    userController.addListener(() {
      _loginBloc.changeUser(userController.text);
    });

    passwordController.addListener(() {
      _loginBloc.changePassword(passwordController.text);
    });

    var loginStreamBuilder = StreamBuilder(
        stream: _loginBloc.login,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            switch (snapshot.data?.status) {
              case Status.loading:
                return const Center(child: CircularProgressIndicator());
              case Status.completed:
                routeToHomePage();
              case Status.error:
                showSnackBar(
                    message:
                        snapshot.data?.message.toString() ?? 'error occurred');
              case null:
              // TODO: Handle this case.
            }
          }
          return const SizedBox();
        });

    var loginValidationStreamBuilder = StreamBuilder(
      stream: _loginBloc.submitValid,
      builder: (context, snapshot) {
        return ElevatedButton(
          onPressed: () {
            if (snapshot.hasData && snapshot.data == true) {
              postLoginAPI();
            } else {
              showSnackBar(message: 'Please enter valid username and password');
            }
          },
          child: const Text('Login'),
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            loginStreamBuilder,
            userTextField(),
            const SizedBox(height: 16),
            passwordTextField(),
            const SizedBox(height: 16),
            loginValidationStreamBuilder,
            ElevatedButton(
              onPressed: routeToRegisterPage,
              child: const Text('Register'),
            )
          ],
        ),
      ),
    );
  }

  TextField passwordTextField() {
    return TextField(
      controller: passwordController,
      decoration: const InputDecoration(
        labelText: 'Password',
      ),
      obscureText: true,
    );
  }

  TextField userTextField() {
    return TextField(
        controller: userController,
        decoration: const InputDecoration(
          labelText: 'Email',
        ));
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

  void postLoginAPI() {
    _loginBloc.loginAuthenticate(
      email: userController.text,
      password: passwordController.text,
    );
  }

  routeToHomePage() {
    return WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });
  }

  routeToRegisterPage() {
    return WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RegisterPage()),
      );
    });
  }
}
