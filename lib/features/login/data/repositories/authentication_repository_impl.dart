import 'package:dartz/dartz.dart';
import 'package:flutter_login/core/errors/failures.dart';
import 'package:flutter_login/features/login/data/datasource/authentication_datasource.dart';
import 'package:flutter_login/features/login/domain/authentication_status.dart';
import 'package:flutter_login/features/login/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenticationRepositoryImpl(this.authenticationDatasource);

  final AuthenticationDatasource authenticationDatasource;

  @override
  Future<Either<Failure, Stream<AuthenticationStatus>>> getStatus() async {
    try {
      final response = authenticationDatasource.status;
      return Right(response);
    } catch (e) {
      print(e.toString());
      return Left(
        ServerFailure(
          message: e.toString(),
          code: 500,
          status: 500,
        ),
      );
    }
  }

  @override
  Future<Either<Failure, Future<void>>> logIn({
    required String username,
    required String password,
  }) async {
    try {
      await authenticationDatasource.logIn(
        username: username,
        password: password,
      );
      return Right(Future.value());
    } catch (e) {
      return Left(
        ServerFailure(
          message: e.toString(),
          code: 500,
          status: 500,
        ),
      );
    }
  }

  @override
  Either<Failure, void> logOut() {
    try {
      final response = authenticationDatasource.logOut();
      return Right(response);
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'Error logging out.',
          code: 500,
          status: 500,
        ),
      );
    }
  }

  @override
  Either<Failure, void> dispose() {
    try {
      final response = authenticationDatasource.dispose();
      return Right(response);
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'Error dispossing.',
          code: 500,
          status: 500,
        ),
      );
    }
  }
}
