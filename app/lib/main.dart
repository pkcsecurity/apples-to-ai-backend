import 'package:flutter/material.dart';

import 'package:app/bloc/stateBloc.dart';
import 'package:app/provider/stateProvider.dart';
import 'package:app/view/splashPage.dart';
import 'package:app/view/homePage.dart';
import 'package:app/view/loginPage.dart';
import 'package:app/view/newGamePage.dart';
import 'package:app/view/createGamePage.dart';
import 'package:app/view/joinGamePage.dart';
import 'package:app/view/registerPage.dart';
import 'package:app/view/resultsPage.dart';
import 'package:app/view/verificationPage.dart';
import 'package:app/view/welcomePage.dart';

void main() {
  runApp(ApplesToAIApp());
}

class ApplesToAIApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ApplesToAIState();
  }
}

class _ApplesToAIState extends State<ApplesToAIApp> {
  StateBloc bloc;

  @override
  void initState() {
    super.initState();

    bloc = StateBloc();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StateProvider(
      stateBloc: bloc,
      child: MaterialApp(
        theme: ThemeData(fontFamily: "Dosis"),
        initialRoute: '/login',
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child,
          );
        },
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/splash':
              return CustomAnimatedRoute(
                builder: (_) => SplashPage(),
                settings: settings,
              );
            case '/home':
              return CustomAnimatedRoute(
                builder: (_) => HomePage(),
                settings: settings,
              );
            case '/results':
              return CustomAnimatedRoute(
                builder: (_) => ResultsPage(),
                settings: settings,
              );
            case '/welcome':
              return CustomAnimatedRoute(
                builder: (_) => WelcomePage(),
                settings: settings,
              );
            case '/register':
              return SlideInLeftOutRightRoute(
                builder: (_) => RegisterPage(),
                settings: settings,
              );
            case '/verification':
              return SlideInLeftOutRightRoute(
                builder: (_) => VerificationPage(),
                settings: settings,
              );
            case '/newgame':
              return SlideInLeftOutRightRoute(
                builder: (_) => NewGamePage(),
                settings: settings,
              );
            case '/creategame':
              return SlideInLeftOutRightRoute(
                builder: (_) => CreateGamePage(),
                settings: settings,
              );
            case '/joingame':
              return SlideInLeftOutRightRoute(
                builder: (_) => JoinGamePage(),
                settings: settings,
              );
            default: // '/login'
              return CustomAnimatedRoute(
                builder: (_) => LoginPage(),
                settings: settings,
              );
          }
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class CustomAnimatedRoute<T> extends MaterialPageRoute<T> {
  CustomAnimatedRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute) return child;
    // Fades between routes. (If you don't want any animation,
    // just return child.)
    return FadeTransition(opacity: animation, child: child);
  }
}

class SlideInLeftOutRightRoute<T> extends MaterialPageRoute<T> {
  SlideInLeftOutRightRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    final _animation = Tween<Offset>(
        begin: Offset(1.0, 0.0),
        end: Offset(0.0, 0.0))
        .animate(animation);
    return SlideTransition(
      position: _animation,
      child: child,
    );
  }
}
