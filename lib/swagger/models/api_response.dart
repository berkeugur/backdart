import 'dart:convert';

import 'package:backdart/swagger/models/endpoint_model.dart';

class ApiResponse {
  final String type;
  final ApiResponseProperties properties;

  ApiResponse({
    required this.type,
    required this.properties,
  });

  ApiResponse copyWith({
    String? type,
    ApiResponseProperties? properties,
  }) =>
      ApiResponse(
        type: type ?? this.type,
        properties: properties ?? this.properties,
      );

  factory ApiResponse.fromRawJson(String str) => ApiResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
        type: json["type"],
        properties: ApiResponseProperties.fromJson(json["properties"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "properties": properties.toJson(),
      };
}

class ApiResponseProperties {
  final Code code;
  final Message type;
  final Message message;

  ApiResponseProperties({
    required this.code,
    required this.type,
    required this.message,
  });

  ApiResponseProperties copyWith({
    Code? code,
    Message? type,
    Message? message,
  }) =>
      ApiResponseProperties(
        code: code ?? this.code,
        type: type ?? this.type,
        message: message ?? this.message,
      );

  factory ApiResponseProperties.fromRawJson(String str) => ApiResponseProperties.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ApiResponseProperties.fromJson(Map<String, dynamic> json) => ApiResponseProperties(
        code: Code.fromJson(json["code"]),
        type: Message.fromJson(json["type"]),
        message: Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code.toJson(),
        "type": type.toJson(),
        "message": message.toJson(),
      };
}

class Code {
  final CodeType type;
  final Format format;

  Code({
    required this.type,
    required this.format,
  });

  Code copyWith({
    CodeType? type,
    Format? format,
  }) =>
      Code(
        type: type ?? this.type,
        format: format ?? this.format,
      );

  factory Code.fromRawJson(String str) => Code.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Code.fromJson(Map<String, dynamic> json) => Code(
        type: codeTypeValues.map[json["type"]]!,
        format: formatValues.map[json["format"]]!,
      );

  Map<String, dynamic> toJson() => {
        "type": codeTypeValues.reverse[type],
        "format": formatValues.reverse[format],
      };
}

enum Format { DATE_TIME, INT32, INT64 }

final formatValues = EnumValues({"date-time": Format.DATE_TIME, "int32": Format.INT32, "int64": Format.INT64});

enum CodeType { FILE, INTEGER, STRING }

final codeTypeValues = EnumValues({"file": CodeType.FILE, "integer": CodeType.INTEGER, "string": CodeType.STRING});

class Message {
  final MessageType type;

  Message({
    required this.type,
  });

  Message copyWith({
    MessageType? type,
  }) =>
      Message(
        type: type ?? this.type,
      );

  factory Message.fromRawJson(String str) => Message.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        type: messageTypeValues.map[json["type"]]!,
      );

  Map<String, dynamic> toJson() => {
        "type": messageTypeValues.reverse[type],
      };
}

enum MessageType { BOOLEAN, STRING }

final messageTypeValues = EnumValues({"boolean": MessageType.BOOLEAN, "string": MessageType.STRING});
