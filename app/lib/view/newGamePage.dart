import 'dart:io';
import 'package:flutter/material.dart';
import 'package:app/view/widgets/color.dart';

class NewGamePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    final mediaData = MediaQuery.of(context);
    final height = mediaData.size.height;
    final width = mediaData.size.width;

    return _background(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: height*0.2,
            ),
            Text(
              "Create a new game\nand play with your friends!",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 20.0
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
              ),
              child: _textField("Enter Your Game Name", "My Awesome Game"),
              ),
            _submitButton(context),
            ],
          )
        )
    );
  }

  Widget _background({Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: LightBlue,
        image: DecorationImage(
          image: AssetImage(
            'assets/images/backgrounds/3.0x/bgCirclesSplash.png'),
          fit: BoxFit.cover,
          )
        ),
      child: child,
    );
  }

  Widget _submitButton(BuildContext context) {
    return FlatButton(
      onPressed: () => Navigator.of(context).popUntil((Route r) => r.settings.name == '/home'),
      child: Text("Let's Play!")
    );
  }

  Widget _textField(String label, String hint) {
    return TextField(
      decoration: InputDecoration(
        labelText: "Enter Your Game Name",
        hintText: "My Awesome Game",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
      ),
    );
  }
}

