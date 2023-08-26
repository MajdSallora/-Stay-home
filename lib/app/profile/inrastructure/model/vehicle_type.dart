import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class VehicleType {
  final String name;
  final String id;
  VehicleType({
    required this.name,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
    };
  }

  factory VehicleType.fromMap(Map<String, dynamic> map) {
    return VehicleType(
      name: map['name'] as String,
      id: map['id'] as String,
    );
  }
}
