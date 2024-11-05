import 'dart:convert';

import 'package:backdart/swagger/models/api_key.dart';

class SecurityDefinitions {
  final ApiKey apiKey;

  SecurityDefinitions({
    required this.apiKey,
  });

  SecurityDefinitions copyWith({
    ApiKey? apiKey,
  }) =>
      SecurityDefinitions(
        apiKey: apiKey ?? this.apiKey,
      );

  factory SecurityDefinitions.fromRawJson(String str) => SecurityDefinitions.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SecurityDefinitions.fromJson(Map<String, dynamic> json) => SecurityDefinitions(
        apiKey: ApiKey.fromJson(json["api_key"]),
      );

  Map<String, dynamic> toJson() => {
        "api_key": apiKey.toJson(),
      };
}
