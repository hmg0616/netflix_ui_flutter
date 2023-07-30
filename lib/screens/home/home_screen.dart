import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:netflix_ui_flutter/screens/components/play_button.dart';
import 'package:netflix_ui_flutter/screens/home/components/rank_poster.dart';

import '../components/label_icon.dart';
import 'components/poster.dart';

class HomeScreen extends StatefulWidget {

  static String routeName = "/home_screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<String> posters = [
    "assets/images/big_buck_bunny_poster.jpg",
    "assets/images/les_miserables_poster.jpg",
    "assets/images/minari_poster.jpg",
    "assets/images/the_book_of_fish_poster.jpg",
  ];

  ScrollController _backController = new ScrollController();
  ScrollController _frontController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    Size appSize = MediaQuery.of(context).size;

    return Stack(
      children: [
        SingleChildScrollView( // 화면 뒷단 스크롤뷰
          controller: _backController,
          child: Column(
            children: [
              Stack(
                children: [
                  Image(
                    image: AssetImage(posters[0]),
                    height: appSize.height * 0.6 + (SliverAppBar().toolbarHeight * 2),
                    width: double.infinity,
                    fit: BoxFit.fitWidth,
                  ),
                  Container(
                    height: appSize.height * 0.6 + (SliverAppBar().toolbarHeight * 2),
                    decoration: BoxDecoration(
                      gradient: LinearGradient( // 그라데이션 넣기
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.2),
                          Colors.black.withOpacity(0.0),
                          Colors.black,
                        ],
                        stops: [0.0, 0.5, 0.9]
                      )
                    ),
                  )
                ],
              ),
              SizedBox(height: appSize.height)
            ],
          ),
        ),
        SafeArea( // 화면 앞단 스크롤뷰
          child: NotificationListener(
            onNotification: (ScrollNotification notification) { // 스크롤 이벤트가 일어날 떄 마다 스크롤 위치를 읽어주는 위젯.
                                                                // 기본적으로 앞의 스크롤 뷰 위치를 읽어서 뒤에 위치한 스크롤 뷰를 같이 이동시킴.
                                                                // 추가로 if문을 이용해 만약 배경이 모두 올라가서 보이지 않게 되면, 즉 화면 전체만큼 올라갔다면 의미없이 이동하는것 방지
              if(_frontController.offset <= appSize.height) {
                _backController.jumpTo(_frontController.offset);
                return true;
              } else {
                return false;
              }
            },
            child: CustomScrollView(
              controller: _frontController,
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
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(bottom: 40.0, left: 10.0),
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      height: 200.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: "오늘 한국의 ",
                              children: [
                                TextSpan(
                                  text: "TOP 10",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(text: "콘텐츠")
                              ],
                              style: TextStyle(fontSize: 18.0)
                            )
                          ),
                          SizedBox(height: 10.0),
                          Expanded(
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: List.generate(
                                posters.length,
                                (index) => RankPoster(
                                  rank: (index + 1).toString(),
                                  posterUrl: posters[index]
                                )
                              ),
                            )
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(bottom: 40.0, left: 10.0),
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      height: 200.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "TV ",
                                  style: TextStyle(fontWeight: FontWeight.bold)
                                ),
                                TextSpan(text: "프로그램·로맨스")
                              ],
                              style: TextStyle(fontSize: 18.0)
                            )
                          ),
                          SizedBox(height: 10.0),
                          Expanded(
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: List.generate(
                                posters.length,
                                (index) => Poster(posterUrl: posters[index]),
                              ),
                            )
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
