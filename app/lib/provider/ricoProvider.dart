import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:app/model/ricoResultsModel.dart';

class RicoProvider {
  final _api = Uri.parse("https://www.apples-to-ai.io/rekog");

  Future submitImage(File _img) async {
    final length = await _img.length();
    final req = http.MultipartRequest('POST', _api)
      ..files.add(new http.MultipartFile('photo', _img.openRead(), length));
    http.Response res = await http.Response.fromStream(await req.send());
    return RicoResult.resultsFromJson(res.body);
  }
}
