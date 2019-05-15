import 'dart:io';
import 'package:flutter/material.dart';
import 'package:app/view/widgets/color.dart';

Widget raisedButton(String buttonText, Color buttonColor, Color textColor, {Function action}) {
  return RaisedButton(
    child: Container(
      child: Center(
        child: Text(
          buttonText,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: textColor,
            fontSize: 16.0,
          ), 
        )
      )
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
    color: buttonColor,
    onPressed: action
  );
}

Widget raisedIconButton(String buttonText, Color buttonColor, Color textColor, Widget icon, {Function action}) {
  return RaisedButton(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          buttonText,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: textColor,
            fontSize: 16.0
          ),
        ),
        icon
      ],
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
    color: buttonColor,
    onPressed: action
  );
}

Widget flatButton(String title, {Function action}) {
  return FlatButton(
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
  );
}