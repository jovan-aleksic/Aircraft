import 'package:compareprivateplanesapp/pages/FreeTools.dart';
import 'package:compareprivateplanesapp/pages/about.dart';
import 'package:compareprivateplanesapp/pages/aircraft.dart';
import 'package:compareprivateplanesapp/pages/articles.dart';
import 'package:compareprivateplanesapp/pages/premium.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

bool connectCheck = false;

class _HomeState extends State<Home> {
  bool notificationIsWork = false;
  bool wifiOnyIsWork = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 120,
            child: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("assets/images/header_default_image2.png"),
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/crooped_logo.png",
                      height: 120,
                      width: 120,
                    ))
              ],
            ),
          ),

          // Row 1
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Row(
              children: [
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("clicked")));
                  },
                  child: SizedBox(
                    width: 180,
                    height: 180,
                    child: GestureDetector(
 
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Premium(),
                          ),
                        );
                      },
                      child: Stack(
                        children: [
                          Image.asset("assets/images/home_page_premium_image.png"),
                          const Padding(
                            padding: EdgeInsets.only(top: 90.0, left: 15.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Premium", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: 180,
                  height: 180,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AirCraft(),
                          ));
                    },
                    child: Stack(
                      children: [
                        Image.asset("assets/images/home_page_search_aircraft_image.png"),
                        const Padding(
                          padding: EdgeInsets.only(top: 90.0, left: 15.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Search Aircraft", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),

          // Row 2

          Row(
            children: [
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FreeToolsPage(),
                      ));
                },
                child: SizedBox(
                  width: 180,
                  height: 180,
                  child: Stack(
                    children: [
                      Image.asset("assets/images/home_page_tools_image.png"),
                      const Padding(
                        padding: EdgeInsets.only(top: 90.0, left: 15.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Tools", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Articles(),
                      ));
                },
                child: SizedBox(
                  width: 180,
                  height: 180,
                  child: Stack(
                    children: [
                      Image.asset("assets/images/home_page_articles_image.png"),
                      const Padding(
                        padding: EdgeInsets.only(top: 90.0, left: 15.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Articles", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),

          //Row 3
          SizedBox(
            width: 365,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const About(),
                    ));
              },
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Image.asset("assets/images/home_page_about_contact_image.png"),
                  const Padding(
                    padding: EdgeInsets.only(left: 14.0, bottom: 14.0),
                    child: Text("About & Contact", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    /*Column(
        children: [
          */ /*Expanded(
            flex: 20,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/images/header_default_image2.png"),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 5),child: Align(alignment: Alignment.topCenter,child: Image.asset("assets/images/cpp_logo.png")))
                ],
              )
          ),
          Column()*/ /*

        ],
      );*/
  }
}

/*
* return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 120,
              child:  Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage("assets/images/header_default_image2.png"),
                      ),
                    ),
                  ),
                  Align(alignment: Alignment.center,child: Image.asset("assets/images/crooped_logo.png",height: 120,width: 120,))
                ],
              ),
            ),

          // Row 1
          Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: Row(
              children: [
                Spacer(),
                GestureDetector(
                  onTap: (){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("clicked")));
                  },
                  child: SizedBox(
                    width: 180,
                    height: 180,
                    child: GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Premium(),));
                      },
                      child: Stack(
                        children: [
                          Image.asset("assets/images/home_page_premium_image.png"),
                          Padding(
                            padding: const EdgeInsets.only(top: 90.0, left: 15.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Premium",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Spacer(),
                SizedBox(
                  width: 180,
                  height: 180,
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AirCraft(),));
                    },
                    child: Stack(
                      children: [
                        Image.asset(
                            "assets/images/home_page_search_aircraft_image.png"),
                        Padding(
                          padding: const EdgeInsets.only(top: 90.0, left: 15.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Search Aircraft",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),

          // Row 2

          Row(
            children: [
              Spacer(),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FreeToolsPage(),));
                },
                child: SizedBox(
                  width: 180,
                  height: 180,
                  child: Stack(
                    children: [
                      Image.asset("assets/images/home_page_tools_image.png"),
                      Padding(
                        padding: const EdgeInsets.only(top: 90.0, left: 15.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Tools",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Articles(),));
                },
                child: SizedBox(
                  width: 180,
                  height: 180,
                  child: Stack(
                    children: [
                      Image.asset("assets/images/home_page_articles_image.png"),
                      Padding(
                        padding: const EdgeInsets.only(top: 90.0, left: 15.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Articles",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
            ],
          ),

          //Row 3

          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: SizedBox(
              width: 400,
              height: 180,
              child: GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => About(),));
                },
                child: Row(
                  children: [
                    Expanded(
                      child: Stack(
                        children: [
                          Image.asset(
                              "assets/images/home_page_about_contact_image.png"),
                          Padding(
                            padding: const EdgeInsets.only(top: 90.0, left: 15.0,bottom: 15.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text("About & Contact",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
*
*
* */