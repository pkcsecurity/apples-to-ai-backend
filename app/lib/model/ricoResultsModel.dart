import 'dart:convert';

class RicoResult {
  String name;
  double confidence;
  List<ParentResult> parents;

  RicoResult({
    this.name,
    this.confidence,
    this.parents,
  });

  factory RicoResult.fromJson(Map<String, dynamic> json) => RicoResult(
        name: json['Name'],
        confidence: json['Confidence'].toDouble(),
        parents: List<ParentResult>.from(
            json['Parents'].map((x) => ParentResult.fromJson(x))),
      );

  static List<RicoResults> resultsFromJson(String str) {
    final jsonData = json.decode(str);
    return List<RicoResults>.from(jsonData.map((x) => RicoResult.fromJson(x)));
  }
}

class ParentResult {
  String name;

  ParentResult({
    this.name,
  });

  factory ParentResult.fromJson(Map<String, dynamic> json) => ParentResult(
        name: json['Name'],
      );
}
