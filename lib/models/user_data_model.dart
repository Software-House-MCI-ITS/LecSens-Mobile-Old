const String tableUserData = 'userData';

class UserDataFields {
  static final List<String> values = [
    id, gender, jabatan];

  static const String id = 'id';
  static const String gender = 'gender';
  static const String jabatan = 'jabatan';
}

class UserData {
  String? id;
  bool? gender;
  String? jabatan;

  UserData({this.id, this.gender, this.jabatan});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'],
      gender: json['gender'],
      jabatan: json['jabatan'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'gender': gender,
      'jabatan': jabatan,
    };
  }
}
