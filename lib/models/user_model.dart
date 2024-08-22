const String tableUsers = 'users';

class UserFields {
  static final List<String> values = [
    id, token, userName, email, fullName, role, isVerified
  ];

  static const String id = 'id';
  static const String token = 'access_token';
  static const String userName = 'username';
  static const String email = 'email';
  static const String fullName = 'name';
  static const String role = 'role';
  static const String isVerified = 'is_verified';
}

class User {
  String? id;
  final String token;
  final String userName;
  final String email;
  final String fullName;
  final String role;
  final bool isVerified;

  User({
    this.id,
    required this.token,
    required this.userName,
    required this.email,
    required this.fullName,
    required this.role,
    required this.isVerified,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json[UserFields.id] as String,
      token: json[UserFields.token] as String,
      userName: json[UserFields.userName] as String,
      email: json[UserFields.email] as String,
      fullName: json[UserFields.fullName] as String,
      role: json[UserFields.role] as String,
      isVerified: json[UserFields.isVerified] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      UserFields.id: id,
      UserFields.token: token,
      UserFields.userName: userName,
      UserFields.email: email,
      UserFields.fullName: fullName,
      UserFields.role: role,
      UserFields.isVerified: isVerified,
    };
  }
}
