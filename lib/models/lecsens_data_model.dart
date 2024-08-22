const String tableLecsensData = 'lecsens_data';

class LecsensDataFields {
  static final List<String> values = [
    id, alatID, userID, lokasi, epc, ipc, ipa, epa, predictionA, predictionB, predictionC, predictionD, predictionE, predictionF, predictionG];

  static const String id = 'id';
  static const String alatID = 'alatID';
  static const String userID = 'userID';
  static const String lokasi = 'lokasi';
  static const String epc = 'EPC';
  static const String ipc = 'IPC';
  static const String ipa = 'IPA';
  static const String epa = 'EPA';
  static const String predictionA = 'Prediction_A';
  static const String predictionB = 'Prediction_B';
  static const String predictionC = 'Prediction_C';
  static const String predictionD = 'Prediction_D';
  static const String predictionE = 'Prediction_E';
  static const String predictionF = 'Prediction_F';
  static const String predictionG = 'Prediction_G';
}

class LecsensData {
  String? id;
  final String alatID;
  final String userID;
  final String lokasi;
  final double epc;
  final double ipc;
  final double ipa;
  final double epa;
  final double predictionA;
  final double predictionB;
  final double predictionC;
  final double predictionD;
  final double predictionE;
  final double predictionF;
  final double predictionG;

  LecsensData({
    this.id,
    required this.alatID,
    required this.userID,
    required this.lokasi,
    required this.epc,
    required this.ipc,
    required this.ipa,
    required this.epa,
    required this.predictionA,
    required this.predictionB,
    required this.predictionC,
    required this.predictionD,
    required this.predictionE,
    required this.predictionF,
    required this.predictionG,
  });

  factory LecsensData.fromJson(Map<String, dynamic> json) {
    return LecsensData(
      id: json[LecsensDataFields.alatID] as String,
      alatID: json[LecsensDataFields.alatID] as String,
      userID: json[LecsensDataFields.userID] as String,
      lokasi: json[LecsensDataFields.lokasi] as String,
      epc: json[LecsensDataFields.epc] as double,
      ipc: json[LecsensDataFields.ipc] as double,
      ipa: json[LecsensDataFields.ipa] as double,
      epa: json[LecsensDataFields.epa] as double,
      predictionA: json[LecsensDataFields.predictionA] as double,
      predictionB: json[LecsensDataFields.predictionB] as double,
      predictionC: json[LecsensDataFields.predictionC] as double,
      predictionD: json[LecsensDataFields.predictionD] as double,
      predictionE: json[LecsensDataFields.predictionE] as double,
      predictionF: json[LecsensDataFields.predictionF] as double,
      predictionG: json[LecsensDataFields.predictionG] as double,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      LecsensDataFields.id: id,
      LecsensDataFields.alatID: alatID,
      LecsensDataFields.userID: userID,
      LecsensDataFields.lokasi: lokasi,
      LecsensDataFields.epc: epc,
      LecsensDataFields.ipc: ipc,
      LecsensDataFields.ipa: ipa,
      LecsensDataFields.epa: epa,
      LecsensDataFields.predictionA: predictionA,
      LecsensDataFields.predictionB: predictionB,
      LecsensDataFields.predictionC: predictionC,
      LecsensDataFields.predictionD: predictionD,
      LecsensDataFields.predictionE: predictionE,
      LecsensDataFields.predictionF: predictionF,
      LecsensDataFields.predictionG: predictionG,
    };
  }
}

class LecsensList {
  List<LecsensData> lecsensList;

  LecsensList({
    required this.lecsensList,
  });

  factory LecsensList.fromJson(List<dynamic> json) {
    List<LecsensData> lecsensList = <LecsensData>[];
    lecsensList = json.map((e) => LecsensData.fromJson(e)).toList();
    return LecsensList(lecsensList: lecsensList);
  }

  List<Map<String, dynamic>> toJson() {
    return lecsensList.map((e) => e.toJson()).toList();
  }
}