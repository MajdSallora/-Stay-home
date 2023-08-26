// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:driver_project/app/login/infrastructure/data_source/local/auth_local.dart';
import 'package:driver_project/app/profile/domain/entities/profile_param.dart';
import 'package:driver_project/app/profile/inrastructure/model/vehicle_type.dart';
import 'package:driver_project/common/constant/src/url.dart';
import 'package:driver_project/common/core/network/exception/error_handler.dart';
import 'package:driver_project/common/core/user/entities/vehicle.dart';
import 'package:driver_project/common/helper/colered_print.dart';
import 'package:driver_project/common/injection/injection.dart';
import 'package:either_dart/either.dart';

class ProfileRemote {
  final Dio _dio;
  ProfileRemote({
    required Dio dio,
  }) : _dio = dio;

  Future<bool> modify(ProfileParam profileParam) async {
    return throwDioException(() async {
      Map<String, dynamic> jsonProfile = profileParam.toMap();
      File file = File(jsonProfile['Vehicle.ImageFile']);
      printR(jsonProfile['Vehicle.ImageFile']);
      if (file.existsSync()) {
        jsonProfile.addAll({"Vehicle.ImageFile": await MultipartFile.fromFile(file.path)});
      } else {
        jsonProfile.addAll({'Vehicle.ImageFile': null});
      }
      var response = await _dio.post(
        AppUrl.modify,
        data: FormData.fromMap(jsonProfile),
      );
      getIt<AuthLocal>().setUser(getIt<AuthLocal>().getUser()!.copyWith(vehicle: Vehicle.fromMap(response.data['response']['vehicle'])));
      return true;
    });
  }

  Future<List<VehicleType>> getAllVehicleType() async {
    return throwDioException(() async {
      final response = await _dio.get(
        AppUrl.getAllVehicleTypes,
      );
      return (response.data['response'] as List).map((e) => VehicleType.fromMap(e)).toList();
    });
  }
}
