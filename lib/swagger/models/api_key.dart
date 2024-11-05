import 'dart:convert';

class ApiKey {
  final String type;
  final String name;
  final String apiKeyIn;

  ApiKey({
    required this.type,
    required this.name,
    required this.apiKeyIn,
  });

  ApiKey copyWith({
    String? type,
    String? name,
    String? apiKeyIn,
  }) =>
      ApiKey(
        type: type ?? this.type,
        name: name ?? this.name,
        apiKeyIn: apiKeyIn ?? this.apiKeyIn,
      );

  factory ApiKey.fromRawJson(String str) => ApiKey.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ApiKey.fromJson(Map<String, dynamic> json) => ApiKey(
        type: json["type"],
        name: json["name"],
        apiKeyIn: json["in"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "name": name,
        "in": apiKeyIn,
      };
}
