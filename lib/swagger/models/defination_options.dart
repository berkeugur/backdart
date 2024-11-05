import 'dart:convert';

class DefinationOptions {
  final String type;
  final Properties properties;
  final ItemsXml? xml;
  final List<String>? required;

  DefinationOptions({
    required this.type,
    required this.properties,
    this.xml,
    this.required,
  });

  DefinationOptions copyWith({
    String? type,
    Properties? properties,
    ItemsXml? xml,
    List<String>? required,
  }) =>
      DefinationOptions(
        type: type ?? this.type,
        properties: properties ?? this.properties,
        xml: xml ?? this.xml,
        required: required ?? this.required,
      );

  factory DefinationOptions.fromRawJson(String str) => DefinationOptions.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DefinationOptions.fromJson(Map<String, dynamic> json) => DefinationOptions(
        type: json["type"],
        properties: Properties.fromJson(json["properties"]),
        xml: json["xml"] == null ? null : ItemsXml.fromJson(json["xml"]),
        required: json["required"] == null ? [] : List<String>.from(json["required"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "properties": properties.toJson(),
        "xml": xml?.toJson(),
        "required": required == null ? [] : List<dynamic>.from(required!.map((x) => x)),
      };
}

class Properties {
  final Code? code;
  final Complete? type;
  final Complete? message;
  final Code? id;
  final Name? name;
  final Category? category;
  final PhotoUrls? photoUrls;
  final Tags? tags;
  final Status? status;
  final Code? petId;
  final Code? quantity;
  final Code? shipDate;
  final Complete? complete;
  final Complete? username;
  final Complete? firstName;
  final Complete? lastName;
  final Complete? email;
  final Complete? password;
  final Complete? phone;
  final UserStatus? userStatus;

  Properties({
    this.code,
    this.type,
    this.message,
    this.id,
    this.name,
    this.category,
    this.photoUrls,
    this.tags,
    this.status,
    this.petId,
    this.quantity,
    this.shipDate,
    this.complete,
    this.username,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.phone,
    this.userStatus,
  });

  Properties copyWith({
    Code? code,
    Complete? type,
    Complete? message,
    Code? id,
    Name? name,
    Category? category,
    PhotoUrls? photoUrls,
    Tags? tags,
    Status? status,
    Code? petId,
    Code? quantity,
    Code? shipDate,
    Complete? complete,
    Complete? username,
    Complete? firstName,
    Complete? lastName,
    Complete? email,
    Complete? password,
    Complete? phone,
    UserStatus? userStatus,
  }) =>
      Properties(
        code: code ?? this.code,
        type: type ?? this.type,
        message: message ?? this.message,
        id: id ?? this.id,
        name: name ?? this.name,
        category: category ?? this.category,
        photoUrls: photoUrls ?? this.photoUrls,
        tags: tags ?? this.tags,
        status: status ?? this.status,
        petId: petId ?? this.petId,
        quantity: quantity ?? this.quantity,
        shipDate: shipDate ?? this.shipDate,
        complete: complete ?? this.complete,
        username: username ?? this.username,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        password: password ?? this.password,
        phone: phone ?? this.phone,
        userStatus: userStatus ?? this.userStatus,
      );

  factory Properties.fromRawJson(String str) => Properties.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        code: json["code"] == null ? null : Code.fromJson(json["code"]),
        type: json["type"] == null ? null : Complete.fromJson(json["type"]),
        message: json["message"] == null ? null : Complete.fromJson(json["message"]),
        id: json["id"] == null ? null : Code.fromJson(json["id"]),
        name: json["name"] == null ? null : Name.fromJson(json["name"]),
        category: json["category"] == null ? null : Category.fromJson(json["category"]),
        photoUrls: json["photoUrls"] == null ? null : PhotoUrls.fromJson(json["photoUrls"]),
        tags: json["tags"] == null ? null : Tags.fromJson(json["tags"]),
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
        petId: json["petId"] == null ? null : Code.fromJson(json["petId"]),
        quantity: json["quantity"] == null ? null : Code.fromJson(json["quantity"]),
        shipDate: json["shipDate"] == null ? null : Code.fromJson(json["shipDate"]),
        complete: json["complete"] == null ? null : Complete.fromJson(json["complete"]),
        username: json["username"] == null ? null : Complete.fromJson(json["username"]),
        firstName: json["firstName"] == null ? null : Complete.fromJson(json["firstName"]),
        lastName: json["lastName"] == null ? null : Complete.fromJson(json["lastName"]),
        email: json["email"] == null ? null : Complete.fromJson(json["email"]),
        password: json["password"] == null ? null : Complete.fromJson(json["password"]),
        phone: json["phone"] == null ? null : Complete.fromJson(json["phone"]),
        userStatus: json["userStatus"] == null ? null : UserStatus.fromJson(json["userStatus"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code?.toJson(),
        "type": type?.toJson(),
        "message": message?.toJson(),
        "id": id?.toJson(),
        "name": name?.toJson(),
        "category": category?.toJson(),
        "photoUrls": photoUrls?.toJson(),
        "tags": tags?.toJson(),
        "status": status?.toJson(),
        "petId": petId?.toJson(),
        "quantity": quantity?.toJson(),
        "shipDate": shipDate?.toJson(),
        "complete": complete?.toJson(),
        "username": username?.toJson(),
        "firstName": firstName?.toJson(),
        "lastName": lastName?.toJson(),
        "email": email?.toJson(),
        "password": password?.toJson(),
        "phone": phone?.toJson(),
        "userStatus": userStatus?.toJson(),
      };
}

class Category {
  final String ref;

  Category({
    required this.ref,
  });

  Category copyWith({
    String? ref,
  }) =>
      Category(
        ref: ref ?? this.ref,
      );

  factory Category.fromRawJson(String str) => Category.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        ref: json["\u0024ref"],
      );

  Map<String, dynamic> toJson() => {
        "\u0024ref": ref,
      };
}

class Code {
  final String type;
  final String format;

  Code({
    required this.type,
    required this.format,
  });

  Code copyWith({
    String? type,
    String? format,
  }) =>
      Code(
        type: type ?? this.type,
        format: format ?? this.format,
      );

  factory Code.fromRawJson(String str) => Code.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Code.fromJson(Map<String, dynamic> json) => Code(
        type: json["type"],
        format: json["format"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "format": format,
      };
}

class Complete {
  final String type;

  Complete({
    required this.type,
  });

  Complete copyWith({
    String? type,
  }) =>
      Complete(
        type: type ?? this.type,
      );

  factory Complete.fromRawJson(String str) => Complete.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Complete.fromJson(Map<String, dynamic> json) => Complete(
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
      };
}

class Name {
  final String type;
  final String? example;

  Name({
    required this.type,
    this.example,
  });

  Name copyWith({
    String? type,
    String? example,
  }) =>
      Name(
        type: type ?? this.type,
        example: example ?? this.example,
      );

  factory Name.fromRawJson(String str) => Name.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        type: json["type"],
        example: json["example"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "example": example,
      };
}

class PhotoUrls {
  final String type;
  final PhotoUrlsXml xml;
  final PhotoUrlsItems items;

  PhotoUrls({
    required this.type,
    required this.xml,
    required this.items,
  });

  PhotoUrls copyWith({
    String? type,
    PhotoUrlsXml? xml,
    PhotoUrlsItems? items,
  }) =>
      PhotoUrls(
        type: type ?? this.type,
        xml: xml ?? this.xml,
        items: items ?? this.items,
      );

  factory PhotoUrls.fromRawJson(String str) => PhotoUrls.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PhotoUrls.fromJson(Map<String, dynamic> json) => PhotoUrls(
        type: json["type"],
        xml: PhotoUrlsXml.fromJson(json["xml"]),
        items: PhotoUrlsItems.fromJson(json["items"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "xml": xml.toJson(),
        "items": items.toJson(),
      };
}

class PhotoUrlsItems {
  final String type;
  final ItemsXml xml;

  PhotoUrlsItems({
    required this.type,
    required this.xml,
  });

  PhotoUrlsItems copyWith({
    String? type,
    ItemsXml? xml,
  }) =>
      PhotoUrlsItems(
        type: type ?? this.type,
        xml: xml ?? this.xml,
      );

  factory PhotoUrlsItems.fromRawJson(String str) => PhotoUrlsItems.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PhotoUrlsItems.fromJson(Map<String, dynamic> json) => PhotoUrlsItems(
        type: json["type"],
        xml: ItemsXml.fromJson(json["xml"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "xml": xml.toJson(),
      };
}

class ItemsXml {
  final String name;

  ItemsXml({
    required this.name,
  });

  ItemsXml copyWith({
    String? name,
  }) =>
      ItemsXml(
        name: name ?? this.name,
      );

  factory ItemsXml.fromRawJson(String str) => ItemsXml.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ItemsXml.fromJson(Map<String, dynamic> json) => ItemsXml(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class PhotoUrlsXml {
  final bool wrapped;

  PhotoUrlsXml({
    required this.wrapped,
  });

  PhotoUrlsXml copyWith({
    bool? wrapped,
  }) =>
      PhotoUrlsXml(
        wrapped: wrapped ?? this.wrapped,
      );

  factory PhotoUrlsXml.fromRawJson(String str) => PhotoUrlsXml.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PhotoUrlsXml.fromJson(Map<String, dynamic> json) => PhotoUrlsXml(
        wrapped: json["wrapped"],
      );

  Map<String, dynamic> toJson() => {
        "wrapped": wrapped,
      };
}

class Status {
  final String type;
  final String description;
  final List<String> statusEnum;

  Status({
    required this.type,
    required this.description,
    required this.statusEnum,
  });

  Status copyWith({
    String? type,
    String? description,
    List<String>? statusEnum,
  }) =>
      Status(
        type: type ?? this.type,
        description: description ?? this.description,
        statusEnum: statusEnum ?? this.statusEnum,
      );

  factory Status.fromRawJson(String str) => Status.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        type: json["type"],
        description: json["description"],
        statusEnum: List<String>.from(json["enum"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "description": description,
        "enum": List<dynamic>.from(statusEnum.map((x) => x)),
      };
}

class Tags {
  final String type;
  final PhotoUrlsXml xml;
  final TagsItems items;

  Tags({
    required this.type,
    required this.xml,
    required this.items,
  });

  Tags copyWith({
    String? type,
    PhotoUrlsXml? xml,
    TagsItems? items,
  }) =>
      Tags(
        type: type ?? this.type,
        xml: xml ?? this.xml,
        items: items ?? this.items,
      );

  factory Tags.fromRawJson(String str) => Tags.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Tags.fromJson(Map<String, dynamic> json) => Tags(
        type: json["type"],
        xml: PhotoUrlsXml.fromJson(json["xml"]),
        items: TagsItems.fromJson(json["items"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "xml": xml.toJson(),
        "items": items.toJson(),
      };
}

class TagsItems {
  final ItemsXml xml;
  final String ref;

  TagsItems({
    required this.xml,
    required this.ref,
  });

  TagsItems copyWith({
    ItemsXml? xml,
    String? ref,
  }) =>
      TagsItems(
        xml: xml ?? this.xml,
        ref: ref ?? this.ref,
      );

  factory TagsItems.fromRawJson(String str) => TagsItems.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory TagsItems.fromJson(Map<String, dynamic> json) => TagsItems(
        xml: ItemsXml.fromJson(json["xml"]),
        ref: json["\u0024ref"],
      );

  Map<String, dynamic> toJson() => {
        "xml": xml.toJson(),
        "\u0024ref": ref,
      };
}

class UserStatus {
  final String type;
  final String format;
  final String description;

  UserStatus({
    required this.type,
    required this.format,
    required this.description,
  });

  UserStatus copyWith({
    String? type,
    String? format,
    String? description,
  }) =>
      UserStatus(
        type: type ?? this.type,
        format: format ?? this.format,
        description: description ?? this.description,
      );

  factory UserStatus.fromRawJson(String str) => UserStatus.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserStatus.fromJson(Map<String, dynamic> json) => UserStatus(
        type: json["type"],
        format: json["format"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "format": format,
        "description": description,
      };
}
