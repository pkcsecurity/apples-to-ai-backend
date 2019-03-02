import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

import 'package:app/model/ricoResultsModel.dart';

class RicoProvider {
  static Future submitImage(File _img) async {
    print("HI! File path is: " + _img.path);

    final length = await _img.length();
    final req = http.MultipartRequest(
        'POST', Uri.parse("https://www.apples-to-ai.io/rekog"))
      ..files.add(new http.MultipartFile('photo', _img.openRead(), length));
    http.Response res = await http.Response.fromStream(await req.send());
    return RicoResult.resultsFromJson(res.body);
  }
}
