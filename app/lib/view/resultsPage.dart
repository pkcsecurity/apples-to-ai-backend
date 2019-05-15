import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:app/bloc/stateBloc.dart';
import 'package:app/model/ricoResultsModel.dart';
import 'package:app/provider/stateProvider.dart';
import 'package:app/view/widgets/button.dart';
import 'package:app/view/widgets/color.dart';
import 'package:app/view/widgets/misc.dart';

class ResultsPage extends StatelessWidget {
  StateBloc bloc;

  @override
  Widget build(BuildContext context) {
    bloc = StateProvider.of(context);

    return StreamBuilder<List<RicoResult>>(
      stream: bloc.gameStateBloc.resultsStream,
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List<RicoResult>> snapshot) {
        String item = '';
        int confidence = 0;
        String iconPath = toIconPath('');
        List<Widget> children = [bgCirclesBackground(color: LightOliveGreen)];

        if (snapshot.data != null && snapshot.data.length > 0) {
          final results = snapshot.data;
          results.sort((RicoResult a, RicoResult b) {
            return b.confidence.compareTo(a.confidence);
          });

          item = results.first.name;
          confidence = results.first.confidence.floor();
          iconPath = toIconPath(item);
          children.addAll([_titleBar(context), _iconBackground(context, iconPath),
                           _mainStatistic(context, confidence), _mainDescriptor(context, item),
                           _playAgainButton(context)]);
        }
        else
          children.addAll([_titleBar(context), _loadingIcon(context)]);

        return bgCirclesBackground(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Stack(
              children: children,
            )
          ),
          color: LightOliveGreen
        );
      },
    );
  }

  Widget _titleBar(BuildContext context) {
    final mediaData = MediaQuery.of(context);
    final height = mediaData.size.height;

    return StreamBuilder(
      stream: StateProvider.of(context).gameStateBloc.statusStream,
      builder: (BuildContext context, AsyncSnapshot<String> snapshot){
        return SafeArea(
          child: Container(
            constraints: BoxConstraints.expand(height: height * .06),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: DarkOliveGreen,
                  width: 1.0,
                )
              )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[_titleText(snapshot.data)],
            )
          )
        );
      }
    );
  }

  Widget _titleText(String title) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w500,
        letterSpacing: 2.0,
        color: Colors.white,
      ),
    );
  }

  Widget _mainStatistic(BuildContext context, int confidence) {
    final mediaData = MediaQuery.of(context);
    final height = mediaData.size.height;
    final width = mediaData.size.width;

    final topText = 'With a'.toUpperCase();
    final lowerText = 'Confidence level...'.toUpperCase();

    return Positioned(
      top: height * .158,
      right: width * .085,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _mainSubText(topText),
          _mainText('${confidence.toString()}%'),
          _mainSubText(lowerText),
        ],
      )
    );
  }
  
  Widget _mainSubText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 12.0,
        letterSpacing: 1.6,
        color: Colors.white,
      ),
    );
  }

  Widget _mainSubAltText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16.0,
        letterSpacing: 0.0,
        color: Colors.white,
      ),
    );
  }
  
  Widget _mainText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w200,
        fontSize: 75.0,
        color: Colors.white,
      ),
    );
  }

  Widget _mainDescriptor(BuildContext context, String item) {
    final mediaData = MediaQuery.of(context);
    final height = mediaData.size.height;
    final width = mediaData.size.width;

    final topText = 'Rico says it\'s a:'.toUpperCase();
    final lowerText = 's for everyone!!!';

    return Positioned(
      top: height * .343,
      left: width * .093,
      width: width * .8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _mainSubText(topText),
          _mainText('${item.toUpperCase()}!'),
          _mainSubAltText('$item$lowerText'),
        ],
      )
    );
  }

  Widget _iconBackground(BuildContext context, String iconPath) {
    final mediaData = MediaQuery.of(context);
    final height = mediaData.size.height;
    final width = mediaData.size.width;
  
    return Positioned(
      top: height * .216,
      left: width * .093,
      right: width * .093,
      child: SvgPicture.asset(
        iconPath,
        color: Colors.black.withOpacity(0.05),
        width: width * .814,
      ),
    );
  }

  Widget _playAgainButton(BuildContext context) {
    final mediaData = MediaQuery.of(context);
    final height = mediaData.size.height;
    final width = mediaData.size.width;

    return Positioned(
      top: height * .65,
      left: width * 0,
      right: width * 0,
      child: Container(
        padding: EdgeInsets.only(
          top: height * .113,
          right: width * .1665,
          left: width * .1665,
        ),
        child: raisedIconButton(
          "PLAY AGAIN",
          Colors.white,
          LightOliveGreen,
          _buttonIcon(context),
          action: () => Navigator.of(context).popUntil((Route r) => r.settings.name == '/home')
        )
      )
    );
  }

  Widget _buttonIcon(BuildContext context) {
    final mediaData = MediaQuery.of(context);
    final height = mediaData.size.height;
    final width = mediaData.size.width;

    return SvgPicture.asset(
      'assets/images/icons/icon-redo.svg',
      color: LightOliveGreen,
      width: 24.0,
      height: 24.0,
    );
  }

  Widget _loadingIcon(BuildContext context) {
    final mediaData = MediaQuery.of(context);
    final height = mediaData.size.height;
    final width = mediaData.size.width;

    return Positioned(
      top: height * .25,
      left: width * .25,
      right: width * .25,
      child: SvgPicture.asset(
        'assets/images/icons/icon-logo.svg',
        color: Colors.white,
        width: width * .5,
      ),
    );
  }

  String toIconPath (String item) {
    List<String> items = ['bowl', 'bread', 'burrito', 'camera', 'cup', 'hotdog', 'taco'];

    if (items.contains(item.toLowerCase())) {
      return 'assets/images/icons/icon-${item.toLowerCase()}.svg';
    } else {
      return 'assets/images/icons/icon-success.svg';
    }
  }

}