import 'package:dartz/dartz.dart';
import 'package:flutter_login/core/errors/failures.dart';
import 'package:flutter_login/features/login/domain/authentication_status.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, Stream<AuthenticationStatus>>> getStatus();

  Either<Failure, Future<void>> logIn({
    required String username,
    required String password,
  });

  Either<Failure, void> logOut();

  Either<Failure, void> dispose();
}
