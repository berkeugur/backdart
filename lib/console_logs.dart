import 'package:backdart/http_methods.dart';
import 'package:backdart/models/path_with_method.dart';
import 'package:backdart/router.dart';
import 'package:backdart/swagger/models/swagger_settings.dart';

String fixMethodName(HttpMethods method) {
  if (method == HttpMethods.GET) {
    return "\x1B[32m${method.name}    :";
  } else if (method == HttpMethods.POST) {
    return "\x1B[34m${method.name}   :";
  } else if (method == HttpMethods.PUT) {
    return "\x1B[33m${method.name}    :";
  } else if (method == HttpMethods.DELETE) {
    return "\x1B[31m${method.name} :";
  } else {
    return "\x1B[37m${method.name} :";
  }
}

void logSwaggerEndpoints(Map<PathWithMethod, SwaggerSettings> swaggerSetting) {
  swaggerSetting.forEach((key, value) {
    if (key.path == "/swagger" || key.path == "/swagger/{filename}") {
      return; // ignore swagger endpoints
    }
    print("${fixMethodName(key.method)} \x1B[37m${key.path}");
  });
}

void logServerListening(int port) {
  print("\x1B[33mServer listening on port: \x1B[37m$port");
}
