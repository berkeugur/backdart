import 'dart:io';
import 'package:backdart/abstracts.dart';
import 'package:backdart/annotations.dart';
import 'package:backdart/router.dart';

class ApiController extends Controller {
  final Router router;

  ApiController({required this.router});

  @Get("/swagger")
  Future<HttpResponse> getSwaggerUi(HttpRequest request) async {
    return await _serveFile(request, 'lib/public/swagger/index.html');
  }

  @Get("/swagger/:filename")
  Future<HttpResponse> getSwaggerAssets(HttpRequest request, Map<String, String> params) async {
    final filePath = 'lib/public/swagger/${params['filename']}';
    return await _serveFile(request, filePath);
  }

  Future<HttpResponse> _serveFile(HttpRequest request, String filePath) async {
    final file = File(filePath);
    if (await file.exists()) {
      final contents = await file.readAsBytes();
      request.response
        ..statusCode = HttpStatus.ok
        ..headers.contentType = _getContentType(filePath)
        ..add(contents)
        ..close();
    } else {
      request.response
        ..statusCode = HttpStatus.notFound
        ..write('File not found')
        ..close();
    }
    return request.response;
  }

  ContentType _getContentType(String filePath) {
    if (filePath.endsWith('.html')) {
      return ContentType.html;
    } else if (filePath.endsWith('.css')) {
      return ContentType('text', 'css', charset: 'utf-8');
    } else if (filePath.endsWith('.js')) {
      return ContentType('application', 'javascript', charset: 'utf-8');
    } else if (filePath.endsWith('.png')) {
      return ContentType('image', 'png');
    } else {
      return ContentType.text;
    }
  }
}
