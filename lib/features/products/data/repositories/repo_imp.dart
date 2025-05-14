import 'package:dartz/dartz.dart';
import 'package:h_food/core/error/exceptions.dart';
import 'package:h_food/core/error/failures.dart';
import 'package:h_food/core/network/network_info.dart';
import 'package:h_food/features/products/data/datasources/products_remote_data_source.dart';
import 'package:h_food/features/products/domain/entities/products.dart';
import 'package:h_food/features/products/domain/repositories/products_repo.dart';

class ProductsRepoImp implements ProductsRepo {
  final ProductsRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ProductsRepoImp({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Products>> getAllMeet() async {
    if (await networkInfo.isConnected) {
      try {
        final res = await remoteDataSource.getAllMeat();
        return Right(res);
      } on ServerException {
        return Left(ServerFailure(message: 'server failure', data: null));
      }
    } else {
      return const Left(
          OfflineFailure(message: 'please connect to internet', data: null));
    }
  }

  @override
  Future<Either<Failure, Products>> getAllCarbs() async {
    if (await networkInfo.isConnected) {
      try {
        final res = await remoteDataSource.getAllCarbs();
        return Right(res);
      } on ServerException {
        return Left(ServerFailure(message: 'server failure', data: null));
      }
    } else {
      return const Left(
          OfflineFailure(message: 'please connect to internet', data: null));
    }
  }

  @override
  Future<Either<Failure, Products>> getAllVegetables() async {
    if (await networkInfo.isConnected) {
      try {
        final res = await remoteDataSource.getAllVegetables();
        return Right(res);
      } on ServerException {
        return Left(ServerFailure(message: 'server failure', data: null));
      }
    } else {
      return const Left(
          OfflineFailure(message: 'please connect to internet', data: null));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> makeOrder(
      Map<String, dynamic> data) async {
    if (await networkInfo.isConnected) {
      try {
        final res = await remoteDataSource.makeOrder(data);
        return Right(res);
      } on ServerException {
        return Left(ServerFailure(message: 'server failure', data: null));
      }
    } else {
      return const Left(
          OfflineFailure(message: 'please connect to internet', data: null));
    }
  }
}
