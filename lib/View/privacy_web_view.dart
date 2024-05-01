import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyWebView extends StatelessWidget {
  const PrivacyWebView({super.key});

  @override
  Widget build(BuildContext context) {
    const urlPath = 'https://d2loqognvf0v5n.cloudfront.net/privacy-policy';
    final controller = WebViewController();
    controller.loadRequest(Uri.parse(urlPath));
    controller.setNavigationDelegate(
        NavigationDelegate(onNavigationRequest: (request) {
      if (request.url.contains(urlPath)) {
        return Future.value(NavigationDecision.navigate);
      } else {
        return Future.value(NavigationDecision.prevent);
      }
    }));
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Privacy Policy'),
        ),
        body: WebViewWidget(
          controller: controller,
        ));
  }
}
