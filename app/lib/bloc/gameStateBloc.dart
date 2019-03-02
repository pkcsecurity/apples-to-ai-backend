import 'dart:io';
import 'package:rxdart/rxdart.dart';

import 'package:app/model/ricoResultsModel.dart';
import 'package:app/provider/ricoProvider.dart';

class GameStateBloc {
  final image = BehaviorSubject<File>(seedValue: null);
  final results = BehaviorSubject<List<RicoResult>>(seedValue: null);

  GameStateBloc() {
    image.stream.listen((img) {
      RicoProvider.submitImage(img).then(results.add);
    });
    results.stream.listen((List<RicoResult> lst) {
        lst.forEach((RicoResult r) => print(r.name));
    });
  }

  void dispose() {
    image.close();
    results.close();
  }
}
