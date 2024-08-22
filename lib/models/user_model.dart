const String tableUsers = 'users';

class UserFields {
  static final List<String> values = [
    id, token, userName, email, fullName, role, isVerified, lastLoginTimestamp
  ];

  static const String id = 'id';
  static const String token = 'token';
  static const String userName = 'userName';
  static const String email = 'email';
  static const String fullName = 'fullName';
  static const String role = 'role';
  static const String isVerified = 'isVerified';
  static const String lastLoginTimestamp = 'lastLoginTimestamp';
}

class User {
  String? token;
  String? id;
  String? userName;
  String? email;
  String? fullName;
  String? role;
  bool? isVerified;
  String? lastLoginTimestamp;

  User({
    this.id,
    this.token,
    this.userName,
    this.email,
    this.fullName,
    this.role,
    this.isVerified,
    this.lastLoginTimestamp
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      token: json['access_token'],
      userName: json['username'],
      email: json['email'],
      fullName: json['name'],
      role: json['role'],
      isVerified: json['isVerified'],
      lastLoginTimestamp: json['lastLoginTimestamp']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'token': token,
      'userName': userName,
      'email': email,
      'fullName': fullName,
      'role': role,
      'isVerified': isVerified,
      'lastLoginTimestamp': lastLoginTimestamp
    };
  }
}
