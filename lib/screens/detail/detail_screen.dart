import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailScreen extends StatefulWidget {

  static String routeName = "/detail";

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
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
      body: Center(
        child: Text("DetailScreen"),
      ),
    );
  }
}
