import 'package:flutter/material.dart';

class NewGamePage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: FlatButton(
          onPressed: () =>
              Navigator.of(context).popUntil((Route r) => r.settings.name == '/home'),
          child: Text("New Game")
        ),
      ),
    );
  }
}