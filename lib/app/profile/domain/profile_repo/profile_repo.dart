import 'package:driver_project/app/profile/domain/entities/profile_param.dart';
import 'package:driver_project/app/profile/inrastructure/model/vehicle_type.dart';
import 'package:either_dart/either.dart';

abstract class ProfileRepo {
  Future<Either<String, bool>> modifyProfile(ProfileParam profileParam);
  Future<Either<String, List<VehicleType>>> getAllVehiclType();
}
