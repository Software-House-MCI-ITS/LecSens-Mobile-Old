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
}

class Alat {
  int? id;
  String? owner;
  String? namaAlat;
  int? status;
  String? pwm;
  int? mode;
  String? macAddress;

  Alat({
    this.id,
    this.owner,
    this.namaAlat,
    this.status,
    this.pwm,
    this.mode,
    this.macAddress,
  });

  factory Alat.fromJson(Map<String, dynamic> json) {
    return Alat(
      id: json['id'],
      owner: json['owner'],
      namaAlat: json['namaAlat'],
      status: json['status'],
      pwm: json['pwm'],
      mode: json['mode'],
      macAddress: json['macAddress'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'owner': owner,
      'namaAlat': namaAlat,
      'status': status,
      'pwm': pwm,
      'mode': mode,
      'macAddress': macAddress,
    };
  }
}