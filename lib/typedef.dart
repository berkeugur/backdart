import 'dart:io';

import 'package:backdart/http_methods.dart';

typedef Routes = Map<HttpMethods, Map<String, RouteHandler>>;

typedef RouteHandler = Function(HttpRequest);
