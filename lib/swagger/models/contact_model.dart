import 'dart:convert';

class Contact {
  final String email;

  Contact({
    required this.email,
  });

  Contact copyWith({
    String? email,
  }) =>
      Contact(
        email: email ?? this.email,
      );

  factory Contact.fromRawJson(String str) => Contact.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
      };
}
