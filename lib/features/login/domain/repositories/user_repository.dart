import 'package:dartz/dartz.dart';
import 'package:flutter_login/core/errors/failures.dart';
import 'package:flutter_login/features/login/data/models/models.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getUser();
}
