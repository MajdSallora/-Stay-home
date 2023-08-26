import 'package:driver_project/common/core/user/entities/vehicle.dart';
import 'package:driver_project/common/imports/imports.dart';

class User {
  final String id;
  final String fullName;
  final String accessToken;
  final String refreshToken;
  final String phoneNumber;
  final String email;
  final DateTime birthDate;
  final Vehicle vehicle;

  User({
    required this.fullName,
    required this.accessToken,
    required this.refreshToken,
    required this.id,
    required this.email,
    required this.birthDate,
    required this.phoneNumber,
    required this.vehicle,
  });

  @override
  String toString() {
    return 'User{id: $id, name: $fullName, accessToken: $accessToken, refreshToken: $refreshToken';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'birthDate': birthDate.toIso8601String(),
      'email': email,
      'phoneNumber': phoneNumber,
      'vehicle': vehicle.toMap(),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      fullName: map['fullName'] as String,
      accessToken: map['accessToken'] as String,
      refreshToken: map['refreshToken'] as String,
      birthDate: DateTime.parse(map['birthDate'] as String),
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] as String,
      vehicle: Vehicle.fromMap(map['vehicle']),
    );
  }

  User copyWith({
    String? accessToken,
    String? refreshToken,
    String? id,
    String? fullName,
    String? email,
    String? phoneNumber,
    DateTime? birthDate,
    Vehicle? vehicle,
  }) {
    return User(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      birthDate: birthDate ?? this.birthDate,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      vehicle: vehicle ?? this.vehicle,
    );
  }
}
