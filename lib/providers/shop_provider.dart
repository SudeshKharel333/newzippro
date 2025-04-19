import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../constants/api.dart';
import '../main.dart';

class StoreProvider {
  Dio _dio = Dio();
  late BaseOptions baseOptions;

  StoreProvider() {
    setUpOptions();
  }

  setUpOptions() {
    baseOptions = BaseOptions(
      headers: {"Accept": "application/json"},
      baseUrl: apiStoreBaseUrl,
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

  Future<dynamic> getCategories() async {
    try {
      final response = await _dio.get('categorys');
      return response;
    } catch (e) {
      return Response(statusCode: 500, requestOptions: RequestOptions());
    }
  }

  Future<dynamic> getSubCategories(int catId) async {
    try {
      final response = await _dio.get('subcategorys', queryParameters: {
        "category_id": catId,
      });
      return response;
    } catch (e) {
      return Response(statusCode: 500, requestOptions: RequestOptions());
    }
  }
  // latestproducts

  Future<dynamic> getLatestProducts() async {
    try {
      final response = await _dio.get('latestproducts');
      return response;
    } catch (e) {
      return Response(statusCode: 500, requestOptions: RequestOptions());
    }
  }

  // @GET("productbycategory")
  // @Query("category_id")
}
