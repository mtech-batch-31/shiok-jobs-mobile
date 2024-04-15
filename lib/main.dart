import 'package:flutter/material.dart';
import 'package:shiok_jobs_flutter/View/login_view.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shiok_jobs_flutter/Data/amplifyconfiguration.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:shiok_jobs_flutter/View/home_view.dart';
import 'package:shiok_jobs_flutter/View/register_view.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'package:shiok_jobs_flutter/View/privacy_web_view.dart';

Future<void> main() async {
  await dotenv.load(fileName: 'env/dev.env');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

// With Flutter, you create user interfaces by combining "widgets"
// You'll learn all about them (and much more) throughout this course!
class _MyAppState extends State<MyApp> {
  bool _jailbroken = false;

  @override
  void initState() {
    super.initState();
    _configureAmplify();
    _checkJailbreak();
  }

  // Every custom widget must have a build() method
  // It tells Flutter, which widgets make up your custom widget
  // Again: You'll learn all about that throughout the course!
  @override
  Widget build(BuildContext context) {
    // Below, a bunch of built-in widgets are used (provided by Flutter)
    // They will be explained in the next sections
    // In this course, you will, of course, not just use them a lot but
    // also learn about many other widgets!
    var scaffoldDisplay = Scaffold(
      body: _jailbroken
          ? const Center(
              child: Text('Jailbroken device detected'),
            )
          : const LoginPage(),
      backgroundColor: Colors.indigo[50],
    );

    return MaterialApp(
        title: 'Job Search App',
        theme: ThemeData(useMaterial3: true),
        routes: {
          '/login': (context) => const LoginPage(),
          '/home': (context) => const HomePage(),
          '/register': (context) => const RegisterPage(),
          '/privacy': (context) => const PrivacyWebView(),
        },
        home: scaffoldDisplay);
  }

  Future<void> _configureAmplify() async {
    try {
      final auth = AmplifyAuthCognito();
      await Amplify.addPlugin(auth);

      // call Amplify.configure to use the initialized categories in your app
      await Amplify.configure(amplifyconfig);
    } on Exception catch (e) {
      safePrint('An error occurred configuring Amplify: $e');
    }
  }

  _checkJailbreak() async {
    bool jail = await FlutterJailbreakDetection.jailbroken;
    // bool developerMode = await FlutterJailbreakDetection.developerMode;
    setState(() {
      _jailbroken = jail;
    });
  }
}
