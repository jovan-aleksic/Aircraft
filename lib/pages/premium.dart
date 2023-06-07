import 'package:compareprivateplanesapp/utils/UrlsOfWebsite.dart';
import 'package:compareprivateplanesapp/utils/extentions.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import 'dart:async';

class Premium extends StatefulWidget {
  const Premium({Key? key}) : super(key: key);

  @override
  State<Premium> createState() => _PremiumState();
}

class _PremiumState extends State<Premium> {
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
            UrlsOfWebsite.PREMIUM_PAGE_URL_IN_HOME,
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
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Image.asset("icons/home_icon.png", width: 30, height: 30), label: "Home"),
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
          unselectedLabelStyle: const TextStyle(color: Colors.white, fontSize: 14),
          backgroundColor: const Color.fromRGBO(30, 31, 77, 1),
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.white,
          currentIndex: _selectedIndex,
          fixedColor: Colors.white,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

/*
* Column(
      children: [
        /*SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 100,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image:
                    AssetImage("assets/images/header_default_image2.png"),
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Premium Zone",
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                  ))
            ],
          ),
        ),*/
        Column(
          children: [
            Expanded(
              child: WebView(
                initialUrl: 'http://compareprivateplanes.com/sign-in',
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller = webViewController;
                },
              ),
            ),
          ],
        )

      ],
    );*/