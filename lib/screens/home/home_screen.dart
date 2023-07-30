import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:netflix_ui_flutter/screens/components/play_button.dart';

import '../components/label_icon.dart';

class HomeScreen extends StatefulWidget {

  static String routeName = "/home_screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size appSize = MediaQuery.of(context).size;

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            leading: Center(
              child: Text(
                "M",
                style: TextStyle(
                  fontSize: 26.0,
                  color: Colors.red,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            actions: [
              Icon(FontAwesomeIcons.chromecast),
              SizedBox(width: 25.0),
              Icon(FontAwesomeIcons.search),
              SizedBox(width: 25.0),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: Image(
                    image: AssetImage("assets/images/dog.jpg"),
                  ),
                ),
              ),
              SizedBox(width: 15.0)
            ],
          ),
          SliverAppBar(
            textTheme: TextTheme(headline6: TextStyle(fontSize: 18.0)),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            pinned: true,
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("TV 프로그램"),
                Text("영화"),
                Text("내가 찜한 콘텐츠")
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: (appSize.height * 0.6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "오늘 한국에서 콘텐츠 순위 1위",
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      LabelIcon(
                        icon: FontAwesomeIcons.plus,
                        label: "내가 찜한 콘텐츠",
                      ),
                      PlayButton(width: 80.0),
                      LabelIcon(
                        icon: Icons.info_outline,
                        label: "정보"
                      )
                    ],
                  ),
                  SizedBox(height: 30.0)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
