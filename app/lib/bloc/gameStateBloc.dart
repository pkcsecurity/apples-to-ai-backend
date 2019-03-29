import 'dart:io';
import 'package:rxdart/rxdart.dart';

import 'package:app/model/ricoResultsModel.dart';
import 'package:app/provider/ricoProvider.dart';

class GameStateBloc {
  final _image = PublishSubject<File>();
  final _results = PublishSubject<List<RicoResult>>();

  Stream<List<RicoResult>> get resultsStream => _results.stream;
  Sink<File> get imageSink => _image.sink;

  GameStateBloc() {
    _image.stream.listen((img) {
      RicoProvider.submitImage(img).then((list) {
        if (list != null && list.length > 0) {
          list.removeWhere((RicoResult r) => r.parents.isEmpty,
          );
          _results.add(list);
        }
      });
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
