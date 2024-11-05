import 'dart:convert';

class EndpointModel {
  final List<String> tags;
  final String summary;
  final String description;
  final String operationId;
  final List<String>? consumes;
  final List<Produce> produces;
  final List<Parameter> parameters;
  final Map<String, Response> responses;
  final List<Security> security;
  final bool? deprecated;

  EndpointModel({
    required this.tags,
    required this.summary,
    required this.description,
    required this.operationId,
    this.consumes,
    required this.produces,
    required this.parameters,
    required this.responses,
    required this.security,
    this.deprecated,
  });

  EndpointModel copyWith({
    List<String>? tags,
    String? summary,
    String? description,
    String? operationId,
    List<String>? consumes,
    List<Produce>? produces,
    List<Parameter>? parameters,
    Map<String, Response>? responses,
    List<Security>? security,
    bool? deprecated,
  }) =>
      EndpointModel(
        tags: tags ?? this.tags,
        summary: summary ?? this.summary,
        description: description ?? this.description,
        operationId: operationId ?? this.operationId,
        consumes: consumes ?? this.consumes,
        produces: produces ?? this.produces,
        parameters: parameters ?? this.parameters,
        responses: responses ?? this.responses,
        security: security ?? this.security,
        deprecated: deprecated ?? this.deprecated,
      );

  factory EndpointModel.fromRawJson(String str) => EndpointModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EndpointModel.fromJson(Map<String, dynamic> json) => EndpointModel(
        tags: List<String>.from(json["tags"].map((x) => x)),
        summary: json["summary"],
        description: json["description"],
        operationId: json["operationId"],
        consumes: json["consumes"] == null ? [] : List<String>.from(json["consumes"]!.map((x) => x)),
        produces: List<Produce>.from(json["produces"].map((x) => produceValues.map[x]!)),
        parameters: List<Parameter>.from(json["parameters"].map((x) => Parameter.fromJson(x))),
        responses: Map.from(json["responses"]).map((k, v) => MapEntry<String, Response>(k, Response.fromJson(v))),
        security: List<Security>.from(json["security"].map((x) => Security.fromJson(x))),
        deprecated: json["deprecated"],
      );

  Map<String, dynamic> toJson() => {
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "summary": summary,
        "description": description,
        "operationId": operationId,
        "consumes": consumes == null ? [] : List<dynamic>.from(consumes!.map((x) => x)),
        "produces": List<dynamic>.from(produces.map((x) => produceValues.reverse[x])),
        "parameters": List<dynamic>.from(parameters.map((x) => x.toJson())),
        "responses": Map.from(responses).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
        "security": List<dynamic>.from(security.map((x) => x.toJson())),
        "deprecated": deprecated,
      };
}

class Parameter {
  final String name;
  final String parameterIn;
  final String? description;
  final bool required;
  final String? type;
  final String? format;
  final ItemsClass? schema;
  final Items? items;
  final String? collectionFormat;

  Parameter({
    required this.name,
    required this.parameterIn,
    this.description,
    required this.required,
    this.type,
    this.format,
    this.schema,
    this.items,
    this.collectionFormat,
  });

  Parameter copyWith({
    String? name,
    String? parameterIn,
    String? description,
    bool? required,
    String? type,
    String? format,
    ItemsClass? schema,
    Items? items,
    String? collectionFormat,
  }) =>
      Parameter(
        name: name ?? this.name,
        parameterIn: parameterIn ?? this.parameterIn,
        description: description ?? this.description,
        required: required ?? this.required,
        type: type ?? this.type,
        format: format ?? this.format,
        schema: schema ?? this.schema,
        items: items ?? this.items,
        collectionFormat: collectionFormat ?? this.collectionFormat,
      );

  factory Parameter.fromRawJson(String str) => Parameter.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Parameter.fromJson(Map<String, dynamic> json) => Parameter(
        name: json["name"],
        parameterIn: json["in"],
        description: json["description"],
        required: json["required"],
        type: json["type"],
        format: json["format"],
        schema: json["schema"] == null ? null : ItemsClass.fromJson(json["schema"]),
        items: json["items"] == null ? null : Items.fromJson(json["items"]),
        collectionFormat: json["collectionFormat"],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "name": name,
      "in": parameterIn,
      "description": description,
      "required": required,
      "type": type,
      "format": format,
      "schema": schema?.toJson(),
      "items": items?.toJson(),
      "collectionFormat": collectionFormat,
    };
    map.removeWhere((key, value) {
      return value == null;
    });
    return map;
  }
}

class Items {
  final String type;
  final List<String>? itemsEnum;
  final String? itemsDefault;

  Items({
    required this.type,
    this.itemsEnum,
    this.itemsDefault,
  });

  Items copyWith({
    String? type,
    List<String>? itemsEnum,
    String? itemsDefault,
  }) =>
      Items(
        type: type ?? this.type,
        itemsEnum: itemsEnum ?? this.itemsEnum,
        itemsDefault: itemsDefault ?? this.itemsDefault,
      );

  factory Items.fromRawJson(String str) => Items.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Items.fromJson(Map<String, dynamic> json) => Items(
        type: json["type"],
        itemsEnum: json["enum"] == null ? [] : List<String>.from(json["enum"]!.map((x) => x)),
        itemsDefault: json["default"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "enum": itemsEnum == null ? [] : List<dynamic>.from(itemsEnum!.map((x) => x)),
        "default": itemsDefault,
      };
}

class ItemsClass {
  final String ref;

  ItemsClass({
    required this.ref,
  });

  ItemsClass copyWith({
    String? ref,
  }) =>
      ItemsClass(
        ref: ref ?? this.ref,
      );

  factory ItemsClass.fromRawJson(String str) => ItemsClass.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ItemsClass.fromJson(Map<String, dynamic> json) => ItemsClass(
        ref: json["\u0024ref"],
      );

  Map<String, dynamic> toJson() => {
        "\u0024ref": ref,
      };
}

enum Produce { APPLICATION_JSON, APPLICATION_XML }

final produceValues = EnumValues({"application/json": Produce.APPLICATION_JSON, "application/xml": Produce.APPLICATION_XML});

class Response {
  final String description;
  final ResponseSchema? schema;

  Response({
    required this.description,
    this.schema,
  });

  Response copyWith({
    String? description,
    ResponseSchema? schema,
  }) =>
      Response(
        description: description ?? this.description,
        schema: schema ?? this.schema,
      );

  factory Response.fromRawJson(String str) => Response.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        description: json["description"],
        schema: json["schema"] == null ? null : ResponseSchema.fromJson(json["schema"]),
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "schema": schema?.toJson(),
      };
}

class ResponseSchema {
  final String? ref;
  final String? type;
  final ItemsClass? items;
  final AdditionalProperties? additionalProperties;

  ResponseSchema({
    this.ref,
    this.type,
    this.items,
    this.additionalProperties,
  });

  ResponseSchema copyWith({
    String? ref,
    String? type,
    ItemsClass? items,
    AdditionalProperties? additionalProperties,
  }) =>
      ResponseSchema(
        ref: ref ?? this.ref,
        type: type ?? this.type,
        items: items ?? this.items,
        additionalProperties: additionalProperties ?? this.additionalProperties,
      );

  factory ResponseSchema.fromRawJson(String str) => ResponseSchema.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ResponseSchema.fromJson(Map<String, dynamic> json) => ResponseSchema(
        ref: json["\u0024ref"],
        type: json["type"],
        items: json["items"] == null ? null : ItemsClass.fromJson(json["items"]),
        additionalProperties: json["additionalProperties"] == null ? null : AdditionalProperties.fromJson(json["additionalProperties"]),
      );

  Map<String, dynamic> toJson() => {
        "\u0024ref": ref,
        "type": type,
        "items": items?.toJson(),
        "additionalProperties": additionalProperties?.toJson(),
      };
}

class AdditionalProperties {
  final String type;
  final String format;

  AdditionalProperties({
    required this.type,
    required this.format,
  });

  AdditionalProperties copyWith({
    String? type,
    String? format,
  }) =>
      AdditionalProperties(
        type: type ?? this.type,
        format: format ?? this.format,
      );

  factory AdditionalProperties.fromRawJson(String str) => AdditionalProperties.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AdditionalProperties.fromJson(Map<String, dynamic> json) => AdditionalProperties(
        type: json["type"],
        format: json["format"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "format": format,
      };
}

class Security {
  final List<PetstoreAuth>? petstoreAuth;
  final List<dynamic>? apiKey;

  Security({
    this.petstoreAuth,
    this.apiKey,
  });

  Security copyWith({
    List<PetstoreAuth>? petstoreAuth,
    List<dynamic>? apiKey,
  }) =>
      Security(
        petstoreAuth: petstoreAuth ?? this.petstoreAuth,
        apiKey: apiKey ?? this.apiKey,
      );

  factory Security.fromRawJson(String str) => Security.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Security.fromJson(Map<String, dynamic> json) => Security(
        petstoreAuth: json["petstore_auth"] == null ? [] : List<PetstoreAuth>.from(json["petstore_auth"]!.map((x) => petstoreAuthValues.map[x]!)),
        apiKey: json["api_key"] == null ? [] : List<dynamic>.from(json["api_key"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "petstore_auth": petstoreAuth == null ? [] : List<dynamic>.from(petstoreAuth!.map((x) => petstoreAuthValues.reverse[x])),
        "api_key": apiKey == null ? [] : List<dynamic>.from(apiKey!.map((x) => x)),
      };
}

enum PetstoreAuth { READ_PETS, WRITE_PETS }

final petstoreAuthValues = EnumValues({"read:pets": PetstoreAuth.READ_PETS, "write:pets": PetstoreAuth.WRITE_PETS});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
