abstract class InfoRemoteDataSource {
  Future<num> calculateCalories(num weight, num height, num age, String gender);
}

class AuthRemoteDataSourceImp implements InfoRemoteDataSource {
  AuthRemoteDataSourceImp();

  @override
  Future<num> calculateCalories(
      num weight, num height, num age, String gender) async {
    if (gender == 'male') {
      return ((666.47) + (13.75 * weight) + (5 * height) - (6.75 * age));
    } else {
      return ((655.1) + (9.56 * weight) + (1.85 * height) - (4.67 * age));
    }
  }
}
