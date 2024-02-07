import 'package:equatable/equatable.dart';
import 'package:flutter_login/features/login/domain/entities/user_entity.dart';

class User extends UserEntity {
  const User({required this.id}) : super(id: id);

  final String id;
}
