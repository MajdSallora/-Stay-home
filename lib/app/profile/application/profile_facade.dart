// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:driver_project/app/profile/domain/entities/profile_param.dart';
import 'package:driver_project/app/profile/domain/profile_repo/profile_repo.dart';
import 'package:driver_project/app/profile/inrastructure/model/vehicle_type.dart';
import 'package:either_dart/either.dart';

class ProfileFacade {
  final ProfileRepo remote;
  ProfileFacade({
    required this.remote,
  });

  Future<Either<String, bool>> modifyProfile(ProfileParam profileParam) async => await remote.modifyProfile(profileParam);
  Future<Either<String, List<VehicleType>>> getAllVehiclType() => remote.getAllVehiclType();
}
