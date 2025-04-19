import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../constants/api.dart';
import '../main.dart';

import '../models/shop_response.dart';

class SliderProvider {
  Dio _dio = Dio();
  late BaseOptions baseOptions;

  SliderProvider() {
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

  Future<dynamic> getSlider() async {
    try {
      final response = await _dio.get('sliders');
      return response;
    } catch (e) {
      return Response(statusCode: 500, requestOptions: RequestOptions());
    }
  }

  //form data formate
  Future<dynamic> getSlider2(
      String name, String address, String contactNo) async {
    try {
      FormData formData;
      formData = FormData.fromMap({
        "name": name,
        "address": address,
        "contact": contactNo,
      });
      final response = await _dio.get('sliders', data: formData);
      return response;
    } catch (e) {
      return Response(statusCode: 500, requestOptions: RequestOptions());
    }
  }

  //form json

  Future<dynamic> getSlider3(
      String name, String address, String contactNo) async {
    try {
      String json = "{\"name\":\"" +
          name +
          "\",\"address\":\"" +
          address +
          "\",\"contact\":\"" +
          contactNo +
          "\"}";
      Categories categories = Categories();
      // var json = Categories.toJson(categories);
      final response = await _dio.get('sliders', data: json);
      return response;
    } catch (e) {
      return Response(statusCode: 500, requestOptions: RequestOptions());
    }
  }

// @GET("productbycategory")
// Observable<List<ShopProducts>> loadShopCategoryProducts(@Query("category_id") Integer catID);
}
