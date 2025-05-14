import 'package:dartz/dartz.dart';
import 'package:h_food/core/error/failures.dart';

abstract class InfoRepo {
  Future<Either<Failure, num>> calculateCalories(
      num weight, num height, num age, String gender);
}
