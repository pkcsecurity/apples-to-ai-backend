import 'dart:convert';

class RicoResult {
  String name;
  double confidence;
  List<String> parents;

  RicoResult({
    this.name,
    this.confidence,
    this.parents,
  });

  factory RicoResult.fromJson(Map<String, dynamic> json) => RicoResult(
        name: json['Name'],
        confidence: json['Confidence'].toDouble(),
        parents: List<String>.from(
          json['Parents'].map((x) => x['Name'])),
      );

  static List<RicoResult> resultsFromJson(String str) {
    final jsonData = json.decode(str);
    return List<RicoResult>.from(jsonData.map((x) => RicoResult.fromJson(x)));
  }
}
