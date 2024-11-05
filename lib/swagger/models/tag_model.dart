import 'dart:convert';

import 'package:backdart/swagger/models/external_docs_model.dart';

class Tag {
  final String name;
  final String description;
  final ExternalDocs? externalDocs;

  Tag({
    required this.name,
    required this.description,
    this.externalDocs,
  });

  Tag copyWith({
    String? name,
    String? description,
    ExternalDocs? externalDocs,
  }) =>
      Tag(
        name: name ?? this.name,
        description: description ?? this.description,
        externalDocs: externalDocs ?? this.externalDocs,
      );

  factory Tag.fromRawJson(String str) => Tag.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        name: json["name"],
        description: json["description"],
        externalDocs: json["externalDocs"] == null ? null : ExternalDocs.fromJson(json["externalDocs"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "externalDocs": externalDocs?.toJson(),
      };
}
