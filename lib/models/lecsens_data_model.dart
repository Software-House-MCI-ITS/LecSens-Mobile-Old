import 'dart:convert';

const String tableLecsensData = 'lecsens_data';

class LecsensDataFields {
  static final List<String> values = [
    id, alatID, alamat, data_x, data_y, user_id, epc, ipc, ipa, epa, peak_x, peak_y
  ];

  static const String id = 'id';
  static const String alatID = 'alat_id';
  static const String alamat = 'alamat';
  static const String data_x = 'data_x';
  static const String data_y = 'data_y';
  static const String user_id = 'user_id';
  static const String epc = 'epc';
  static const String ipc = 'ipc';
  static const String ipa = 'ipa';
  static const String epa = 'epa';
  static const String peak_x = 'peak_x';
  static const String peak_y = 'peak_y';
  static const String ppm = 'ppm';
  static const String label = 'label';
  static const String createdAt = 'created_at';
}

class LecsensData {
  String? id;
  final String alatID;
  final String alamat;
  final List<double> data_x;
  final List<double> data_y;
  final String userID;
  final int epc;
  final int ipc;
  final int ipa;
  final int epa;
  final List<double> peak_x;
  final List<double> peak_y;
  final int ppm;
  final String label;
  final String createdAt;

  LecsensData({
    this.id,
    required this.alatID,
    required this.alamat,
    required this.data_x,
    required this.data_y,
    required this.userID,
    required this.epc,
    required this.ipc,
    required this.ipa,
    required this.epa,
    required this.peak_x,
    required this.peak_y,
    required this.ppm,
    required this.label,
    required this.createdAt
  });

  factory LecsensData.fromJson(Map<String, dynamic> json) {
    try {
      final data = LecsensData(
        id: json[LecsensDataFields.id] as String,
        alatID: json[LecsensDataFields.alatID] as String,
        alamat: json[LecsensDataFields.alamat] as String,
        data_x: (json[LecsensDataFields.data_x] as List<dynamic>).map<double>((e) => e.toDouble()).toList(),
        data_y: (json[LecsensDataFields.data_y] as List<dynamic>).map<double>((e) => e.toDouble()).toList(),
        userID: json[LecsensDataFields.user_id] as String,
        epc: json[LecsensDataFields.epc] as int,
        ipc: json[LecsensDataFields.ipc] as int,
        ipa: json[LecsensDataFields.ipa] as int,
        epa: json[LecsensDataFields.epa] as int,
        peak_x: (json[LecsensDataFields.peak_x] as List<dynamic>).map<double>((e) => e.toDouble()).toList(),
        peak_y: (json[LecsensDataFields.peak_y] as List<dynamic>).map<double>((e) => e.toDouble()).toList(),
        ppm: json[LecsensDataFields.ppm] as int,
        label: json[LecsensDataFields.label] as String,
        createdAt: json[LecsensDataFields.createdAt] as String,
      );
      return data;
    } catch (e) {
      print(e);
      throw Exception('Error in parsing LecsensData');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      LecsensDataFields.id: id,
      LecsensDataFields.alatID: alatID,
      LecsensDataFields.alamat: alamat,
      LecsensDataFields.data_x: jsonEncode(data_x),
      LecsensDataFields.data_y: jsonEncode(data_y),
      LecsensDataFields.user_id: userID,
      LecsensDataFields.epc: epc,
      LecsensDataFields.ipc: ipc,
      LecsensDataFields.ipa: ipa,
      LecsensDataFields.epa: epa,
      LecsensDataFields.peak_x: jsonEncode(peak_x),
      LecsensDataFields.peak_y: jsonEncode(peak_y),
      LecsensDataFields.ppm: ppm,
      LecsensDataFields.label: label,
      LecsensDataFields.createdAt: createdAt,
    };
  }
}

class LecsensDataList {
  List<LecsensData> lecsensDataList;

  LecsensDataList({
    required this.lecsensDataList,
  });

  factory LecsensDataList.fromJson(List<dynamic> json) {
    List<LecsensData> lecsensDataList = <LecsensData>[];
    lecsensDataList = json.map((e) => LecsensData.fromJson(e)).toList();
    return LecsensDataList(lecsensDataList: lecsensDataList);
  }

  List<Map<String, dynamic>> toJson() {
    return lecsensDataList.map((e) => e.toJson()).toList();
  }

  List<LecsensData> getTimbalData() {
    return lecsensDataList.where((element) => element.label.toLowerCase() == 'timbal').toList();
  }

  List<LecsensData> getKadmiumData() {
    return lecsensDataList.where((element) => element.label.toLowerCase() == 'kadmium').toList();
  }

  List<LecsensData> getMikroplastikData() {
    return lecsensDataList.where((element) => element.label.toLowerCase() == 'mikroplastik' || element.label.toLowerCase() == 'microplastic').toList();
  }

  List<LecsensData> getMerkuriData() {
    return lecsensDataList.where((element) => element.label.toLowerCase() == 'merkuri').toList();
  }

  List<LecsensData> getArsenData() {
    return lecsensDataList.where((element) => element.label.toLowerCase() == 'arsen').toList();
  }

  LecsensData getLatestData() {
    return lecsensDataList.first;
  }

  List<LecsensData> getLecsensDataByDate(String date) {
    return lecsensDataList.where((element) => element.createdAt.startsWith(date)).toList();
  }
}
