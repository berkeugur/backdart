import 'dart:convert';

class License {
  final String? name;
  final String? url;

  License({
    required this.name,
    required this.url,
  });

  License copyWith({
    String? name,
    String? url,
  }) =>
      License(
        name: name ?? this.name,
        url: url ?? this.url,
      );

  factory License.fromRawJson(String str) => License.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory License.fromJson(Map<String, dynamic> json) => License(
        name: json["name"] == null ? null : json["name"],
        url: json["url"] == null ? null : json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
