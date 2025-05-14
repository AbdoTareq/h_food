import 'package:dio/dio.dart';
import 'package:h_food/core/datasources/secure_local_data_source.dart';
import 'package:h_food/core/network/network.dart';
import 'package:h_food/core/network/network_info.dart';
import 'package:h_food/export.dart';
import 'package:h_food/features/info/data/repositories/repo_imp.dart';
import 'package:h_food/features/info/domain/repositories/auth_repo.dart';
import 'package:h_food/features/info/domain/usecases/save_info_usecase.dart';
import 'package:h_food/features/info/presentation/bloc/info_details_bloc.dart';
import 'package:h_food/features/products/data/datasources/products_remote_data_source.dart';
import 'package:h_food/features/products/data/repositories/repo_imp.dart';
import 'package:h_food/features/products/domain/repositories/products_repo.dart';
import 'package:h_food/features/products/domain/usecases/products_usecase.dart';
import 'package:h_food/features/products/presentation/bloc/products_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:requests_inspector/requests_inspector.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features
  // Bloc
  sl.registerFactory(
    () => InfoDetailsBloc(infoUseCase: sl()),
  );
  sl.registerLazySingleton(
    () => ProductsBloc(productsUsecase: sl()),
  );
  // Usecases
  sl.registerLazySingleton(() => SaveInfoUsecase(sl()));
  sl.registerLazySingleton(() => ProductsUsecase(sl()));

  // Repository
  sl.registerLazySingleton<InfoRepo>(() => InfoRepoImp(
        remoteDataSource: sl(),
        networkInfo: sl(),
      ));

  sl.registerLazySingleton<ProductsRepo>(() => ProductsRepoImp(
        remoteDataSource: sl(),
        networkInfo: sl(),
      ));

  // Datasources
  sl.registerLazySingleton<InfoRemoteDataSource>(
      () => AuthRemoteDataSourceImp(network: sl()));

  sl.registerLazySingleton<ProductsRemoteDataSource>(
      () => ProductsRemoteDataSourceImp(network: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));
  sl.registerLazySingleton<NetworkInterface>(
      () => Network(dio: sl(), box: sl()));
  sl.registerLazySingleton(() => InternetConnectionChecker.instance);
  sl.registerLazySingleton(() => SecureLocalDataSourceImpl(box: sl()));
  sl.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(box: sl()));

  //! External
  sl.registerLazySingleton(() => GetStorage());
  sl.registerLazySingleton(() => const FlutterSecureStorage());
  sl.registerLazySingleton<Dio>(() => Dio(BaseOptions(
        connectTimeout: const Duration(seconds: 1000),
        receiveTimeout: const Duration(seconds: 1000),
        // By default, Dio treats any HTTP status code from 200 to 299 as a successful response. If you need a different range or specific conditions, you can override it using validateStatus.
        validateStatus: (status) {
          // Treat status codes less than 399 as successful
          return status != null && status < 399;
        },
      )));
  sl<Dio>().interceptors.addAll(
    [
      RequestsInspectorInterceptor(),
    ],
  );
}
