
import 'package:app/bloc/gameStateBloc.dart';
import 'package:app/bloc/settingsBloc.dart';

class StateBloc {
  final settingsBloc;
  final gameStateBloc;

  factory StateBloc() {
    final settingsBloc = SettingsBloc();
    final gameStateBloc = GameStateBloc();

    return StateBloc._(settingsBloc, gameStateBloc);
  }

  StateBloc._(this.settingsBloc, this.gameStateBloc);

  void dispose() {
    settingsBloc.dispose();
    gameStateBloc.dispose();
  }
}