import 'dart:convert';
import 'package:backdart/swagger/models/defination_options.dart';
import 'package:backdart/swagger/models/definations.dart';
import 'package:backdart/swagger/models/endpoint_model.dart';
import 'package:backdart/swagger/models/external_docs_model.dart';
import 'package:backdart/swagger/models/info_model.dart';
import 'package:backdart/swagger/models/paths_model.dart';
import 'package:backdart/swagger/models/schemes.dart';
import 'package:backdart/swagger/models/security_definations.dart';
import 'package:backdart/swagger/models/tag_model.dart';

class SwaggerModel {
  final String swagger;
  final Info? info;
  final String host;
  final String basePath;
  final List<Tag> tags;
  final List<Schemes> schemes;
  final Paths paths;
  final SecurityDefinitions securityDefinitions;
  final Definitions definitions;
  final ExternalDocs externalDocs;

  SwaggerModel({
    required this.swagger,
    required this.info,
    required this.host,
    required this.basePath,
    required this.tags,
    required this.schemes,
    required this.paths,
    required this.securityDefinitions,
    required this.definitions,
    required this.externalDocs,
  });

  SwaggerModel copyWith({
    String? swagger,
    Info? info,
    String? host,
    String? basePath,
    List<Tag>? tags,
    List<Schemes>? schemes,
    Paths? paths,
    SecurityDefinitions? securityDefinitions,
    Definitions? definitions,
    ExternalDocs? externalDocs,
  }) =>
      SwaggerModel(
        swagger: swagger ?? this.swagger,
        info: info ?? this.info,
        host: host ?? this.host,
        basePath: basePath ?? this.basePath,
        tags: tags ?? this.tags,
        schemes: schemes ?? this.schemes,
        paths: paths ?? this.paths,
        securityDefinitions: securityDefinitions ?? this.securityDefinitions,
        definitions: definitions ?? this.definitions,
        externalDocs: externalDocs ?? this.externalDocs,
      );

  factory SwaggerModel.fromRawJson(String str) => SwaggerModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SwaggerModel.fromJson(Map<String, dynamic> json) => SwaggerModel(
        swagger: json["swagger"],
        info: json["info"] == null ? null : Info.fromJson(json["info"]),
        host: json["host"],
        basePath: json["basePath"],
        tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
        schemes: List<Schemes>.from(json["schemes"].map((x) => x)),
        paths: (json["paths"] as Map<String, dynamic>).map(
          (key, value) {
            return MapEntry(
                key,
                (value as Map<String, dynamic>).map(
                  (key, value) {
                    return MapEntry(key, EndpointModel.fromJson(value));
                  },
                ));
          },
        ),
        securityDefinitions: SecurityDefinitions.fromJson(json["securityDefinitions"]),
        definitions: (json["definations"] as Map<String, dynamic>).map(
          (key, value) {
            return MapEntry(key, DefinationOptions.fromJson(value));
          },
        ),
        externalDocs: ExternalDocs.fromJson(json["externalDocs"]),
      );

  Map<String, dynamic> toJson() => {
        "swagger": swagger,
        "info": info == null ? null : info!.toJson(),
        "host": host,
        "basePath": basePath,
        "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
        "schemes": List<dynamic>.from(schemes.map((x) => x.name)),
        "paths": paths.map(
          (key, value) {
            return MapEntry(key, value.map((key, value) => MapEntry(key, value.toJson())));
          },
        ),
        "securityDefinitions": securityDefinitions.toJson(),
        "definitions": definitions.map(
          (key, value) {
            return MapEntry(key, value.toJson());
          },
        ),
        "externalDocs": externalDocs.toJson(),
      };
}
