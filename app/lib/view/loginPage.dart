import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {

  void login(BuildContext context) {
    Navigator.of(context).pushNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            color: Colors.black12,
            child: Center(
                child: MaterialButton(
                  onPressed: () {
                    print('Logging in...');
                    login(context);
                  },
                  child: Text("Log in"),
                  color: Colors.blue,
                )
            )
        )
    );
  }
}

