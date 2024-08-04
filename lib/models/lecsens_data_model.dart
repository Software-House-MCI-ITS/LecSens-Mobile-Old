import 'dart:ffi';

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
  static const String predictionA = 'Prediction A';
  static const String predictionB = 'Prediction B';
  static const String predictionC = 'Prediction C';
  static const String predictionD = 'Prediction D';
  static const String predictionE = 'Prediction E';
  static const String predictionF = 'Prediction F';
  static const String predictionG = 'Prediction G';
}

class LecsensData {
  int? id;
  int? alatID;
  int? userID;
  String? lokasi;
  double? epc;
  double? ipc;
  double? ipa;
  double? epa;
  double? predictionA;
  double? predictionB;
  double? predictionC;
  double? predictionD;
  double? predictionE;
  double? predictionF;
  double? predictionG;

  LecsensData({
    this.id,
    this.alatID,
    this.userID,
    this.lokasi,
    this.epc,
    this.ipc,
    this.ipa,
    this.epa,
    this.predictionA,
    this.predictionB,
    this.predictionC,
    this.predictionD,
    this.predictionE,
    this.predictionF,
    this.predictionG,
  });

  factory LecsensData.fromJson(Map<String, dynamic> json) {
    return LecsensData(
      id: json['id'],
      alatID: json['alatID'],
      userID: json['userID'],
      lokasi: json['lokasi'],
      epc: json['epc'],
      ipc: json['ipc'],
      ipa: json['ipa'],
      epa: json['epa'],
      predictionA: json['predictionA'],
      predictionB: json['predictionB'],
      predictionC: json['predictionC'],
      predictionD: json['predictionD'],
      predictionE: json['predictionE'],
      predictionF: json['predictionF'],
      predictionG: json['predictionG'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'alatID': alatID,
      'userID': userID,
      'lokasi': lokasi,
      'epc': epc,
      'ipc': ipc,
      'ipa': ipa,
      'epa': epa,
      'predictionA': predictionA,
      'predictionB': predictionB,
      'predictionC': predictionC,
      'predictionD': predictionD,
      'predictionE': predictionE,
      'predictionF': predictionF,
      'predictionG': predictionG,
    };
  }
}