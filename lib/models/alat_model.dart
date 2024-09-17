const String tableAlat = 'alat';

class AlatFields {
  static final List<String> values = [
    id, owner, namaAlat, status, pwm, mode, macAddress];

  static const String id = 'id';
  static const String owner = 'owner';
  static const String namaAlat = 'namaAlat';
  static const String status = 'status';
  static const String pwm = 'PWM';
  static const String mode = 'mode';
  static const String macAddress = 'macAddress';
  static const String createdAt = 'created_at';
  static const String updatedAt = 'updated_at';
}

class Alat {
  String? id;
  final String owner;
  final String namaAlat;
  final int status;
  final String pwm;
  final int mode;
  final String macAddress;
  final String createdAt;
  final String updatedAt;

  Alat({
    this.id,
    required this.owner,
    required this.namaAlat,
    required this.status,
    required this.pwm,
    required this.mode,
    required this.macAddress,
    required this.createdAt,
    required this.updatedAt
  });

  factory Alat.fromJson(Map<String, dynamic> json) {
    return Alat(
      id: json[AlatFields.id] as String,
      owner: json[AlatFields.owner] as String,
      namaAlat: json[AlatFields.namaAlat] as String,
      status: json[AlatFields.status] as int,
      pwm: json[AlatFields.pwm] as String,
      mode: json[AlatFields.mode] as int,
      macAddress: json[AlatFields.macAddress] as String,
      createdAt: json[AlatFields.createdAt] as String,
      updatedAt: json[AlatFields.updatedAt] as String
    );
  }

  Map<String, dynamic> toJson() {
    return {
      AlatFields.id: id,
      AlatFields.owner: owner,
      AlatFields.namaAlat: namaAlat,
      AlatFields.status: status,
      AlatFields.pwm: pwm,
      AlatFields.mode: mode,
      AlatFields.macAddress: macAddress,
      AlatFields.createdAt: createdAt,
      AlatFields.updatedAt: updatedAt
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