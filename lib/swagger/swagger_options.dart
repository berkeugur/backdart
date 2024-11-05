import 'dart:convert';
import 'dart:io';

import 'package:backdart/router.dart';
import 'package:backdart/swagger/models/api_key.dart';
import 'package:backdart/swagger/models/endpoint_model.dart';
import 'package:backdart/swagger/models/external_docs_model.dart';
import 'package:backdart/swagger/models/schemes.dart';
import 'package:backdart/swagger/models/security_definations.dart';
import 'package:backdart/swagger/models/swagger_model.dart';

class SwaggerSettings {
  final String? summary;
  final String? description;

  SwaggerSettings({required this.summary, required this.description});
}

class SwaggerOptions {
  static Set<Schemes> schemes = {
    Schemes.http,
  };

  static void createSwaggerJsonFile(Router router) {
    final file = File('lib/public/swagger/swaggerdeneme.json');
    SwaggerModel? swaggerModel = SwaggerModel(
      swagger: '2.0',
      info: null,
      host: "",
      basePath: "",
      schemes: schemes.toList(),
      paths: {},
      tags: [],
      securityDefinitions: SecurityDefinitions(apiKey: ApiKey(type: "", name: "", apiKeyIn: "")),
      definitions: {},
      externalDocs: ExternalDocs(description: "", url: ""),
    );

    router.getRoutes().forEach(
      (key, value) {
        value.forEach((path, handler) {
          ///exclude swagger paths
          ///
          path = convertPathParamsToSwaggerParams(path);

          if (path == "/swagger" || path == "/swagger/{filename}") return;

          ///Get base path like original path is /user/:id/:name, basePath is user
          final basePath = path.split("/")[1];
          final pathParams = path.split("/").where((element) => element.startsWith("{"));
          print("handler: ${handler.runtimeType}");
          swaggerModel.paths[path] = {
            ...?swaggerModel.paths[path],
            key.name.toLowerCase(): EndpointModel(
              security: [],
              produces: [Produce.APPLICATION_JSON],
              consumes: ["multipart/form-data"],
              summary: router.swaggerSetting[path]?.summary ?? "",
              description: router.swaggerSetting[path]?.description ?? "",
              operationId: "",
              tags: [
                basePath,
              ],
              parameters: [
                ...pathParams.map(
                  (e) {
                    return Parameter(
                      name: e.replaceAll("{", "").replaceAll("}", ""),
                      parameterIn: "path",
                      required: true,
                      type: "string",
                      description: router.swaggerSetting[path]?.description,
                    );
                  },
                )
              ],
              responses: {},
            ),
          };
        });
      },
    );

    file.createSync();
    file.writeAsStringSync(jsonEncode(swaggerModel.toJson()));
  }
}

///user/:id/:name to /user/{id}/{name}
String convertPathParamsToSwaggerParams(String path) {
  // Regex ile ':' karakteriyle başlayan bölümleri '{parametre_adi}' formatına çevirir.
  return path.replaceAllMapped(RegExp(r':(\w+)'), (match) {
    return '{${match.group(1)}}';
  });
}
