import 'package:flutter/material.dart';

import 'package:app/bloc/stateBloc.dart';
import 'package:app/provider/stateProvider.dart';
import 'package:app/view/homePage.dart';
import 'package:app/view/loginPage.dart';
import 'package:app/view/resultsPage.dart';

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
        initialRoute: '/home',
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child,
          );
        },
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
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
    return  FadeTransition(opacity: animation, child: child);
  }
}