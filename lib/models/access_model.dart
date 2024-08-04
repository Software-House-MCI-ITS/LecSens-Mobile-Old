const String tableAccess = 'access';

class AccessFields {
  static final List<String> values = [
    id, userID, alatID];

  static const String id = 'id';
  static const String userID = 'userID';
  static const String alatID = 'alatID';
}

class Access {
  int? id;
  int? userID;
  int? alatID;

  Access({
    this.id,
    this.userID,
    this.alatID,
  });

  factory Access.fromJson(Map<String, dynamic> json) {
    return Access(
      id: json['id'],
      userID: json['userID'],
      alatID: json['alatID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userID': userID,
      'alatID': alatID,
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