import 'package:backdart/annotations.dart';

enum HttpMethods {
  GET,
  POST,
  PUT,
  DELETE,
  PATCH,
  HEAD,
  OPTIONS,
  CONNECT,
  TRACE,
}

HttpMethods? reflecteeToHttpMethod(dynamic reflectee) {
  if (reflectee is Get) {
    return HttpMethods.GET;
  }
  if (reflectee is Post) {
    return HttpMethods.POST;
  }
  if (reflectee is Put) {
    return HttpMethods.PUT;
  }
  if (reflectee is Delete) {
    return HttpMethods.DELETE;
  }
  return null;
}
