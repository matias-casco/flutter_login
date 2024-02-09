import 'dart:async';

import 'package:flutter_login/features/login/domain/authentication_status.dart';

abstract class AuthenticationDatasource {
  Stream<AuthenticationStatus> get status async* {}

  Future<void> logIn({
    required String username,
    required String password,
  }) async {}

  void logOut() {}

  void dispose() {}
}

class AuthenticationDatasourceImpl implements AuthenticationDatasource {
  final _controller = StreamController<AuthenticationStatus>();

  @override
  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    yield AuthenticationStatus.unauthenticated;
    yield* _controller.stream;
  }

  @override
  Future<void> logIn({
    required String username,
    required String password,
  }) async {
    //* Testear manejo de error
    //throw Exception('error de login desde datasource');
    return Future.delayed(
      const Duration(milliseconds: 300),
      () {
        if (!_controller.isClosed) {
          _controller.add(AuthenticationStatus.authenticated);
        }
      },
    );
  }

  @override
  void logOut() {
    //* Testear manejo de error
    //throw Exception('Error desde logout datasource');
    if (!_controller.isClosed) {
      _controller.add(AuthenticationStatus.unauthenticated);
    }
  }

  @override
  void dispose() => _controller.close();
}
