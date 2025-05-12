import 'package:elm_task/core/error/exceptions.dart';
import 'package:elm_task/core/network/endpoints.dart';
import 'package:elm_task/core/network/network.dart';
import 'package:elm_task/features/info/data/models/verify_model.dart';

abstract class AuthRemoteDataSource {
  Future<bool> login(String email);
}

class AuthRemoteDataSourceImp implements AuthRemoteDataSource {
  final NetworkInterface network;

  AuthRemoteDataSourceImp({required this.network});

  @override
  Future<bool> login(String email) async {
    final response = await network.post(Endpoints.placeOrder, {'email': email});
    if (response.statusCode == 200) {
      return true;
    }
    throw ServerException();
  }
}
