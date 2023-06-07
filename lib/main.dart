import 'package:compareprivateplanesapp/pages/main_aircraft.dart';
import 'package:compareprivateplanesapp/pages/main_articles.dart';
import 'package:compareprivateplanesapp/pages/main_premium.dart';
import 'package:compareprivateplanesapp/pages/main_tools.dart';
import 'package:compareprivateplanesapp/pages/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Compare Private Planes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'CPP App', pageNum: 0),
    );
  }
}

int _selectedIndex = 0;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.pageNum});
  final String title;
  final int pageNum;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> pages = <Widget>[
    const Home(),
    const MainAircraft(),
    const MainPremium(),
    const MainArticles(),
    const MainTools()
  ];

  @override
  void initState() {
    if (widget.pageNum == 12) {
      _selectedIndex = 0;
    }
    _selectedIndex = widget.pageNum;

    setState(() {});

    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).padding.top),
        child: SizedBox(
          height: MediaQuery.of(context).padding.top,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: pages[_selectedIndex],
        ),
      ),
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
    );
  }
}
