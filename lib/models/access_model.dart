import 'package:uuid/uuid.dart';

const String tableAccess = 'access';

class AccessFields {
  static final List<String> values = [
    id, userID, alatID];

  static const String id = 'id';
  static const String userID = 'userID';
  static const String alatID = 'alatID';
}

class Access {
  String? id;
  final int userID;
  final int alatID;

  Access({
    this.id,
    required this.userID,
    required this.alatID,
  });

  factory Access.fromJson(Map<String, dynamic> json) {
    return Access(
      id: json[AccessFields.id] as String,
      userID: json[AccessFields.userID] as int,
      alatID: json[AccessFields.alatID] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      AccessFields.id: id,
      AccessFields.userID: userID,
      AccessFields.alatID: alatID,
    };
  }
}

class AccessList {
  List<Access> accessList;

  AccessList({
    required this.accessList,
  });

  factory AccessList.fromJson(List<dynamic> json) {
    List<Access> accessList = <Access>[];
    accessList = json.map((e) => Access.fromJson(e)).toList();
    return AccessList(accessList: accessList);
  }

  List<Map<String, dynamic>> toJson() {
    return accessList.map((e) => e.toJson()).toList();
  }
}