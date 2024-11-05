import 'dart:mirrors';
import 'dart:io';
import 'package:backdart/abstracts.dart';
import 'package:backdart/annotations.dart';
import 'package:backdart/extensions/param_extension.dart';
import 'package:backdart/http_methods.dart';
import 'package:backdart/swagger/swagger_options.dart';
import 'package:backdart/typedef.dart';

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

class Router {
  final Routes _routes = {};
  final Map<PathWithMethod, SwaggerSettings> swaggerSetting = <PathWithMethod, SwaggerSettings>{};

  void addSwaggerSetting(PathWithMethod pathWithMethod, SwaggerSettings settings) {
    swaggerSetting[PathWithMethod(convertPathParamsToSwaggerParams(pathWithMethod.path), pathWithMethod.method)] = settings;
  }

  void addRoute(HttpMethods method, String path, RouteHandler handler) {
    _routes.putIfAbsent(method, () => {})[path] = handler;
  }

  Routes getRoutes() => _routes;

  void handleRequest(HttpRequest request) {
    final method = request.method;
    final path = request.uri.path;

    final handler = _findHandler(HttpMethods.values.byName(method), path);
    if (handler != null) {
      final params = _extractParams(handler.path, path);
      if (params.isEmpty) {
        handler.function(request);
      } else {
        handler.function(request);
      }
    } else {
      request.response
        ..statusCode = HttpStatus.notFound
        ..write('Not Found')
        ..close();
    }
  }

  _RouteHandler? _findHandler(HttpMethods method, String path) {
    final routes = _routes[method];
    if (routes == null) return null;

    for (var route in routes.entries) {
      final routePath = route.key;
      final regex = RegExp('^' + routePath.replaceAllMapped(RegExp(r':(\w+)'), (match) => r'([^/]+)') + r'$');
      if (regex.hasMatch(path)) {
        return _RouteHandler(routePath, route.value);
      }
    }
    return null;
  }

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

  void registerController(Controller controller) {
    final instanceMirror = reflect(controller);
    final classMirror = instanceMirror.type;

    for (var declaration in classMirror.declarations.values) {
      if (declaration.metadata.isNotEmpty) {
        for (var metadata in declaration.metadata) {
          final reflectee = metadata.reflectee;
          handler(HttpRequest request) {
            request.originalRequest = reflectee.path;
            return instanceMirror.invoke(declaration.simpleName, [request]).reflectee;
          }

          if (reflectee is Get) {
            // Erişim ve route ekleme
            InstanceMirror? apiSummary = declaration.metadata.firstWhere((m) => m.reflectee is ApiSummary, orElse: () => reflect(null));
            InstanceMirror? apiDescription = declaration.metadata.firstWhere((m) => m.reflectee is ApiDescription, orElse: () => reflect(null));
            final apiSummaryContent = (apiSummary.reflectee as ApiSummary?)?.summary;
            final apiDescriptionContent = (apiDescription.reflectee as ApiDescription?)?.description;
            print(apiDescriptionContent);

            addRoute(HttpMethods.GET, reflectee.path, handler);
            addSwaggerSetting(PathWithMethod(reflectee.path, HttpMethods.GET), SwaggerSettings(summary: apiSummaryContent, description: apiDescriptionContent));

            // Burada summary ve description'ı kullanabilirsiniz
          } else if (reflectee is Post) {
            // Erişim ve route ekleme
            InstanceMirror? apiSummary = declaration.metadata.firstWhere((m) => m.reflectee is ApiSummary, orElse: () => reflect(null));
            InstanceMirror? apiDescription = declaration.metadata.firstWhere((m) => m.reflectee is ApiDescription, orElse: () => reflect(null));
            final apiSummaryContent = (apiSummary.reflectee as ApiSummary?)?.summary;
            final apiDescriptionContent = (apiDescription.reflectee as ApiDescription?)?.description;

            addRoute(HttpMethods.POST, reflectee.path, handler);
            addSwaggerSetting(PathWithMethod(reflectee.path, HttpMethods.POST), SwaggerSettings(summary: apiSummaryContent, description: apiDescriptionContent));
          } else if (reflectee is Put) {
            // Erişim ve route ekleme
            InstanceMirror? apiSummary = declaration.metadata.firstWhere((m) => m.reflectee is ApiSummary, orElse: () => reflect(null));
            InstanceMirror? apiDescription = declaration.metadata.firstWhere((m) => m.reflectee is ApiDescription, orElse: () => reflect(null));
            final apiSummaryContent = (apiSummary.reflectee as ApiSummary?)?.summary;
            final apiDescriptionContent = (apiDescription.reflectee as ApiDescription?)?.description;

            addRoute(HttpMethods.PUT, reflectee.path, handler);
            addSwaggerSetting(PathWithMethod(reflectee.path, HttpMethods.PUT), SwaggerSettings(summary: apiSummaryContent, description: apiDescriptionContent));
          } else if (reflectee is Delete) {
            // Erişim ve route ekleme
            InstanceMirror? apiSummary = declaration.metadata.firstWhere((m) => m.reflectee is ApiSummary, orElse: () => reflect(null));
            InstanceMirror? apiDescription = declaration.metadata.firstWhere((m) => m.reflectee is ApiDescription, orElse: () => reflect(null));
            final apiSummaryContent = (apiSummary.reflectee as ApiSummary?)?.summary;
            final apiDescriptionContent = (apiDescription.reflectee as ApiDescription?)?.description;

            addRoute(HttpMethods.DELETE, reflectee.path, handler);
            addSwaggerSetting(PathWithMethod(reflectee.path, HttpMethods.DELETE), SwaggerSettings(summary: apiSummaryContent, description: apiDescriptionContent));
          }
        }
      }
    }
    swaggerSetting.forEach((key, value) {
      print("key: ${key.path} ${key.method} value: ${value.summary} ${value.description}");
    });
    SwaggerOptions.createSwaggerJsonFile(this);
  }
}

class _RouteHandler {
  final String path;
  final Function(HttpRequest) function;

  _RouteHandler(this.path, this.function);
}
