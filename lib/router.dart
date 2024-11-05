import 'dart:mirrors';
import 'dart:io';
import 'package:backdart/abstracts.dart';
import 'package:backdart/annotations.dart';
import 'package:backdart/http_methods.dart';
import 'package:backdart/swagger/swagger_options.dart';
import 'package:backdart/typedef.dart';

class Router {
  final Routes _routes = {};

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
        handler.function(request, params);
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
          print("reflectees");
          print(reflectee);
          if (reflectee is Get) {
            handler(HttpRequest request, [Map<String, String>? params]) => instanceMirror.invoke(declaration.simpleName, [request, if (params != null) params]).reflectee;
            addRoute(HttpMethods.GET, reflectee.path, handler);
          } else if (reflectee is Post) {
            handler(HttpRequest request, [Map<String, String>? params]) => instanceMirror.invoke(declaration.simpleName, [request, if (params != null) params]).reflectee;
            addRoute(HttpMethods.POST, reflectee.path, handler);
          } else if (reflectee is Put) {
            handler(HttpRequest request, [Map<String, String>? params]) => instanceMirror.invoke(declaration.simpleName, [request, if (params != null) params]).reflectee;
            addRoute(HttpMethods.PUT, reflectee.path, handler);
          } else if (reflectee is Delete) {
            handler(HttpRequest request, [Map<String, String>? params]) => instanceMirror.invoke(declaration.simpleName, [request, if (params != null) params]).reflectee;
            addRoute(HttpMethods.DELETE, reflectee.path, handler);
          } else if (reflectee is ApiSummary) {
            print("ApiSummary");
            print(reflectee.summary);
          } else if (reflectee is ApiDescription) {
            print("ApiDescription");
            print(reflectee.description);
          }
        }
      }
    }

    SwaggerOptions.createSwaggerJsonFile(_routes);
  }
}

class _RouteHandler {
  final String path;
  final Function(HttpRequest, [Map<String, String>?]) function;

  _RouteHandler(this.path, this.function);
}
