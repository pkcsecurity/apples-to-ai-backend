import 'dart:io';
import 'package:flutter/material.dart';
import 'package:app/view/widgets/color.dart';

Widget raisedButton(BuildContext context, String buttonText, Function action) {
  final mediaData = MediaQuery.of(context);
  final height = mediaData.size.height;
  final width = mediaData.size.width;

  return Container(
    padding: EdgeInsets.only(
      top: height * .02,
      right: width * .1665,
      left: width * .1665,
    ),
    child: RaisedButton(
      child: Container(
        constraints: BoxConstraints(minHeight: height * .06,),
        child: Center(
          child: Text(
            buttonText,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
              fontSize: 16.0,
            ),
          )
        )
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
      color: LightOliveGreen,
      onPressed: action
    )
  );
}

Widget raisedIconButton(BuildContext context, String buttonText, Widget icon, {Function action}) {
  final mediaData = MediaQuery.of(context);
  final height = mediaData.size.height;
  final width = mediaData.size.width;

  return Container(
    padding: EdgeInsets.only(
      top: height * .113,
      right: width * .1665,
      left: width * .1665,
    ),
    child: RaisedButton(
      child: Container(
        constraints: BoxConstraints(minHeight: height * .06,),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              buttonText,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 16.0
              ),
            ),
            icon
          ],
        )
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
      color: LightOliveGreen,
      onPressed: action
    )
  );
}

Widget drawerButton(String title, {Function action}) {
  return Container(
    child: FlatButton(
      child: Container(
        width: double.infinity,
        child: Text(title,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
          textAlign: TextAlign.left,
        )
      ),
      onPressed: action
    )
  );
}