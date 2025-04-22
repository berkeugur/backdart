import 'package:backdart/app.dart';
import 'package:backdart/swagger/models/schemes.dart';
import 'package:backdart/swagger/swagger_options.dart';

import 'user/user_module.dart';

void main() {
  final app = App();

  SwaggerOptions.schemes = {Schemes.http, Schemes.https};

  app.registerModule(UserModule());

  app.listen(8080);
}
