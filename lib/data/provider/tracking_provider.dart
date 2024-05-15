import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lobbying/const/config.dart';
import 'package:lobbying/data/model/data_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TrackingProvider with ChangeNotifier {
  DataModel? data = null;
  String nama = "nama";
  Future<String> getToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('token') as String;
    } catch (e) {
      return "error";
    }
  }

  Future<String> getNama() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString('name') as String;
    } catch (e) {
      return "error";
    }
  }

  Future<dynamic> getData() async {
    final dio = Dio();
    var dataModel = null;
    try {
      String token = await getToken();
      final response = await dio.get(Config.URL_GET_DATA,
          data: data,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));
      dataModel = DataModel.fromJson(response.data);
      data = dataModel;
      notifyListeners();
    } on DioException catch (e) {
      if (e.response != null) {
      } else {
        // print(e.response);
      }
    }

    return dataModel;
  }

  Future<dynamic> storeData(Map<String, dynamic> data) async {
    final dio = Dio();

    try {
      String token = await getToken();
      final response = await dio.post(Config.URL_STORE_DATA,
          data: data,
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response?.statusCode;
      } else {
        print(e.response?.data);
      }
    }
  }

  Future<dynamic> getDataById(id) async {
    final dio = Dio();
    try {
      String token = await getToken();
      final response = await dio.get(Config.URL_GET_DATA_BY_id + id.toString(),
          options: Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          }));
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response?.statusCode;
      } else {
        // print(e.response?.data);
      }
    }
  }

  Future<dynamic> updateData(File file, String id, String suhu) async {
    var formData = FormData.fromMap({
      'gambar': await MultipartFile.fromFile(file.path),
      "_method": "PUT",
      "suhu": suhu,
    });
    Dio dio = Dio();
    try {
      String token = await getToken();
      final response = await dio.post(
        Config.URL_UPDATE_DATA + id,
        data: formData,
        options: Options(headers: {
          "Content-Type": "multipart/form-data",
          "Authorization": "Bearer $token",
        }),
      );
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response?.statusCode;
      } else {
        // print(e.response?.data);
      }
    }
  }

  Future<dynamic> deleteData(String id) async {
    Dio dio = Dio();
    try {
      String token = await getToken();
      final response = await dio.delete(
        Config.URL_DELETE_DATA + id,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        }),
      );
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        return e.response?.statusCode;
      } else {
        // print(e.response?.data);
      }
    }
  }
}
