const String tableAlat = 'alat';

class AlatFields {
  static final List<String> values = [
    id, owner, namaAlat, status, pwm, mode, macAddress];

  static const String id = 'id';
  static const String userID = 'user_id';
  static const String alatID = 'alat_id';
  static const String role = 'role';
  static const String namaAlat = 'nama_alat';
  static const String owner = 'owner';
  static const String status = 'status';
  static const String pwm = 'pwm';
  static const String mode = 'mode';
  static const String macAddress = 'mac_address';
}

class Alat {
  String? id;
  String userID;
  String alatID;
  String role;
  final String namaAlat;
  final String owner;
  final int status;
  final String pwm;
  final int mode;
  final String macAddress;

  Alat({
    this.id,
    required this.userID,
    required this.alatID,
    required this.role,
    required this.owner,
    required this.namaAlat,
    required this.status,
    required this.pwm,
    required this.mode,
    required this.macAddress
  });

  factory Alat.fromJson(Map<String, dynamic> json) {
    try {
      final jsonData = Alat(
        id: json[AlatFields.id] as String,
        userID: json[AlatFields.userID] as String,
        alatID: json[AlatFields.alatID] as String,
        role: json[AlatFields.role] as String,
        namaAlat: json[AlatFields.namaAlat] as String,
        owner: json[AlatFields.owner] as String,
        status: json[AlatFields.status] as int,
        pwm: json[AlatFields.pwm] as String,
        mode: json[AlatFields.mode] as int,
        macAddress: json[AlatFields.macAddress] as String,
      );

      return jsonData;
    } catch (e) {
      throw Exception('Error in creating alat: ' + e.toString());
    }
  }

  Map<String, dynamic> toJson() {
    return {
      AlatFields.id: id,
      AlatFields.userID: userID,
      AlatFields.alatID: alatID,
      AlatFields.role: role,
      AlatFields.owner: owner,
      AlatFields.namaAlat: namaAlat,
      AlatFields.status: status,
      AlatFields.pwm: pwm,
      AlatFields.mode: mode,
      AlatFields.macAddress: macAddress,
    };
  }
}

class AlatList {
  List<Alat> alatList;

  AlatList({required this.alatList});

  factory AlatList.fromJson(List<dynamic> json) {
    List<Alat> alatList = <Alat>[];
    alatList = json.map((i) => Alat.fromJson(i)).toList();

    return AlatList(alatList: alatList);
  }

  List<Map<String, dynamic>> toJson() {
    List<Map<String, dynamic>> result = <Map<String, dynamic>>[];
    for (var element in alatList) {
      result.add(element.toJson());
    }

    return result;
  }
}