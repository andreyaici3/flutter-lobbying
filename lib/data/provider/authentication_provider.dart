import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:lobbying/const/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationProvider with ChangeNotifier {
  Future<void> setToken(String token, String name) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', token);
      prefs.setString("name", name);
    } catch (e) {}
  }

  Future<dynamic> login(String email, String password) async {
    final dio = Dio();
    try {
      var body = {
        "email": email,
        "password": password,
      };
      final response = await dio.post(Config.URL_LOGIN, data: jsonEncode(body));
      return response;
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response?.statusCode == 403) {
          return e.response;
        }
      } else {
        return e.response;
      }
    }
  }
}
