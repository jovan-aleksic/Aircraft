import 'dart:async';

import 'package:compareprivateplanesapp/main.dart';
import 'package:compareprivateplanesapp/utils/extentions.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../utils/UrlsOfWebsite.dart';

class MainArticles extends StatefulWidget {
  const MainArticles({Key? key}) : super(key: key);

  @override
  State<MainArticles> createState() => _MainArticlesState();
}

class _MainArticlesState extends State<MainArticles> {
   WebViewController? _webViewController;
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
    if (mounted) {
      _webViewController = WebViewController();
      _webViewController!
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {
              debugPrint('WebView is loading (progress : $progress%)');
            },
            onPageStarted: (String url) {
              debugPrint('Page started loading: $url');
            },
            onPageFinished: (String url) {
              debugPrint('Page finished loading: $url');
            },
            onWebResourceError: (WebResourceError error) {
              debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
            },
            onNavigationRequest: (NavigationRequest request) {
              return NavigationDecision.navigate;
            },
            onUrlChange: (UrlChange change) {},
          ),
        )
        ..addJavaScriptChannel(
          'Toaster',
          onMessageReceived: (JavaScriptMessage message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message.message)),
            );
          },
        )
        ..loadRequest(
          Uri.parse(
            UrlsOfWebsite.MAIN_ARTICLES_PAGE_URL,
          ),
        ).then((value) => setState(() => isLoading = false));
    }
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
              : WebViewWidget(
                  controller: _webViewController!,
                ),
        ),),
    );
  }
}
