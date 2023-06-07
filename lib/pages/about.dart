import 'package:compareprivateplanesapp/utils/extentions.dart';
import 'package:animated_button_bar/animated_button_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import '../utils/UrlsOfWebsite.dart';
import '../main.dart';
import 'dart:async';



class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  String webUrlPage = "https://compareprivateplanes.com/about";
  late WebViewController _controller;
  late Timer _timer;
  var currentIndex = 0;
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
  Widget build(BuildContext context) {
    List<Widget> pages = <Widget>[const AboutPage(), const ContactPage()];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).padding.top),
        child: SizedBox(
          height: MediaQuery.of(context).padding.top,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 10,
              child: Align(
                alignment: Alignment.topCenter,
                child: AnimatedButtonBar(
                  radius: 30.0,
                  padding: const EdgeInsets.all(0.0),
                  backgroundColor: Colors.blueGrey.shade800,
                  foregroundColor: Colors.blueGrey.shade300,
                  elevation: 24,
                  borderColor: Colors.white,
                  borderWidth: 2,
                  innerVerticalPadding: 16,
                  children: [
                    ButtonBarEntry(
                        onTap: () {
                          webUrlPage = "https://compareprivateplanes.com/about";

                          setState(() {
                            currentIndex = 0;
                          });
                        },
                        child: const Text(
                          "About",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                    ButtonBarEntry(
                        onTap: () {
                          webUrlPage = "https://compareprivateplanes.com/contact";
                          setState(() {
                            currentIndex = 1;
                          });
                        },
                        child: const Text(
                          "Contact",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                  ],
                ),
              ),
            ),
            Expanded(flex: 88, child: pages[currentIndex]),
          ],
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
        onTap: _onItemTapped,
        backgroundColor: const Color.fromRGBO(30, 31, 77, 1),
        unselectedLabelStyle: const TextStyle(color: Colors.white, fontSize: 14),
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.white,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
      ),
    );
  }
}

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
   WebViewController? _webViewController;
  bool isLoading = true;

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
            UrlsOfWebsite.ABOUT_PAGE_URL,
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
      ),
    );
  }
}

class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  WebViewController? _webViewController;
  bool isLoading = true;

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
            UrlsOfWebsite.CONTACT_PAGE_URL,
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
      ),
    );
  }
}
