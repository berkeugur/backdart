import 'dart:mirrors';
import 'dart:io';
import 'package:backdart/abstracts.dart';
import 'package:backdart/annotations.dart';
import 'package:backdart/console_logs.dart';
import 'package:backdart/extensions/param_extension.dart';
import 'package:backdart/http_methods.dart';
import 'package:backdart/models/path_with_method.dart';
import 'package:backdart/swagger/models/swagger_settings.dart';
import 'package:backdart/swagger/swagger_options.dart';
import 'package:backdart/swagger/swagger_schema.dart';
import 'package:backdart/typedef.dart';
import 'package:backdart/utils/convert_path_params_to_swagger_params.dart';

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
      Type? bodyScheme = findTypeFromDeclaration(declaration);

      if (declaration.metadata.isNotEmpty) {
        for (var metadata in declaration.metadata) {
          final reflectee = metadata.reflectee;
          handler(HttpRequest request) {
            request.originalRequest = reflectee.path;
            return instanceMirror.invoke(declaration.simpleName, [request]).reflectee;
          }

          if (reflecteeToHttpMethod(reflectee) != null) {
            InstanceMirror? apiSummary = declaration.metadata.firstWhere((m) => m.reflectee is ApiSummary, orElse: () => reflect(null));
            InstanceMirror? apiDescription = declaration.metadata.firstWhere((m) => m.reflectee is ApiDescription, orElse: () => reflect(null));
            final apiSummaryContent = (apiSummary.reflectee as ApiSummary?)?.summary;
            final apiDescriptionContent = (apiDescription.reflectee as ApiDescription?)?.description;
            addRoute(reflecteeToHttpMethod(reflectee)!, reflectee.path, handler);
            addSwaggerSetting(
              PathWithMethod(reflectee.path, reflecteeToHttpMethod(reflectee)!),
              SwaggerSettings(
                summary: apiSummaryContent,
                description: apiDescriptionContent,
                bodyScheme: bodyScheme,
              ),
            );
          }
        }
      }
    }
    logSwaggerEndpoints(swaggerSetting);
    SwaggerOptions.createSwaggerJsonFile(this);
  }
}

class _RouteHandler {
  final String path;
  final Function(HttpRequest) function;

  _RouteHandler(this.path, this.function);
}
