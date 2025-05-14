// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Products {
  final List<Product> products;

  Products({required this.products});
}

class Product extends Equatable {
  final String foodName;
  final int calories;
  final int price;
  final int quantity;
  final String imageUrl;

  Product({
    required this.foodName,
    required this.calories,
    required this.imageUrl,
    this.price = 12,
    this.quantity = 1,
  });

  Product copyWith({
    String? foodName,
    int? calories,
    int? price,
    int? quantity,
    String? imageUrl,
  }) {
    return Product(
      foodName: foodName ?? this.foodName,
      calories: calories ?? this.calories,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  List<Object?> get props => [
        foodName,
        calories,
      ];
}
