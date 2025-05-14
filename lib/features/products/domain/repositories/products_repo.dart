import 'package:dartz/dartz.dart';
import 'package:h_food/core/error/failures.dart';
import 'package:h_food/features/products/domain/entities/products.dart';

abstract class ProductsRepo {
  Future<Either<Failure, Products>> getAllMeet();
  Future<Either<Failure, Products>> getAllCarbs();
  Future<Either<Failure, Products>> getAllVegetables();
  Future<Either<Failure, Map<String, dynamic>>> makeOrder(
      Map<String, dynamic> data);
}
