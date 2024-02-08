import 'dart:async';

import 'package:flutter_login/features/login/data/datasource/datasources.dart';
import 'package:flutter_login/features/login/data/repositories/authentication_repository_impl.dart';
import 'package:flutter_login/features/login/data/repositories/user_repository_impl.dart';
import 'package:flutter_login/features/login/domain/repositories/authentication_repository.dart';
import 'package:flutter_login/features/login/domain/repositories/user_repository.dart';
import 'package:flutter_login/features/login/domain/usecases/dispose_auth_usecase.dart';
import 'package:flutter_login/features/login/domain/usecases/get_status_usecase.dart';
import 'package:flutter_login/features/login/domain/usecases/get_user_usecase.dart';
import 'package:flutter_login/features/login/domain/usecases/login_usecase.dart';
import 'package:flutter_login/features/login/domain/usecases/logout_usecase.dart';
import 'package:flutter_login/features/login/presentation/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:flutter_login/features/login/presentation/bloc/login_bloc/login_bloc.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

Future<void> init(String env) async {
  //Datasources
  sl
    ..registerLazySingleton<UserDatasource>(
      () => UserDataSourceImpl(),
    )
    ..registerLazySingleton<AuthenticationDatasource>(
      () => AuthenticationDatasourceImpl(),
    )
    //repositories
    ..registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(sl()),
    )
    ..registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(sl()),
    )

    //usescases
    ..registerLazySingleton<GetStatusUseCase>(
      () => GetStatusUseCase(repository: sl()),
    )
    ..registerLazySingleton<DisposeAuthUseCase>(
      () => DisposeAuthUseCase(repository: sl()),
    )
    ..registerLazySingleton<GetUserUseCase>(
      () => GetUserUseCase(repository: sl()),
    )
    ..registerLazySingleton<LoginUseCase>(() => LoginUseCase(repository: sl()))
    ..registerLazySingleton<LogoutUseCase>(
      () => LogoutUseCase(repository: sl()),
    )

    //blocs
    ..registerLazySingleton(
      () => AuthenticationBloc(
        logoutUsecase: sl(),
        getStatusUsecase: sl(),
        getUserUsecase: sl(),
        disposeAuthUseCase: sl(),
      ),
    )
    ..registerLazySingleton(
      () => LoginBloc(loginUsecase: sl()),
    );

  /*
    ..registerFactory<AuthenticationBloc>(
      () => AuthenticationBloc(
        logoutUsecase: sl(),
        getStatusUsecase: sl(),
        getUserUsecase: sl(),
        disposeAuthUseCase: sl(),
      ),
    );
}
