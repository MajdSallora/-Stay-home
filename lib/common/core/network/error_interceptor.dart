import 'dart:io';

import 'package:dio/dio.dart';
import 'package:driver_project/common/core/network/exception/app_exception.dart';
import 'package:driver_project/common/imports/imports.dart';

class ErrorInterceptor extends Interceptor {
  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    printR(err);
    if (err.error is SocketException) {
      err.error = AppException.known("لا يوجد إتصال في الانترنت");
      handler.next(err);
    } else if (err.response.toString().isNotEmpty && err.response?.data?["message"] != null) {
      if (err.response?.data?["message"].contains("user not found") || err.response?.data?["message"].contains("Email or Password Wrong")) {
        err.error = AppException.known("يرجى إدخال بريد إلكتروني وكلمة مرور صحيحين");
        handler.reject(err);
      } else if (err.response?.data?["message"].contains("Email is not exist")) {
        err.error = AppException.known("يرجى إدخال بريد إلكتروني صحيح");
        handler.reject(err);
      } else if (err.response?.data?["message"].contains("Wrong code")) {
        err.error = AppException.known("يرجى إدخال رمز صحيح، يرجى إدخال رمز صحيح");
        handler.reject(err);
      }else if (err.response?.data?["message"].contains("You already have an order being delivered")) {
        err.error = AppException.known("لديك رحلة قيد التوصيل بالفعل");
        handler.reject(err);
      } else {
        err.error = AppException.known('Please Try Again Later');
        handler.reject(err);
      }
    } else if (err.type == DioErrorType.connectTimeout || err.type == DioErrorType.sendTimeout || err.type == DioErrorType.receiveTimeout) {
      err.error = AppException.known('no interntet connection');
      handler.reject(err);
    } else if (err.type == DioErrorType.response && err.response?.statusCode == 500) {
      err.error = AppException.known('please try again later');
      handler.next(err);
    } else if (err.type == DioErrorType.response) {
      var data = err.response?.data;
      err.error = data is String ? AppException.known(data) : AppException.unknown();
      handler.next(err);
    } else {
      err.error = AppException.unknown();
      handler.next(err);
    }
  }
}
