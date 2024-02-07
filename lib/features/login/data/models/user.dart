import 'package:flutter_login/features/login/domain/entities/user_entity.dart';

class User extends UserEntity {
  const User(this.username, this.password, {required this.id}) : super(id: id);

  final String id;
  final String username;
  final String password;
}
