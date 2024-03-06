import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:shiok_jobs_flutter/Model/ConfirmSignUp/confirm_sign_up_request.dart';
import 'package:shiok_jobs_flutter/Model/ConfirmSignUp/confirm_sign_up_response.dart';
import 'package:shiok_jobs_flutter/NetworkClient/network_client.dart';

class EmailVerificationPage extends StatelessWidget {
  const EmailVerificationPage({required this.userName, super.key});

  final String userName;

  @override
  Widget build(BuildContext context) {
    var pinEntered = '';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Verification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
                'Please verify your email with OTP to your registered email address'),
            const SizedBox(height: 50),
            OTPTextField(
              length: 6,
              width: MediaQuery.of(context).size.width,
              fieldWidth: MediaQuery.of(context).size.width / 6,
              style: const TextStyle(fontSize: 17),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.box,
              onCompleted: (pin) {
                debugPrint("Completed: $pin");
                pinEntered = pin;
              },
              onChanged: (pin) {
                debugPrint("editing: $pin");
              },
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                // Send email verification
                debugPrint('OTP: $pinEntered');
                sendEmailVerification(user: userName, pin: pinEntered);
              },
              child: const Text('Verify Email'),
            ),
          ],
        ),
      ),
    );
  }

  Future<ConfirmSignUpModel?> sendEmailVerification(
      {required String user, required String pin}) async {
    // Send email verification
    final client = NetworkClient();
    final request = ConfirmSignUpRequest(username: user, code: pin);
    try {
      client.setHeaders({'Content-Type': 'application/json'});
      String apiUrl = dotenv.env['API_URL']!;
      final response = await client.post(
        '$apiUrl/auth/ConfirmSignup',
        body: request.toJson(),
      );

      return ConfirmSignUpModel.fromJson(response);
    } catch (e) {
      debugPrint('Error: $e');
      return null;
    }
  }
}
