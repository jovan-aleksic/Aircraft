// import 'package:compareprivateplanesapp/models/pop_up_blocker.dart';
import 'dart:async';
import 'dart:developer';

import 'package:compareprivateplanesapp/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../main.dart';
import '../utils/UrlsOfWebsite.dart';

class Articles extends StatefulWidget {
  const Articles({Key? key}) : super(key: key);

  @override
  State<Articles> createState() => _ArticlesState();
}

class _ArticlesState extends State<Articles> {
   // WebViewController? _webViewController;
  InAppWebViewController? webViewController;
  final List<ContentBlocker> contentBlockers = [];
  bool isLoading = true;
  final int _selectedIndex = 0;

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
//             UrlsOfWebsite.ARTICLES_PAGE_URL_IN_HOME,
//           ),
//         ).then((value) => setState(() => isLoading = false));
//     }
contentBlockers.add(ContentBlocker(
        trigger: ContentBlockerTrigger(
          urlFilter: ".*",
        ),
        action: ContentBlockerAction(
            type: ContentBlockerActionType.CSS_DISPLAY_NONE,
            selector: ".root, .page-1, .page-last")));

            contentBlockers.add(ContentBlocker(
        trigger: ContentBlockerTrigger(
          urlFilter: ".*",
        ),
        action: ContentBlockerAction(
            type: ContentBlockerActionType.CSS_DISPLAY_NONE,
            selector: ".mob-icon-menu, .mob-menu-icon")));

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
              child: Stack(children: [
            if (isLoading)
              const Center(
                child: CircularProgressIndicator(),
              ),
            Expanded(
              child: InAppWebView(
                initialUrlRequest: URLRequest(
                    url: Uri.parse(
                  UrlsOfWebsite.ARTICLES_PAGE_URL_IN_HOME,
                )),
                initialOptions: InAppWebViewGroupOptions(
                    ios: IOSInAppWebViewOptions(),
                    crossPlatform:
                        InAppWebViewOptions(contentBlockers: contentBlockers)),
                onWebViewCreated: (controller) {
                  webViewController = controller;
                },
                onProgressChanged: (controller, progress) =>
                    {log("cur progress : $progress")},
                onLoadStop: (InAppWebViewController controller, Uri? uri) {
                  setState(() {
                    isLoading = false;
                  });
                },
              ),
            )
          ])),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Image.asset("icons/home_icon.png", width: 30, height: 30),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Image.asset(
                  "icons/aircraft_icon.png",
                  width: 30,
                  height: 30,
                ),
                label: "Aircraft"),
            BottomNavigationBarItem(
                icon: Image.asset(
                  "icons/premium_icon.png",
                  width: 30,
                  height: 30,
                ),
                label: "Premium"),
            BottomNavigationBarItem(
                icon: Image.asset(
                  "icons/articles_icon.png",
                  width: 30,
                  height: 30,
                ),
                label: "Articles"),
            BottomNavigationBarItem(
                icon: Image.asset(
                  "icons/settting_icon.png",
                  width: 30,
                  height: 30,
                ),
                label: "Tools"),
          ],
          onTap: _onItemTapped,
          backgroundColor: const Color.fromRGBO(30, 31, 77, 1),
          unselectedLabelStyle:
              const TextStyle(color: Colors.white, fontSize: 14),
          type: BottomNavigationBarType.fixed,
          fixedColor: Colors.white,
          unselectedItemColor: Colors.white,
          currentIndex: _selectedIndex,
        ),
      ),
    );
  }
}
