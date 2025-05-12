import 'package:elm_task/core/network/network_info.dart';
import 'package:elm_task/export.dart';

import '../../domain/repositories/auth_repo.dart';

class InfoRepoImp implements InfoRepo {
  final InfoRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  InfoRepoImp({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, num>> calculateCalories(
      num weight, num height, num age, String gender) async {
    try {
      final res =
          await remoteDataSource.calculateCalories(weight, height, age, gender);
      return Right(res);
    } catch (e) {
      return Left(ServerFailure(message: e.toString(), data: null));
    }
  }
}
