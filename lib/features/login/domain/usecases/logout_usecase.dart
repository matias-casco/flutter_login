import 'package:dartz/dartz.dart';
import 'package:flutter_login/core/errors/failures.dart';
import 'package:flutter_login/core/usecases/usecase.dart';
import 'package:flutter_login/features/login/domain/repositories/authentication_repository.dart';

class LogoutUseCase extends UseCase<void, NoParams> {
  LogoutUseCase({required this.repository});

  final AuthenticationRepository repository;

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    final result = repository.logOut();
    return result;
  }
}
