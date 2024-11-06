import 'dart:io';

extension BodyExtension on HttpRequest {
  static final Map<String, dynamic> _body = {};

  Map<String, dynamic> get body {
    return _body;
  }

  void setBody(Map<String, dynamic> body) {
    body.clear();
    _body.addAll(body);
  }
}
