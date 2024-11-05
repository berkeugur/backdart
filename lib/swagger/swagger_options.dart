import 'dart:convert';
import 'dart:io';

import 'package:backdart/swagger/models/api_key.dart';
import 'package:backdart/swagger/models/endpoint_model.dart';
import 'package:backdart/swagger/models/external_docs_model.dart';
import 'package:backdart/swagger/models/schemes.dart';
import 'package:backdart/swagger/models/security_definations.dart';
import 'package:backdart/swagger/models/swagger_model.dart';
import 'package:backdart/typedef.dart';

class SwaggerOptions {
  static Set<Schemes> schemes = {
    Schemes.http,
  };

  static void createSwaggerJsonFile(Routes routes) {
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

    routes.forEach(
      (key, value) {
        value.forEach((path, handler) {
          ///exclude swagger paths
          if (path == "/swagger" || path == "/swagger/:filename") return;

          ///convert path params to swagger params
          path = convertPathParamsToSwaggerParams(path);

          ///Get base path like original path is /user/:id/:name, basePath is user
          final basePath = path.split("/")[1];
          final pathParams = path.split("/").where((element) => element.startsWith("{"));

          swaggerModel.paths[path] = {
            ...?swaggerModel.paths[path],
            key.name.toLowerCase(): EndpointModel(
              security: [],
              produces: [Produce.APPLICATION_JSON],
              consumes: ["multipart/form-data"],
              summary: "$path summary",
              description: "${path} description",
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
