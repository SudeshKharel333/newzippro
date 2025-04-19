import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../constants/api.dart';
import '../main.dart';

class AuthProvider {
  Dio _dio = Dio();
  late BaseOptions baseOptions;

  AuthProvider() {
    setUpOptions();
  }

  setUpOptions() {
    baseOptions = BaseOptions(
      headers: {"Accept": "application/json"},
      baseUrl: apiBaseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      validateStatus: (status) {
        return status! < 500;
      },
    );

    _dio = Dio(baseOptions);

    // if (kDebugMode) {
    //   _dio.interceptors
    //     ..add(LogInterceptor(requestBody: true))
    //     ..add(alice.getDioInterceptor());
    // }
  }

  Future<dynamic> login(
      String phone, String password, String fcmId, String deviceId) async {
    try {
      final response = await _dio.post('login', queryParameters: {
        "email": phone,
        "password": password,
        "device": "1234",
        "fcm_id": "1234"
      });
      return response;
    } catch (e) {
      return Response(statusCode: 500, requestOptions: RequestOptions());
    }
  }
}
