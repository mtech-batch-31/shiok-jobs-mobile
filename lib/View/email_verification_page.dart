import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:shiok_jobs_flutter/Bloc/sign_up_bloc.dart';
import 'package:shiok_jobs_flutter/Data/response/api_response.dart';
import 'package:shiok_jobs_flutter/Data/response/confirm_sign_up_response.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({required this.userName, super.key});

  final String userName;

  @override
  State<StatefulWidget> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  final _signUpBloc = SignUpBloc();

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
                sendEmailVerification(user: widget.userName, pin: pinEntered);
              },
              child: const Text('Verify Email'),
            ),
          ],
        ),
      ),
    );
  }

  sendEmailVerification({required String user, required String pin}) {
    _signUpBloc.sendEmailVerification(user: user, pin: pin);
    StreamBuilder<ApiResponse<ConfirmSignUpResponse>>(
      stream: _signUpBloc.signUpStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          switch (snapshot.data?.status) {
            case Status.LOADING:
              return const Center(child: CircularProgressIndicator());
            case Status.COMPLETED:
              debugPrint('Email Verification Completed');
              return const Center(
                child: Text('Email Verification Completed'),
              );
            case Status.ERROR:
              debugPrint('Error: ${snapshot.data?.message}');
              return Center(
                child: Text(snapshot.data?.message ?? 'Error Occurred'),
              );
            case null:
            // TODO: Handle this case.
          }
        }
        return const SizedBox();
      },
    );
  }
}
