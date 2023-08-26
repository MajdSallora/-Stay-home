import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Vehicle {
  final String vehicleTypeId;
  final String color;
  final String number;
  final String name;
  final String imageFile;
  final int maxCapacity;
  Vehicle({
    required this.vehicleTypeId,
    required this.color,
    required this.number,
    required this.name,
    required this.imageFile,
    required this.maxCapacity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'vehicleTypeId': vehicleTypeId,
      'color': color,
      'number': number,
      'name': name,
      'imageFile': imageFile,
      'maxCapacity': maxCapacity,
    };
  }

  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
      vehicleTypeId: map['vehicleTypeId'] as String,
      color: map['color'] as String,
      number: map['number'] as String,
      name: map['name'] as String,
      imageFile: map['imageFile'] as String,
      maxCapacity: map['maxCapacity'] as int,
    );
  }

  Vehicle copyWith({
    String? vehicleTypeId,
    String? color,
    String? number,
    String? name,
    String? imageFile,
    int? maxCapacity,
  }) {
    return Vehicle(
      vehicleTypeId: vehicleTypeId ?? this.vehicleTypeId,
      color: color ?? this.color,
      number: number ?? this.number,
      name: name ?? this.name,
      imageFile: imageFile ?? this.imageFile,
      maxCapacity: maxCapacity ?? this.maxCapacity,
    );
  }
}
