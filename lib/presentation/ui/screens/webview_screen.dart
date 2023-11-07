import 'package:e_commerce/presentation/state_holders/cart_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:developer';
class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key, required this.paymentUrl});
//WebViw is work only android studio's emulator
  final String paymentUrl;

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    print("webview initState");
    log("webview initState");

    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            print("Enter into onPageFinished ");
            log("Enter into onPageFinished ");
            if (url.endsWith("tran_type=success")) {

              navigateBack();
            }
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            print(request);
            if (request.url.contains("tran_type=success")) {
              navigateBack();
            }
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(
          widget.paymentUrl));
  }

  @override
  Widget build(BuildContext context) {
    print("Enter web view Build");
    log("Enter web view Build");
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: WebViewWidget(

        controller: _webViewController,
      ),
    );
  }


  void navigateBack() {
    Navigator.pop(context);
    Get.snackbar(
      'Payment Successful',
      'your order has been confirmed',
      snackPosition: SnackPosition.BOTTOM,
    );
    Get.find<CartListController>()
        .getCartList();
  }
}
