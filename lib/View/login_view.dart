import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/material.dart';
import 'package:shiok_jobs_flutter/Bloc/token_bloc.dart';
import 'package:shiok_jobs_flutter/View/register_view.dart';
import 'package:shiok_jobs_flutter/Bloc/login_bloc.dart';
import 'package:shiok_jobs_flutter/Data/response/api_response.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

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
                TokenBloc().setSignInFlow(SignInFlow.email);
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
            IntrinsicWidth(
                child:
                    SizedBox(width: 250, child: loginValidationStreamBuilder)),
            IntrinsicWidth(
                child: SizedBox(
              width: 250,
              child: ElevatedButton(
                  onPressed: routeToRegisterPage,
                  child: const Text('Register')),
            )),
            IntrinsicWidth(
                child: SizedBox(
                    width: 250,
                    child: ElevatedButton(
                        onPressed: socialSignIn,
                        child: const Text('Sign in with Google'))))
          ],
        ),
      ),
    );
  }

  Widget passwordTextField() {
    return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: TextField(
          controller: passwordController,
          decoration: const InputDecoration(
            labelText: 'Password',
          ),
          obscureText: true,
        ));
  }

  Widget userTextField() {
    return Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: TextField(
            controller: userController,
            decoration: const InputDecoration(
              labelText: 'Email',
            )));
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
      Navigator.pushNamed(context, '/home');
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

  //Move this to _loginBloc
  Future<void> socialSignIn() async {
    try {
      final result = await Amplify.Auth.signInWithWebUI(
        options: const SignInWithWebUIOptions(
            pluginOptions: CognitoSignInWithWebUIPluginOptions(
          isPreferPrivateSession: false,
        )),
        provider: AuthProvider.google,
      );
      _handleSignInResult(result);
    } on AuthException catch (e) {
      showSnackBar(message: e.message);
    }
  }

  Future<void> _handleSignInResult(SignInResult result) async {
    switch (result.nextStep.signInStep) {
      case AuthSignInStep.continueSignInWithMfaSelection:
      // Handle select from MFA methods case
      case AuthSignInStep.continueSignInWithTotpSetup:
      // Handle TOTP setup case
      case AuthSignInStep.confirmSignInWithTotpMfaCode:
      // Handle TOTP MFA case
      case AuthSignInStep.confirmSignInWithSmsMfaCode:
      // Handle SMS MFA case
      case AuthSignInStep.confirmSignInWithNewPassword:
      // Handle new password case
      case AuthSignInStep.confirmSignInWithCustomChallenge:
      // Handle custom challenge case
      case AuthSignInStep.resetPassword:
      // Handle reset password case
      case AuthSignInStep.confirmSignUp:
      // Handle confirm sign up case
      case AuthSignInStep.done:
        TokenBloc().setSignInFlow(SignInFlow.google);
        Navigator.pushNamed(context, '/home');
    }
  }
}
