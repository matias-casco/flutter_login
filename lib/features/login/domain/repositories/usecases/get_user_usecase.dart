import 'package:dartz/dartz.dart';
import 'package:flutter_login/core/errors/failures.dart';
import 'package:flutter_login/core/usecases/usecase.dart';
import 'package:flutter_login/features/login/domain/entities/user_entity.dart';
import 'package:flutter_login/features/login/domain/repositories/user_repository.dart';
import 'package:flutter_login/features/login/login.dart';

class GetUserUseCase extends UseCase<User, UserEntity> {
  GetUserUseCase({required this.repository});

  final UserRepository repository;

  @override
  Future<Either<Failure, User>> call(UserEntity params) async {
    final result = await repository.getUser();

    return result;
  }
}
