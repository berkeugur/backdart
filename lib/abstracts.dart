abstract class Module {
  final List<Controller> controllers = [];
  final List<Service> services = [];

  Module({
    List<Controller>? controllers,
    List<Service>? services,
  }) {
    if (controllers != null) {
      this.controllers.addAll(controllers);
    }
    if (services != null) {
      this.services.addAll(services);
    }
  }
}

abstract class Controller {}

abstract class Service {}

abstract class DTO {
  Map<String, dynamic> toJson();
}
