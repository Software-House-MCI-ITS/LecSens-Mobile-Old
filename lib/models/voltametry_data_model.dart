class VoltametryDataFields {
  static final List<String> values = [
    id, alatID, alamat, data_x, data_y, peak_x, peak_y
  ];

  static const String id = 'id';
  static const String alatID = 'alat_id';
  static const String alamat = 'alamat';
  static const String data_x = 'data_x';
  static const String data_y = 'data_y';
  static const String peak_x = 'peak_x';
  static const String peak_y = 'peak_y';
}

class VoltametryData {
  String? id;
  final String alatID;
  final String alamat;
  final List<double> data_x;
  final List<double> data_y;
  final List<double> peak_x;
  final List<double> peak_y;

  VoltametryData({
    this.id,
    required this.alatID,
    required this.alamat,
    required this.data_x,
    required this.data_y,
    required this.peak_x,
    required this.peak_y,
  });

  factory VoltametryData.fromJson(Map<String, dynamic> json) {
    return VoltametryData(
      id: json[VoltametryDataFields.id] as String,
      alatID: json[VoltametryDataFields.alatID] as String,
      alamat: json[VoltametryDataFields.alamat] as String,
      data_x: (json[VoltametryDataFields.data_x] as List<dynamic>).map<double>((e) => e.toDouble()).toList(),
      data_y: (json[VoltametryDataFields.data_y] as List<dynamic>).map<double>((e) => e.toDouble()).toList(),
      peak_x: (json[VoltametryDataFields.peak_x] as List<dynamic>).map<double>((e) => e.toDouble()).toList(),
      peak_y: (json[VoltametryDataFields.peak_y] as List<dynamic>).map<double>((e) => e.toDouble()).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      VoltametryDataFields.id: id,
      VoltametryDataFields.alatID: alatID,
      VoltametryDataFields.alamat: alamat,
      VoltametryDataFields.data_x: data_x,
      VoltametryDataFields.data_y: data_y,
      VoltametryDataFields.peak_x: peak_x,
      VoltametryDataFields.peak_y: peak_y,
    };
  }
}

class VoltametryDataList {
  List<VoltametryData> voltametryDataList;

  VoltametryDataList({
    required this.voltametryDataList,
  });

  factory VoltametryDataList.fromJson(List<dynamic> json) {
    List<VoltametryData> voltametryDataList = <VoltametryData>[];
    voltametryDataList = json.map((e) => VoltametryData.fromJson(e)).toList();
    return VoltametryDataList(voltametryDataList: voltametryDataList);
  }

  List<Map<String, dynamic>> toJson() {
    return voltametryDataList.map((e) => e.toJson()).toList();
  }
}
