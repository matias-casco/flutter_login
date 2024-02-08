import 'package:dartz/dartz.dart';
import 'package:flutter_login/core/errors/failures.dart';
import 'package:flutter_login/core/usecases/usecase.dart';
import 'package:flutter_login/features/login/data/repositories/authentication_repository_impl.dart';
import 'package:flutter_login/features/login/domain/authentication_status.dart';

class GetStatusUseCase extends UseCase<Stream<AuthenticationStatus>, NoParams> {
  GetStatusUseCase({required this.repository});

  final AuthenticationRepositoryImpl repository;

  @override
  Future<Either<Failure, Stream<AuthenticationStatus>>> call(
    NoParams params,
  ) {
    final result = repository.getStatus();
    return result;
  }
}
