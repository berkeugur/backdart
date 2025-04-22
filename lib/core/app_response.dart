import 'package:backdart/app.dart';

class Res {
  static AppJsonResponse json(Map<String, dynamic> json) {
    return AppJsonResponse(json: json);
  }

  static AppTextResponse text(String text) {
    return AppTextResponse(text: text);
  }
}

class AppJsonResponse extends Res {
  final Map<String, dynamic> json;

  AppJsonResponse({required this.json});
}

class AppTextResponse extends Res {
  final String text;

  AppTextResponse({required this.text});
}
