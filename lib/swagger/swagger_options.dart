import 'dart:convert';
import 'dart:io';

import 'package:backdart/router.dart';
import 'package:backdart/swagger/models/api_key.dart';
import 'package:backdart/swagger/models/endpoint_model.dart';
import 'package:backdart/swagger/models/external_docs_model.dart';
import 'package:backdart/swagger/models/schemes.dart';
import 'package:backdart/swagger/models/security_definations.dart';
import 'package:backdart/swagger/models/swagger_model.dart';
import 'package:backdart/swagger/swagger_schema.dart';
import 'package:backdart/utils/convert_path_params_to_swagger_params.dart';

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

    print(router.swaggerSetting.map((key, value) {
      print("Key: ${key.method} ${key.path}, Value: ${value.bodyScheme.runtimeType}");
      return MapEntry(key, value.bodyScheme);
    }));
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

          final bodyScheme = router.swaggerSetting.entries
              .where(
                (element) {
                  return element.key.path == path && element.key.method == key;
                },
              )
              .first
              .value
              .bodyScheme;

          final swaggerSetting = router.swaggerSetting.entries
              .where(
                (element) {
                  return element.key.path == path && element.key.method == key;
                },
              )
              .first
              .value;
          if (bodyScheme != null) {
            print("Swagger schema: ");
            print(generateSwaggerSchema(bodyScheme));
            final data = generateSwaggerSchema(bodyScheme);
            swaggerModel.definitions.addAll(
              {
                bodyScheme.toString(): data,
              },
            );
          }

          swaggerModel.paths[path] = {
            ...?swaggerModel.paths[path],
            key.name.toLowerCase(): EndpointModel(
              security: [],
              produces: [Produce.APPLICATION_JSON],
              consumes: ["application/json"],
              summary: swaggerSetting.summary ?? "",
              description: swaggerSetting.description ?? "",
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
                      description: swaggerSetting.description,
                    );
                  },
                ),
                ...bodyScheme != null
                    ? [
                        Parameter(
                          name: "body",
                          parameterIn: "body",
                          required: true,
                          schema: {"\$ref": "#/definitions/${bodyScheme.toString()}"},
                          type: bodyScheme.toString(),
                          description: swaggerSetting.description,
                        ),
                      ]
                    : [],
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
