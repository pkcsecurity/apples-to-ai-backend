import 'package:rxdart/rxdart.dart';


class SettingsBloc {
  final _isAuthenticated = BehaviorSubject<bool>(seedValue: false);

  SettingsBloc() {
    _isAuthenticated.listen((b) {

    });
  }

  void authenticate() {
    _isAuthenticated.add(true);
  }

  void dispose() {
    _isAuthenticated.close();
  }
}