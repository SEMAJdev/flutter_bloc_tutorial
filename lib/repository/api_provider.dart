import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc_tutorial/models/users_model.dart';
class ApiProvider {
  final Dio _dio = Dio();

  Future<UserModel> fetchUserList() async {
    const String url = 'https://dummyjson.com/users?limit=5';
    try {
      Response response = await _dio.get(url);
      return UserModel.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return UserModel(users: []);
    }
  }
}