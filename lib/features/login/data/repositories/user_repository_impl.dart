import 'package:dartz/dartz.dart';
import 'package:flutter_login/core/errors/failures.dart';
import 'package:flutter_login/features/login/data/datasource/user_datasource.dart';
import 'package:flutter_login/features/login/data/models/user.dart';
import 'package:flutter_login/features/login/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this.userDatasource);

  final UserDatasource userDatasource;

  @override
  Future<Either<Failure, User>> getUser() async {
    try {
      final response = await userDatasource.getUser();
      return Right(response);
    } catch (e) {
      return Left(
        ServerFailure(
          message: 'Error getting duration.',
          code: 500,
          status: 500,
        ),
      );
    }
  }
}
