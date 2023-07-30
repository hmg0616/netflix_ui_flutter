import 'package:flutter/material.dart';

class RankPoster extends StatelessWidget {

  final String rank;
  final String posterUrl;

  const RankPoster({super.key, required this.rank, required this.posterUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: 30.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Image(
              image: AssetImage(posterUrl),
              fit: BoxFit.cover,
              width: 120.0,
              height: 200.0,
            ),
          ),
        ),
        Positioned(
          left: -5.0,
          bottom: -30.0,
          child: Stack(
            children: [
              // 외곽선 있는 글자 넣기
              Text( // 외곽선만 있는 텍스트 위젯
                rank,
                style: TextStyle(
                  fontSize: 100.0,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 3
                    ..color = Colors.white
                ),
              ),
              Text( // 외곽선만 있는 텍스트 위젯 위에 텍스트 위젯 덧입히기
                rank,
                style: TextStyle(
                  fontSize: 100.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
                ),
              )
            ],
          ),
        ),
        Container(
          width: 150.0,
          decoration: BoxDecoration(
            gradient: LinearGradient( // 그라데이션 넣기 ( 랭크 2번 부터는 좌측에 그라데이션 효과가 있음)
              colors: [
                Colors.black,                 // 그라데이션 시작 컬러
                Colors.black.withOpacity(0.0) // 그라데이션 종료 컬러
              ],
              stops: [0.0, rank != "1" ? 0.2 : 0.0] // 그라데이션 시작위치와 종료 위치 설정. 0.0은 제일 좌측, 1.0은 가장 우측
            )
          ),
        )
      ],
    );
  }
}
