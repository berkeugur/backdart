import 'dart:io';
import 'package:backdart/abstracts.dart';
import 'package:backdart/annotations.dart';

class UserController extends Controller {
  @Get('/hello')
  @ApiSummary("Hello World Summary")
  HttpResponse getHello(HttpRequest request) {
    request.response
      ..statusCode = HttpStatus.ok
      ..write('merhaba dünya')
      ..close();
    return request.response;
  }

  @Get('/user/:id')
  HttpResponse getUserById(HttpRequest request, Map<String, String> params) {
    request.response
      ..statusCode = HttpStatus.ok
      ..write('merhaba dünya ${params['id']}')
      ..close();
    return request.response;
  }

  @Get('/user/:id/:name')
  HttpResponse getUsersById(HttpRequest request, Map<String, String> params) {
    request.response
      ..statusCode = HttpStatus.ok
      ..write('merhaba dünya ${params['id']} ${params['name']}')
      ..close();
    return request.response;
  }

  @Get('/user/:id/profile/:name')
  HttpResponse getUxsersById(HttpRequest request, Map<String, String> params) {
    request.response
      ..statusCode = HttpStatus.ok
      ..write('merhaba dünya ${params['id']} ${params['name']}')
      ..close();
    return request.response;
  }

  @Post('/user')
  HttpResponse postUserById(HttpRequest request, Map<String, String> params) {
    request.response
      ..statusCode = HttpStatus.ok
      ..write('merhaba dünya ${params['id']}')
      ..close();
    return request.response;
  }

  @Get('/user')
  HttpResponse posUserById(HttpRequest request, Map<String, String> params) {
    request.response
      ..statusCode = HttpStatus.ok
      ..write('merhaba dünya ${params['id']}')
      ..close();
    return request.response;
  }
}
