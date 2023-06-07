// import 'package:compareprivateplanesapp/models/pop_up_blocker.dart';
import 'package:flutter/material.dart';

class ArticleDetails extends StatefulWidget {
  const ArticleDetails({super.key});





  @override
  State<ArticleDetails> createState() => _ArticleDetailsState();
}

class _ArticleDetailsState extends State<ArticleDetails> {


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
       /*Column(
        children: [
          SafeArea(
            minimum: EdgeInsets.only(top: 40.0),
            top: false,
            right: false,
            bottom: false,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 120,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(
                            "assets/images/header_default_image2.png"),
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Text(
                        widget.article.articleTitle,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),*/
    );
  }
}
