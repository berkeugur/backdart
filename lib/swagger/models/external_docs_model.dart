import 'dart:convert';

class ExternalDocs {
  final String description;
  final String url;

  ExternalDocs({
    required this.description,
    required this.url,
  });

  ExternalDocs copyWith({
    String? description,
    String? url,
  }) =>
      ExternalDocs(
        description: description ?? this.description,
        url: url ?? this.url,
      );

  factory ExternalDocs.fromRawJson(String str) => ExternalDocs.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ExternalDocs.fromJson(Map<String, dynamic> json) => ExternalDocs(
        description: json["description"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "url": url,
      };
}
