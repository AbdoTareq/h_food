import 'package:dartz/dartz.dart';
import 'package:elm_task/core/error/failures.dart';

abstract class AuthRepo {
  Future<Either<Failure, bool>> login(String email);
}
