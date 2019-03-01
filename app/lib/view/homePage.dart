import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                  image: AssetImage('assets/images/backgrounds/3.0x/bgCircles.png'),
                )
              ),
              //child: Image.asset('assets/images/backgrounds/3.0x/bgCircles.png', color: Colors.black),
            ),
            Center(
              child: MaterialButton(
                onPressed: () {
                  print('Uploading photo in...');
                },
                child: Text("Upload a photo"),
            )
            )
          ],
        )
    );
  }
}