import 'dart:io';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:app/view/widgets/button.dart';
import 'package:app/view/widgets/color.dart';
import 'package:app/view/widgets/input.dart';
import 'package:app/view/widgets/misc.dart';

class InvitePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    final mediaData = MediaQuery.of(context);
    final height = mediaData.size.height;
    final width = mediaData.size.width;

    return circlesSplashBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: height * 0.35,
              color: DarkBackground.withOpacity(0.5),
              child: inviteHeader(context)
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              height: height * 0.65,
              child: playerList(context),
            )
          ],
        )
      ),
      color: LightBlue
    );
  }

  Widget inviteHeader(BuildContext context){
    final mediaData = MediaQuery.of(context);
    final height = mediaData.size.height;
    final width = mediaData.size.width;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: height * 0.1
        ),
        Text(
          "Invite friends to the game!",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: LightOliveGreen,
            fontSize: 22.0
          ),
        ),
        Container(
          margin: const EdgeInsets.all(20.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            border: Border.all(color: DarkOliveGreen)
          ),
          child: Text(
            generateWordPairs().take(2).toString(),
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 18.0
            )
          ),
        ),
        Container(
          width: width * 0.6,
          child: raisedButton(
            "Start Game",
            LightOliveGreen,
            Colors.white,
            action: () => print("Start the Game!")
          )
        )
      ],
    );
  }

  Widget playerList(BuildContext context) {
    final titles = ["Purple Nightingale", "Yellow Sea Otter", "Orange Hummingbird"];

    return ListView.builder(
      itemCount: titles.length,
      itemBuilder: (context, index) {
        return tileCard(
          text: titles[index],
          imgUrl: "https://picsum.photos/200"
        );
      },
    );
  }
}