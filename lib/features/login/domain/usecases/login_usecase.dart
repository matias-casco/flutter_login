import 'package:dartz/dartz.dart';
import 'package:flutter_login/core/errors/failures.dart';
import 'package:flutter_login/core/usecases/usecase.dart';
import 'package:flutter_login/features/login/data/models/models.dart';
import 'package:flutter_login/features/login/data/repositories/authentication_repository_impl.dart';

class LoginUseCase extends UseCase<Future<void>, User> {
  LoginUseCase({required this.repository});

  final AuthenticationRepositoryImpl repository;

  @override
  Future<Either<Failure, Future<void>>> call(
    User params,
  ) async {
    final result = repository.logIn(
      username: params.username,
      password: params.password,
    );
    return result;
  }
}
