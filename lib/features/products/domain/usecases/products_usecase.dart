import 'package:dartz/dartz.dart';
import 'package:elm_task/features/products/domain/entities/products.dart';
import 'package:elm_task/features/products/domain/repositories/products_repo.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

class ProductsUsecase implements UseCase<Products, NoParams> {
  final ProductsRepo repository;

  ProductsUsecase(this.repository);

  @override
  Future<Either<Failure, Products>> call(NoParams params) async {
    return await repository.getAllMeet();
  }

  Future<Either<Failure, Products>> getAllMeet() async {
    return await repository.getAllMeet();
  }

  Future<Either<Failure, Products>> getAllCarbs() async {
    return await repository.getAllCarbs();
  }

  Future<Either<Failure, Products>> getAllVegetables() async {
    return await repository.getAllVegetables();
  }

  Future<Either<Failure, Map<String, dynamic>>> makeOrder(
      Map<String, dynamic> data) async {
    return await repository.makeOrder(data);
  }
}
