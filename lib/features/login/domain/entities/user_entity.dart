import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({required this.id});

  final String id;

  @override
  List<Object?> get props => [id];

  static const empty = UserEntity(id: '-');
}
