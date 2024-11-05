import 'dart:convert';

import 'package:backdart/swagger/models/contact_model.dart';
import 'package:backdart/swagger/models/license_model.dart';

class Info {
  final String? description;
  final String? version;
  final String? title;
  final String? termsOfService;
  final Contact? contact;
  final License? license;

  Info({
    required this.description,
    required this.version,
    required this.title,
    required this.termsOfService,
    required this.contact,
    required this.license,
  });

  Info copyWith({
    String? description,
    String? version,
    String? title,
    String? termsOfService,
    Contact? contact,
    License? license,
  }) =>
      Info(
        description: description ?? this.description,
        version: version ?? this.version,
        title: title ?? this.title,
        termsOfService: termsOfService ?? this.termsOfService,
        contact: contact ?? this.contact,
        license: license ?? this.license,
      );

  factory Info.fromRawJson(String str) => Info.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        description: json["description"] == null ? null : json["description"],
        version: json["version"] == null ? null : json["version"],
        title: json["title"] == null ? null : json["title"],
        termsOfService: json["termsOfService"] == null ? null : json["termsOfService"],
        contact: json["contact"] == null ? null : Contact.fromJson(json["contact"]),
        license: json["license"] == null ? null : License.fromJson(json["license"]),
      );

  Map<String, dynamic> toJson() => {
        "description": description == null ? null : description,
        "version": version == null ? null : version,
        "title": title == null ? null : title,
        "termsOfService": termsOfService == null ? null : termsOfService,
        "contact": contact == null ? null : contact!.toJson(),
        "license": license == null ? null : license!.toJson(),
      };
}
