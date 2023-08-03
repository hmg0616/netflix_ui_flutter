import 'package:flutter/material.dart';

class RotateImage extends StatelessWidget {

  final String imageUrl;
  final int degree;

  const RotateImage({super.key, required this.imageUrl, this.degree = 0});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate( // Transform은 변환을 위한 위젯. 특정 위젯을 회전시키는 것은 물론, 확대, 축소 혹은 애니메이션 등 수많은 동작 입힐 수 있음.
      angle: degree * 3.14 / 180, // 원하는 각도 만큼 회전
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Image(
          image: AssetImage(imageUrl),
          height: 150.0,
        ),
      ),
    );
  }
}
