import 'dart:io';
import 'package:backdart/abstracts.dart';
import 'package:backdart/swagger/swagger_ui.dart';
import 'package:backdart/router.dart';

class App {
  App() {
    _router.registerController(ApiController(router: _router));
  }

  final Router _router = Router();

  void registerModule(Module module) {
    for (var controller in module.controllers) {
      _router.registerController(controller);
    }
  }

  void listen(int port) async {
    final server = await HttpServer.bind(InternetAddress.anyIPv4, port);
    print('Server listening on port $port');

    await for (HttpRequest request in server) {
      _router.handleRequest(request);
    }
  }
}
