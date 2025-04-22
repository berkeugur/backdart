import 'package:backdart/abstracts.dart';

class UserCreateDto extends DTO {
  final String name;
  final String surname;
  final int age;

  UserCreateDto({
    required this.name,
    required this.surname,
    required this.age,
  });

  @override
  Map<String, dynamic> toJson() {
    return {"name": name, "surname": surname};
  }
}
