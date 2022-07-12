import 'dart:io';

import 'package:dio/dio.dart';

class ApiService {
  static String apiBaseUrl = 'Api in dev';
  dynamic profilPhoto = '';
  final dio = Dio();

  Future<String?> fetchProfilPage({required String userName}) async {
    final response = await dio.get('$apiBaseUrl$userName');
    profilPhoto = response.toString();
    if (response.statusCode == HttpStatus.ok) {
      final responseBody = response.data;
      if (responseBody is String) {
        return responseBody;
      }
    }
    return null;
  }
}
