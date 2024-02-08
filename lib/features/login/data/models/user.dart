import 'package:flutter_login/features/login/domain/entities/user_entity.dart';

class User extends UserEntity {
  const User({required super.id, this.username = '', this.password = ''});

  final String username;
  final String password;
}
