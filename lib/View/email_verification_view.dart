import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:shiok_jobs_flutter/Bloc/confirm_sign_up_bloc.dart';
import 'package:shiok_jobs_flutter/Data/response/api_response.dart';
import 'package:shiok_jobs_flutter/Data/response/confirm_sign_up_response.dart';
import 'package:shiok_jobs_flutter/View/home_view.dart';

class EmailVerificationView extends StatefulWidget {
  const EmailVerificationView({required this.email, super.key});

  final String email;

  @override
  State<StatefulWidget> createState() => _EmailVerificationViewState();
}

class _EmailVerificationViewState extends State<EmailVerificationView> {
  late ConfirmSignUpBloc confirmSignUpBloc;
  late String pinEntered = '';

  @override
  void initState() {
    confirmSignUpBloc = ConfirmSignUpBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Verification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text('Enter the OTP sent to ${widget.email}'),
            ),
            const SizedBox(height: 50),
            OTPTextField(
              length: 6,
              width: MediaQuery.of(context).size.width,
              fieldWidth: MediaQuery.of(context).size.width / 6,
              style: const TextStyle(fontSize: 17),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.box,
              onCompleted: (pin) {
                setState(() {
                  pinEntered = pin; // Update pinEntered when OTP is completed
                });
              },
              onChanged: (pin) {},
            ),
            StreamBuilder<ApiResponse<ConfirmSignUpResponse>>(
              stream: confirmSignUpBloc.signUpStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  switch (snapshot.data?.status) {
                    case Status.loading:
                      const Center(child: CircularProgressIndicator());
                    case Status.completed:
                      routeToHomePage();
                    case Status.error:
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        showSnackBar(
                            message:
                                snapshot.data?.message ?? 'Error occurred');
                      });
                    case null:
                    // TODO: Handle this case.
                  }
                }
                return const SizedBox();
              },
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                // Send email verification
                sendEmailVerification(email: widget.email, pin: pinEntered);
              },
              child: const Text('Verify Email'),
            ),
          ],
        ),
      ),
    );
  }

  sendEmailVerification({required String email, required String pin}) async {
    await confirmSignUpBloc.sendEmailVerification(email: email, pin: pin);
  }

  showSnackBar({required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  routeToHomePage() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    });
  }

  @override
  void dispose() {
    confirmSignUpBloc.dispose();
    super.dispose();
  }
}
