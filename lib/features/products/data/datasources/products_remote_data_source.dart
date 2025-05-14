import 'package:h_food/core/error/exceptions.dart';
import 'package:h_food/core/network/endpoints.dart';
import 'package:h_food/core/network/network.dart';
import 'package:h_food/features/products/data/models/products_wrapper.dart';

abstract class ProductsRemoteDataSource {
  Future<ProductsWrapper> getAllMeet();
  Future<ProductsWrapper> getAllCarbs();
  Future<ProductsWrapper> getAllVegetables();
  Future<Map<String, dynamic>> makeOrder(Map<String, dynamic> data);
}

class ProductsRemoteDataSourceImp implements ProductsRemoteDataSource {
  final NetworkInterface network;

  ProductsRemoteDataSourceImp({required this.network});

  @override
  Future<ProductsWrapper> getAllMeet() async {
    final response = await network.get(Endpoints.meat, {});
    if (response.statusCode == 200) {
      return ProductsWrapper.fromJson({"data": response.data});
    } else {
      throw ServerException(message: "Error");
    }
  }

  @override
  Future<ProductsWrapper> getAllCarbs() async {
    final response = await network.get(Endpoints.carbs, {});
    if (response.statusCode == 200) {
      return ProductsWrapper.fromJson({"data": response.data});
    } else {
      throw ServerException(message: "Error");
    }
  }

  @override
  Future<ProductsWrapper> getAllVegetables() async {
    final response = await network.get(Endpoints.vegetables, {});
    if (response.statusCode == 200) {
      return ProductsWrapper.fromJson({"data": response.data});
    } else {
      throw ServerException(message: "Error");
    }
  }

  @override
  Future<Map<String, dynamic>> makeOrder(Map<String, dynamic> data) async {
    final response = await network.post(Endpoints.placeOrder, data);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw ServerException(message: "Error");
    }
  }
}
