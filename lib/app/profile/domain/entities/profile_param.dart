import 'dart:convert';

import 'package:driver_project/common/core/user/entities/vehicle.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProfileParam {
  final String fullName;
  final String email;
  final String phoneNumber;
  final DateTime birthDate;
  final Vehicle vehicle;

  ProfileParam({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.birthDate,
    required this.vehicle,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'birthDate': birthDate.toIso8601String(),
      'Vehicle.VehicleTypeId': vehicle.toMap()['vehicleTypeId'],
      'Vehicle.Color': vehicle.toMap()['color'],
      'Vehicle.Number': vehicle.toMap()['number'],
      'Vehicle.Name': vehicle.toMap()['name'],
      'Vehicle.ImageFile': vehicle.toMap()['imageFile'],
      'Vehicle.MaxCapacity': vehicle.toMap()['maxCapacity'],
    };
  }
}
