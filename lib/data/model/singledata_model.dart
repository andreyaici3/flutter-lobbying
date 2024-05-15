// To parse this JSON data, do
//
//     final singleDataModel = singleDataModelFromJson(jsonString);

import 'dart:convert';

SingleDataModel singleDataModelFromJson(String str) =>
    SingleDataModel.fromJson(json.decode(str));

String singleDataModelToJson(SingleDataModel data) =>
    json.encode(data.toJson());

class SingleDataModel {
  bool success;
  String message;
  Data data;

  SingleDataModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory SingleDataModel.fromJson(Map<String, dynamic> json) =>
      SingleDataModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  int id;
  String noPol;
  String noSuratJalan;
  String driver;
  int suhu;
  dynamic foto;
  DateTime createdAt;
  DateTime updatedAt;

  Data({
    required this.id,
    required this.noPol,
    required this.noSuratJalan,
    required this.driver,
    required this.suhu,
    required this.foto,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        noPol: json["no_pol"],
        noSuratJalan: json["no_surat_jalan"],
        driver: json["driver"],
        suhu: json["suhu"],
        foto: json["foto"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "no_pol": noPol,
        "no_surat_jalan": noSuratJalan,
        "driver": driver,
        "suhu": suhu,
        "foto": foto,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
