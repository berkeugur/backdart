import 'dart:io';
import 'package:backdart/abstracts.dart';
import 'package:backdart/annotations.dart';
import 'package:backdart/extensions/param_extension.dart';
import './user.create.dto.dart';

class UserController extends Controller {
  @Get('/hello')
  @ApiSummary("Hello World Summary")
  @ApiDescription("Hello World Description")
  HttpResponse getHello(HttpRequest request) {
    request.response
      ..statusCode = HttpStatus.ok
      ..write('merhaba dünya')
      ..close();
    return request.response;
  }

  @Get('/user/:id')
  @ApiSummary("User bilgilerini getirmek için endpoint")
  HttpResponse getUserById(HttpRequest request) {
    request.response
      ..statusCode = HttpStatus.ok
      ..write('merhaba dünya ${request.params['id']}')
      ..close();
    return request.response;
  }

  @Get('/user/:id/:name')
  HttpResponse getUsersById(HttpRequest request) {
    request.response
      ..statusCode = HttpStatus.ok
      ..write('merhaba dünya ${request.params['id']} ${request.params['name']}')
      ..close();
    return request.response;
  }

  @Get('/user/:id/profile/:name')
  HttpResponse getUxsersById(HttpRequest request) {
    request.response
      ..statusCode = HttpStatus.ok
      ..write('merhaba dünya ${request.params['id']} ${request.params['name']}')
      ..close();
    return request.response;
  }

  @Post('/user')
  HttpResponse postUserById(
    HttpRequest request,
    @Body() UserCreateDto body,
  ) {
    request.response
      ..statusCode = HttpStatus.ok
      ..write('merhaba dünya ${request.params['id']}')
      ..close();
    return request.response;
  }

  @Get('/user')
  HttpResponse posUserById(HttpRequest request) {
    request.response
      ..statusCode = HttpStatus.ok
      ..write('merhaba dünya ${request.params['id']}')
      ..close();
    return request.response;
  }

  @Delete('/user')
  @ApiSummary("silme- endpointisidr")
  HttpResponse posUsdadsaserById(HttpRequest request) {
    request.response
      ..statusCode = HttpStatus.ok
      ..write('merhaba dünya ${request.params['id']}')
      ..close();
    return request.response;
  }
}
