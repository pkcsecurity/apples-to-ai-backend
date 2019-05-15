import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import 'package:app/view/widgets/button.dart';
import 'package:app/view/widgets/color.dart';
import 'package:app/view/widgets/misc.dart';
import 'package:app/bloc/stateBloc.dart';
import 'package:app/provider/stateProvider.dart';

class HomePage extends StatelessWidget {
  StateBloc bloc;

  @override
  Widget build(BuildContext context) {
    bloc = StateProvider.of(context);

    return bgCirclesBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        drawer: Drawer(
          child: _drawerContent(context),
        ),
        body: Stack(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _titleWidget(context),
                _subTitleWidget(context),
                _cameraIcon(context),
                _uploadButton(context),
              ],
            ),
          ]
        )
      ),
      color: DarkBackground
    );
  }

  Widget _drawerContent(BuildContext context) {
    return drawerBackground(
      child: ListView(
        children: <Widget>[
          drawerButton("home"),
          drawerButton(
              "new game",
              action: () {
                Navigator.of(context).maybePop().then((bool b) {
                  if (b) {
                    Navigator.of(context).pushNamed('/newgame');
                  }
                }
                );
              }
          ),
        ]
      ),
      color: RedBackground
    );
  }

  Widget _titleWidget(BuildContext context) {
    final mediaData = MediaQuery.of(context);
    final height = mediaData.size.height;
    final top = height * .213;

    return Container(
        padding: EdgeInsets.only(top: top),
        child: Text(
            "Take Your Best Shot!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 36.0,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            )
        )
    );
  }

  Widget _subTitleWidget(BuildContext context) {
    final mediaData = MediaQuery.of(context);
    final height = mediaData.size.height;
    final top = height * .017;

    final text = "Let's see if you can outsmart our AI, Rico.".toUpperCase();
    return Container(
        padding: EdgeInsets.only(top: top),
        child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 12.0,
                letterSpacing: 1.6,
                fontWeight: FontWeight.w500,
                color: Colors.white
            )
        )
    );
  }

  Widget _cameraIcon(BuildContext context) {
    final mediaData = MediaQuery.of(context);
    final height = mediaData.size.height;
    final width = mediaData.size.width;

    return Container(
      padding: EdgeInsets.only(top: height *.081),
      child: SvgPicture.asset(
        'assets/images/icons/icon-camera.svg',
        width: width * .4,
        height: height * .141,
        color: Colors.white.withOpacity(.45),
      ),
    );
  }

  Widget _uploadButton(BuildContext context) {
    return raisedIconButton(
      context,
      "UPLOAD A PHOTO",
      _buttonIcon(context),
      action: () async {
        print('Getting an image...');
        final image = await ImagePicker.pickImage(source: ImageSource.gallery)
          .then((File file) {
            if (file != null) {
              bloc.gameStateBloc.statusSink.add("Uploading image...");
              print('Got an image! Uploading...');
              Navigator.of(context).pushNamed('/results');
              bloc.gameStateBloc.addImage(file);
            }
          }
        );
      }
    );
  }

  Widget _buttonIcon(BuildContext context) {
    final mediaData = MediaQuery.of(context);
    final height = mediaData.size.height;
    final width = mediaData.size.width;

    return SvgPicture.asset(
      'assets/images/icons/icon-upload.svg',
      color: Colors.white,
      width: 24.0,
      height: 24.0,
    );
  }
}
