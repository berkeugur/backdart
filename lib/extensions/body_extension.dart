import 'dart:io';

extension BodyExtension on HttpRequest {
  static final Map<String, dynamic> _body = {};

  Map<String, dynamic> get body {
    return _body;
  }
}
