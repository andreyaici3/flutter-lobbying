// To parse this JSON data, do
//
//     final dataModel = dataModelFromJson(jsonString);

import 'dart:convert';

DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String dataModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel {
  bool success;
  String message;
  List<Datum> data;

  DataModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        success: json["success"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int id;
  String noPol;
  String noSuratJalan;
  String driver;
  int suhu;
  String? foto;
  DateTime createdAt;
  DateTime updatedAt;

  Datum({
    required this.id,
    required this.noPol,
    required this.noSuratJalan,
    required this.driver,
    required this.suhu,
    required this.foto,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
