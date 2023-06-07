import 'dart:async';
import 'dart:developer';

import 'package:compareprivateplanesapp/utils/UrlsOfWebsite.dart';
import 'package:compareprivateplanesapp/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../main.dart';

class MainAircraft extends StatefulWidget {
  const MainAircraft({Key? key}) : super(key: key);

  @override
  State<MainAircraft> createState() => _MainAircraftState();
}

class _MainAircraftState extends State<MainAircraft> {
  // WebViewController? _webViewController;
  InAppWebViewController? webViewController;
  bool isLoading = true;
  final int _selectedIndex = 0;
  final List<ContentBlocker> contentBlockers = [];

  void _onItemTapped(int index) {
    setState(() {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(title: "", pageNum: index),
          ));
    });
  }

  @override
  void initState() {
    super.initState();
       contentBlockers.add(ContentBlocker(
       trigger: ContentBlockerTrigger(
         urlFilter: ".*",
       ),
       action: ContentBlockerAction(
           type: ContentBlockerActionType.CSS_DISPLAY_NONE,
           selector: ".root, .page-1, .page-last")));

//     if (mounted) {
//       _webViewController = WebViewController();
//       _webViewController!
//         ..setJavaScriptMode(JavaScriptMode.unrestricted)
//         ..setBackgroundColor(const Color(0x00000000))
//         ..setNavigationDelegate(
//           NavigationDelegate(
//             onProgress: (int progress) {
//               debugPrint('WebView is loading (progress : $progress%)');
//             },
//             onPageStarted: (String url) {
//               debugPrint('Page started loading: $url');
//             },
//             onPageFinished: (String url) {
//               debugPrint('Page finished loading: $url');
//             },
//             onWebResourceError: (WebResourceError error) {
//               debugPrint('''
// Page resource error:
//   code: ${error.errorCode}
//   description: ${error.description}
//   errorType: ${error.errorType}
//   isForMainFrame: ${error.isForMainFrame}
//           ''');
//             },
//             onNavigationRequest: (NavigationRequest request) {
//               return NavigationDecision.navigate;
//             },
//             onUrlChange: (UrlChange change) {},
//           ),
//         )
//         ..addJavaScriptChannel(
//           'Toaster',
//           onMessageReceived: (JavaScriptMessage message) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text(message.message)),
//             );
//           },
//         )
//         ..loadRequest(
//           Uri.parse(
//             UrlsOfWebsite.MAIN_AIRCRAFT_PAGE_URL,
//           ),
//         ).then((value) => setState(() => isLoading = false));
//     }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.of(context).pop();
        return Future.value(true);
      },
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            Navigator.of(context).pop();
            return Future.value(true);
          },
          backgroundColor: '#1E1F4D'.toColor(),
          child: const Icon(Icons.keyboard_backspace),
        ),
        body: SafeArea(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                // : WebViewWidget(
                //     controller: _webViewController!,
                //   ),
                : InAppWebView(
                    initialUrlRequest: URLRequest(
                        url: Uri.parse(
                      UrlsOfWebsite.MAIN_AIRCRAFT_PAGE_URL,
                    )),
                    initialOptions: InAppWebViewGroupOptions(
                        ios: IOSInAppWebViewOptions(),
                        crossPlatform: InAppWebViewOptions(
                            contentBlockers: contentBlockers)),
                    onWebViewCreated: (controller) {
                      webViewController = controller;
                    },
                    onProgressChanged: (InAppWebViewController controller, int progress){
                      log("progress $progress");
                      if(progress >= 100) {
                        setState(() => isLoading = false);
                      } else {setState(() => isLoading = false);}
                    },
                  )),
      ),
    );
  }
}
