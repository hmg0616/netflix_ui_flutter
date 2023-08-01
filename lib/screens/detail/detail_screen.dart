import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:netflix_ui_flutter/constants.dart';
import 'package:video_player/video_player.dart';

import '../../models/episode.dart';
import '../components/label_icon.dart';
import '../components/play_button.dart';
import '../components/small_sub_text.dart';
import 'components/episode_card.dart';

class DetailScreen extends StatefulWidget {

  static String routeName = "/detail";

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  List<String> posters =  [
    "assets/images/big_buck_bunny_poster.jpg",
    "assets/images/les_miserables_poster.jpg",
    "assets/images/minari_poster.jpg",
    "assets/images/the_book_of_fish_poster.jpg",
  ];

  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController; // 영상 재생 위젯

  Future<void> initializePlayer() async { // 비동기로 데이터를 불러오기위해 Future, async, await 사용
    _videoPlayerController = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'
    );
    await Future.wait([_videoPlayerController.initialize()]); // 비디오 다운로드가 완료될 때까지 대기
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
    );

    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
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
      body: Column(
        children: [
          Container(
            height: 230.0,
            child: _chewieController != null && _chewieController!.videoPlayerController.value.isInitialized
                ? Chewie(controller: _chewieController!)
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(),
                      SizedBox(height: 20),
                      Text('Loading')
                    ],
                  ),
          ),
          Expanded(
            child: DefaultTabController( // 탭바를 쓰기 위해 필요. 탭바 갯수 length로 지정
              length: 2,
              child: NestedScrollView(  // 스크롤이 가능한 뷰 안에 다시 스크롤이 가능한 뷰를 넣고 싶을 때, 즉 중첩된 스크롤 뷰를 구성하고 싶을 때 사용. (두개의 스크롤이 하나의 스크롤인 것처럼 동작)
                                        // NestedScrollView는 크게 headerSliverBuilder와 body 두개의 스크롤 가능한 부분으로 구분됨.
                                        // 탭바를 기준으로 탭바까지는 headerSliverBuilder, 탭바 상세화면이 들어있는 TabBarView는 body에 넣음.
                headerSliverBuilder: (context, value) {
                  return [
                    SliverToBoxAdapter(
                      child: _buildDetailContents(context),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.only(top: 20.0),
                      sliver: SliverToBoxAdapter( // 스크롤 시 탭바 pin(고정) 하려면 SliverPersistentHeader 사용
                        child: Container(
                          height: 50.0,
                          decoration: BoxDecoration(
                            border: Border(top: BorderSide(color: kLightColor))
                          ),
                          child: TabBar( // 탭바는 기본적으로 하단에 현재 보여지는 메뉴를 알려주는 선 존재. indicator 옵션을 통해 이 선을 커스텀 가능
                            indicator: UnderlineTabIndicator(
                              borderSide: BorderSide(color: Colors.red, width: 5.0),
                              insets: EdgeInsets.only(bottom: 45.0)
                            ),
                            isScrollable: true,
                            tabs: [
                              Tab(text: "회차 정보"),
                              Tab(text: "비슷한 콘텐츠"),
                            ]
                          ),
                        ),
                      ),
                    )
                  ];
                },
                body: Container(
                  child: TabBarView( // DefaultTabController에서 설정한 length와 동일한 갯수여야함.
                    children: [
                      _buildTabBarView1(),
                      _buildTabBarView2(context)
                    ],
                  ),
                ),
              ),
            )
          )
        ],
      ),
    );
  }

  Padding _buildDetailContents(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "빅 벅 버니",
            style: TextStyle(fontSize: 24.0),
          ),
          SizedBox(height: 10.0),
          Row(
            children: [
              Text(
                '95% 일치',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.green,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(width: 10.0),
              SmallSubText(text: "2008"),
              SizedBox(width: 10.0),
              Container(
                decoration: BoxDecoration(color: kLightColor),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                  child: Text(
                    "15+",
                    style: TextStyle(fontSize: 12.0, color: Colors.white60),
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              SmallSubText(text: "시즌 1개")
            ],
          ),
          SizedBox(height: 6.0),
          Text(
            "오늘 한국에서 콘텐츠 순위 1위",
            style: TextStyle(fontSize: 16.0),
          ),
          SizedBox(height: 10.0),
          PlayButton(width: double.infinity),
          SizedBox(height: 10.0),
          Container(
            width: double.infinity,
            height: 35.0,
            decoration: BoxDecoration(
              color: kButtonDarkColor,
              borderRadius: BorderRadius.circular(4.0)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(FontAwesomeIcons.download, size: 16.0),
                SizedBox(width: 10.0),
                Text("저장")
              ],
            ),
          ),
          SizedBox(height: 10.0),
          Text(episodes[0].description),
          SizedBox(height: 6.0),
          RichText(
            text: TextSpan(
              text: "출연: ",
              style: TextStyle(fontSize: 12.0, color: Colors.grey[300]),
              children: [
                TextSpan(
                  text: "버니, 프랭크, 링키, 기메라... ",
                  style: TextStyle(color: Colors.grey)
                ),
                TextSpan(text: "더보기")
              ]
            )
          ),
          SizedBox(height: 20.0),
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LabelIcon(
                  icon: FontAwesomeIcons.plus,
                  label: "내가 찜한 콘텐츠",
                ),
                LabelIcon(
                  icon: FontAwesomeIcons.thumbsUp,
                  label: "평가",
                ),
                LabelIcon(
                  icon: FontAwesomeIcons.shareAlt,
                  label: "공유",
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Padding _buildTabBarView1() {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 25.0),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text("시즌 1", style: TextStyle(fontSize: 18.0)),
          ),
          SizedBox(height: 20.0),
          Column(
            children: List.generate(
              episodes.length,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: EpisodeCard(
                  episode: episodes[index],
                )
              )),
          )
        ],
      ),
    );
  }

  Padding _buildTabBarView2(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView(
        children: [
          Wrap(
            runSpacing: 8.0,
            alignment: WrapAlignment.spaceBetween,
            children: List.generate(
                episodes.length,
                    (index) => Image(
                  image: AssetImage(posters[index]),
                  width: MediaQuery.of(context).size.width * 0.3,
                )),
          )
        ],
      ),
    );
  }
}
