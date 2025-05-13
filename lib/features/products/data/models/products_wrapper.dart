import 'package:elm_task/features/products/domain/entities/products.dart';

class ProductsWrapper extends Products {
  List<ProductModel>? data;

  ProductsWrapper({this.data, required super.products});

  factory ProductsWrapper.fromJson(Map<String, dynamic> json) =>
      ProductsWrapper(
        products: (json["data"] as List<dynamic>? ?? <dynamic>[])
            .map((x) => ProductModel.fromJson(x))
            .toList(),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductModel extends Product {
  ProductModel({
    required super.foodName,
    required super.calories,
    required super.imageUrl,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        foodName: json['food_name'],
        calories: json['calories'],
        imageUrl: json['image_url'],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['food_name'] = this.foodName;
    data['calories'] = this.calories;
    data['image_url'] = this.imageUrl;
    return data;
  }
}
