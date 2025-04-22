import 'dart:io';
import 'package:backdart/abstracts.dart';
import 'package:backdart/annotations.dart';
import 'package:backdart/core/app_response.dart';
import 'package:backdart/example/user/user_create_dto.dart';
import 'package:backdart/extensions/param_extension.dart';

class UserController extends Controller {
  @Get('/hello')
  @ApiSummary("Hello World Summary")
  @ApiDescription("Hello World Description")
  Res getHello(HttpRequest request) {
    return Res.json({
      "hello": "world",
      "satir2": "satir2 denemesi uzun ",
    });
  }

  @Get('/hello/:id')
  @ApiSummary("Hello World Summary")
  @ApiDescription("Hello World Description")
  Res getHello2(HttpRequest request) {
    return Res.json({
      "hello": "world",
      "satir2": "satir2 denemesi uzun ",
      "id": request.params['id'],
    });
  }

  @Get('/hellotext')
  @ApiSummary("Hello World Summary")
  @ApiDescription("Hello World Description")
  Res getHelloText(HttpRequest request) {
    return Res.text("Text denemesi");
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
      ..write('merhaba dünya id: ${request.params['id']} name:${request.params['name']} undefinedparameter: ${request.params['undefined']}')
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
  @Body(UserCreateDto)
  Res postUserById(HttpRequest request) {
    return Res.text("post denemesi");
  }

  /*  @Delete('/user')
  @ApiSummary("silme- endpointisidr")
  HttpResponse posUsdadsaserById(HttpRequest request) {
    request.response
      ..statusCode = HttpStatus.ok
      ..write('merhaba dünya ${request.params['id']}')
      ..close();
    return request.response;
  } */
}
