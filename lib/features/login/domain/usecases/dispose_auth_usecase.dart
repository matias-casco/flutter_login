import 'package:dartz/dartz.dart';
import 'package:flutter_login/core/errors/failures.dart';
import 'package:flutter_login/core/usecases/usecase.dart';
import 'package:flutter_login/features/login/data/repositories/authentication_repository_impl.dart';

class DisposeAuthUseCase extends UseCase<void, NoParams> {
  DisposeAuthUseCase({required this.repository});

  final AuthenticationRepositoryImpl repository;

  @override
  Future<Either<Failure, void>> call(NoParams) async {
    final result = repository.dispose();
    return result;
  }
}
