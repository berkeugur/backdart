import 'package:backdart/http_methods.dart';

class PathWithMethod {
  final String path;
  final HttpMethods method;

  PathWithMethod(
    this.path,
    this.method,
  );

  PathWithMethod copyWith({
    String? path,
    HttpMethods? method,
  }) =>
      PathWithMethod(
        path ?? this.path,
        method ?? this.method,
      );
}
