import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:shiok_jobs_flutter/Bloc/confirm_sign_up_bloc.dart';
import 'package:shiok_jobs_flutter/Data/response/api_response.dart';
import 'package:shiok_jobs_flutter/Data/response/confirm_sign_up_response.dart';
import 'package:shiok_jobs_flutter/View/home_page.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({required this.userName, super.key});

  final String userName;

  @override
  State<StatefulWidget> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  late ConfirmSignUpBloc confirmSignUpBloc;

  @override
  void initState() {
    confirmSignUpBloc = ConfirmSignUpBloc();
    super.initState();
  }

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
            StreamBuilder<ApiResponse<ConfirmSignUpResponse>>(
              stream: confirmSignUpBloc.signUpStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  switch (snapshot.data?.status) {
                    case Status.LOADING:
                      const Center(child: CircularProgressIndicator());
                    case Status.COMPLETED:
                      routeToHomePage();
                    case Status.ERROR:
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

  sendEmailVerification({required String user, required String pin}) async {
    await confirmSignUpBloc.sendEmailVerification(user: user, pin: pin);
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
