const String tableRoles = 'roles';

class RoleFields {
  static final List<String> values = [
    id, name
  ];

  static const String id = 'id';
  static const String name = 'name';
}

class Role {
  String? id;
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

class RoleList {
  List<Role> roleList;

  RoleList({
    required this.roleList,
  });

  factory RoleList.fromJson(List<dynamic> json) {
    List<Role> roleList = <Role>[];
    roleList = json.map((e) => Role.fromJson(e)).toList();
    return RoleList(roleList: roleList);
  }

  List<Map<String, dynamic>> toJson() {
    return roleList.map((e) => e.toJson()).toList();
  }
}