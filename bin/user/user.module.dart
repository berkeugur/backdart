import 'package:backdart/abstracts.dart';
import '../user/user.controller.dart';

class UserModule extends Module {
  @override
  List<Controller> get controllers => [UserController()];

  @override
  List<Service> get services => [];
}
