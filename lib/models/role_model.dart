const String tableRoles = 'roles';

class RoleFields {
  static final List<String> values = [
    id, name
  ];

  static const String id = 'id';
  static const String name = 'name';
}

class Role {
  int? id;
  String? name;

  Role({this.id, this.name});

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}