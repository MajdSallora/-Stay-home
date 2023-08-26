import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class CartModel {
  final String name;
  final int quantity;
  final String imageUrl;
  CartModel({
    required this.name,
    required this.quantity,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'quantity': quantity,
      'imageUrl': imageUrl,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      name: map['name'] as String,
      quantity: map['quantity'] as int,
      imageUrl: map['imageUrl'] as String,
    );
  }
}
