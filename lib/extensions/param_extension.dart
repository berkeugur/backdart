import 'dart:io';

extension ParamsExtension on HttpRequest {
  static final Map<HttpRequest, String?> _originalRequests = {};

  String? get originalRequest => _originalRequests[this];
  set originalRequest(String? value) => _originalRequests[this] = value;

  Map<String, String> get params {
    final path = this.uri.path;
    return _extractParams(originalRequest ?? "", path);
  }

  set params(Map<String, String> value) {}

  Map<String, String> _extractParams(String routePath, String requestPath) {
    final params = <String, String>{};
    final routeSegments = routePath.split('/');
    final requestSegments = requestPath.split('/');

    for (var i = 0; i < routeSegments.length; i++) {
      final segment = routeSegments[i];
      if (segment.startsWith(':')) {
        final paramName = segment.substring(1);
        params[paramName] = requestSegments[i];
      }
    }
    return params;
  }
}
