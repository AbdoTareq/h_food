import 'package:dartz/dartz.dart';
import 'package:h_food/features/info/domain/repositories/auth_repo.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';

class SaveInfoUsecase implements UseCase<num, InfoParams> {
  final InfoRepo repository;

  SaveInfoUsecase(this.repository);

  @override
  Future<Either<Failure, num>> call(InfoParams params) async {
    return await repository.calculateCalories(
        params.weight, params.height, params.age, params.gender);
  }
}

class InfoParams extends Equatable {
  final num weight;
  final num height;
  final num age;
  final String gender;

  const InfoParams(
      {required this.weight,
      required this.height,
      required this.age,
      required this.gender});

  @override
  List<Object> get props => [weight, height, age];
}
