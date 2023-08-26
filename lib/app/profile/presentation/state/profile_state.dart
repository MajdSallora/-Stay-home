// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_bloc.dart';

class ProfileState {
  final Result<List<VehicleType>> vehicleType;
  ProfileState({
    this.vehicleType = const Result.init(),
  });

  ProfileState copyWith({
    Result<List<VehicleType>>? vehicleType,
  }) {
    return ProfileState(
      vehicleType: vehicleType ?? this.vehicleType,
    );
  }
}
