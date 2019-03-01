import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'package:app/model/ricoResultsModel.dart';

class RicoBloc {
  final _image = BehaviorSubject<File>(seedValue: null);
  final _results = BehaviorSubject<List<RicoResults>>(seedValue: null);
  

  List<RicoResults> ricoSubmit(File img) {}

  void dispose() {}
}
