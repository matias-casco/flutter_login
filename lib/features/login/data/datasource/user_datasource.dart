import 'dart:async';

import 'package:flutter_login/features/login/data/models/user.dart';
import 'package:uuid/uuid.dart';

abstract class UserDatasource {
  Future<User> getUser();
}

class UserDataSourceImpl implements UserDatasource {
  User? _user;

  @override
  Future<User> getUser() async {
    if (_user != null) return const User('', '', id: '-');
    return Future.delayed(
      const Duration(milliseconds: 300),
      () => _user = User('', '', id: const Uuid().v4()),
    );
  }
}
