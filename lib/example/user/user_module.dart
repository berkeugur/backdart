import 'package:backdart/abstracts.dart';
import 'user_controller.dart';

class UserModule extends Module {
  @override
  List<Controller> get controllers => [UserController()];
}
