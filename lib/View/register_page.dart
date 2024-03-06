import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:shiok_jobs_flutter/Model/signup.dart';
import 'package:shiok_jobs_flutter/View/email_verification_page.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

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
      ])),
    );
  }

  void textFieldValidation() {
    String usrName = userNameController.text;
    if (userNameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      debugPrint('Text Field Validation Success');
      postSignUpAPI(
              userName: userNameController.text,
              password: passwordController.text,
              email: emailController.text)
          .then((value) => {
                debugPrint(value.toString()),
                if (value?.httpStatusCode == 200)
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EmailVerificationPage(
                                userName: usrName,
                              )),
                    )
                  }
                else
                  {
                    debugPrint(value?.error ?? 'Error Occurred'),
                    errorMessage = value?.error ?? 'Error Occurred',
                    debugPrint('errorMessage $errorMessage'),
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(errorMessage),
                      ),
                    ),
                    debugPrint(value?.toString())
                  }
              });
    }
  }

  Future<CodeDeliveryResponse?> postSignUpAPI(
      {required userName, required password, required email}) async {
    String apiUrl = dotenv.env['API_URL']!;
    String signupApiEndPoint = '$apiUrl/auth/SignUp';
    debugPrint(signupApiEndPoint);
    final res = await http.post(
      Uri.parse(signupApiEndPoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: convert.jsonEncode(<String, String>{
        'username': userName,
        'password': password,
        'email': email,
      }),
    );

    debugPrint(res.body);
    debugPrint(res.statusCode.toString());
    final decodedJson = convert.jsonDecode(res.body);
    final response = CodeDeliveryResponse.fromJson(decodedJson);
    return response;
  }
}
