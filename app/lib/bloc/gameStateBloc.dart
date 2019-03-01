import 'dart:io';
import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:app/model/ricoResultsModel.dart';
import 'package:app/provider/ricoProvider.dart';

class GameStateBloc {
  final image = BehaviorSubject<File>(seedValue: null);
  final results = BehaviorSubject<List<RicoResult>>(seedValue: null);

  GameStateBloc() {
    image.stream.listen((img) {
      RicoProvider.submitImage(img)
          .then((List<RicoResult> result) => results.add(result));
    });
  }

  void dispose() {}
}
