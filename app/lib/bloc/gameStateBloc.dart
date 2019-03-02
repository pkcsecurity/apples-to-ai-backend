import 'dart:io';
import 'package:rxdart/rxdart.dart';

import 'package:app/model/ricoResultsModel.dart';
import 'package:app/provider/ricoProvider.dart';

class GameStateBloc {
  final _image = BehaviorSubject<File>(seedValue: null);
  final _results = BehaviorSubject<List<RicoResult>>(seedValue: null);

  Stream<List<RicoResult>> get resultsStream => _results.stream;
  Sink<File> get imageSink => _image.sink;

  GameStateBloc() {
    _image.stream.listen((img) {
      RicoProvider.submitImage(img).then(_results.add);
    });
    _results.stream.listen((List<RicoResult> lst) {
        lst.forEach((RicoResult r) => print(r.name));
    });
  }

  void addImage(File file) {
    _image.add(file);
  }

  void dispose() {
    _image.close();
    _results.close();
  }
}
