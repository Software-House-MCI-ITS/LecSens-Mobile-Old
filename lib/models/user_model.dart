const String tableUsers = 'users';

class UserFields {
  static final List<String> values = [
    id, token, userName, email, fullName, roleID, isVerified, lastLoginTimestamp
  ];

  static const String id = 'id';
  static const String token = 'token';
  static const String userName = 'userName';
  static const String email = 'email';
  static const String fullName = 'fullName';
  static const String roleID = 'roleID';
  static const String isVerified = 'isVerified';
  static const String lastLoginTimestamp = 'lastLoginTimestamp';
}

class User {
  String? token;
  String? id;
  String? userName;
  String? email;
  String? fullName;
  int? roleID;
  bool? isVerified;
  String? lastLoginTimestamp;

  User({
    this.id,
    this.token,
    this.userName,
    this.email,
    this.fullName,
    this.roleID,
    this.isVerified,
    this.lastLoginTimestamp
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      token: json['token'],
      userName: json['userName'],
      email: json['email'],
      fullName: json['fullName'],
      roleID: json['roleID'],
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
      'roleID': roleID,
      'isVerified': isVerified,
      'lastLoginTimestamp': lastLoginTimestamp
    };
  }
}
