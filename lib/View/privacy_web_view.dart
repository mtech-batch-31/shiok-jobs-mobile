import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyWebView extends StatelessWidget {
  const PrivacyWebView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = WebViewController();
    controller.loadRequest(
        Uri.parse('https://d2loqognvf0v5n.cloudfront.net/privacy-policy'));

    return Scaffold(
        appBar: AppBar(
          title: const Text('Privacy Policy'),
        ),
        body: WebViewWidget(
          controller: controller,
        ));
  }
}
