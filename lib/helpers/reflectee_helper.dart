import 'package:backdart/annotations.dart';

class ReflecteeHelper {
  static Type? reflecteeToBody(dynamic reflectee) {
    if (reflectee is Body) {
      return reflectee.body;
    }
    return null;
  }
}
