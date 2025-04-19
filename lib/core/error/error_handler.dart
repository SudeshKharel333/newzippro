import 'dart:io';

import 'package:dio/dio.dart';

class GetDioErrors {
  static String getDioError(error) {
    late String errorMsg;
    if (error is Exception) {
      if (error is DioError) {
        switch (error.type) {
          case DioErrorType.connectionTimeout:
            errorMsg = "Connection timeout";
            break;
          case DioErrorType.sendTimeout:
            errorMsg = "Request timeout";
            break;
          case DioErrorType.receiveTimeout:
            errorMsg = "Response timeout";
            break;
          case DioErrorType.badResponse:
            switch (error.response!.statusCode) {
              case 400:
                errorMsg = "Error Occured with status 400";

                break;
              case 401:
                errorMsg = "Error Occured with status 401";
                break;
              case 403:
                errorMsg = "Error Occured with status 403";
                break;
              case 404:
                errorMsg = "Error Occured with status 404";
                break;
              case 409:
                errorMsg = "Error Occured with status 409";
                break;
              case 408:
                errorMsg = "Error Occured with status 408";
                break;
              case 422:
                errorMsg = "Error Occured with status 422";
                break;
              case 500:
                errorMsg = "Error Occured with status 500";
                break;
              case 503:
                errorMsg = "Error Occured with status 503";
                break;
              default:
                errorMsg = "Unable to complete the task";
            }
            break;

          case DioErrorType.cancel:
            errorMsg = "Request Canclled";
            break;
          default:
            errorMsg = "Unable to complete the task";
            break;
        }
      }
    } else if (error is SocketException) {
      errorMsg = "Please check your internet connection";
    } else {
      errorMsg = "An unexpected error has occured";
    }

    return errorMsg;
  }
}
