import 'dart:mirrors';

class User {
  final String? name;
  final int age;
  final List<String>? friends;

  User({this.name, required this.age, this.friends});
}

Map<String, dynamic> generateSwaggerSchema(Type type) {
  print("Generating schema for $type");
  Map<String, dynamic> schema = {"type": "object", "properties": {}};

  var classMirror = reflectClass(type);

  // Iterate over all instance members (fields, methods, constructors, etc.)
  for (var decl in classMirror.declarations.values) {
    if (decl is VariableMirror && !decl.isStatic) {
      var fieldName = MirrorSystem.getName(decl.simpleName);
      var fieldType = decl.type.reflectedType;

      schema["properties"][fieldName] = _generateTypeSchema(fieldType);
    }
  }
  return schema;
}

Map<String, dynamic> _generateTypeSchema(Type type) {
  // Primitive types mapping for Swagger/OpenAPI
  if (type == int) {
    return {"type": "integer", "format": "int32"};
  } else if (type == double) {
    return {"type": "number", "format": "double"};
  } else if (type == String) {
    return {"type": "string"};
  } else if (type == bool) {
    return {"type": "boolean"};
  } else if (type == DateTime) {
    return {"type": "string", "format": "date-time"};
  } else if (type.toString().startsWith("List")) {
    // Handle lists (arrays in Swagger)
    var itemType = reflectType(type).typeArguments.first.reflectedType;
    return {"type": "array", "items": _generateTypeSchema(itemType)};
  } else {
    // For complex objects, call generateSwaggerSchema recursively
    return generateSwaggerSchema(type);
  }
}

void main() {
  // Örnek olarak User sınıfını veriyoruz, `User` sınıfınızın tanımlı olduğunu varsayıyoruz
  var userSchema = generateSwaggerSchema(User);
  print(userSchema);
}
