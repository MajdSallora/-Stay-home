// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:driver_project/app/profile/domain/entities/profile_param.dart';
import 'package:driver_project/app/profile/inrastructure/model/vehicle_type.dart';
import 'package:either_dart/src/either.dart';

import 'package:driver_project/app/profile/domain/profile_repo/profile_repo.dart';
import 'package:driver_project/app/profile/inrastructure/date_source/profile_remote.dart';
import 'package:driver_project/common/core/network/exception/error_handler.dart';

class ProfileRepoImpl extends ProfileRepo {
  final ProfileRemote remote;
  ProfileRepoImpl({
    required this.remote,
  });

  @override
  Future<Either<String, bool>> modifyProfile(ProfileParam profileParam) {
    return throwAppException(() async {
      await remote.modify(profileParam);
      return true;
    });
  }

  @override
  Future<Either<String, List<VehicleType>>> getAllVehiclType() {
    return throwAppException(() async {
      final response = await remote.getAllVehicleType();
      return response;
    });
  }
}
