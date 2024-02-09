import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_login/core/usecases/usecase.dart';
import 'package:flutter_login/features/login/data/models/models.dart';
import 'package:flutter_login/features/login/domain/authentication_status.dart';
import 'package:flutter_login/features/login/domain/entities/user_entity.dart';
import 'package:flutter_login/features/login/domain/usecases/usecases.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required this.logoutUsecase,
    required this.getStatusUsecase,
    required this.getUserUsecase,
    required this.disposeAuthUseCase,
  }) : super(const AuthenticationState.unknown()) {
    on<_AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    on<WatchAuthenticationStatus>(_onWatchAuthenticationStatus);
    add(WatchAuthenticationStatus());
  }

  final GetStatusUseCase getStatusUsecase;
  final GetUserUseCase getUserUsecase;
  final LogoutUseCase logoutUsecase;
  final DisposeAuthUseCase disposeAuthUseCase;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    return super.close();
  }

  Future<void> _onAuthenticationStatusChanged(
    _AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthenticationState.unauthenticated());
      case AuthenticationStatus.authenticated:
        final user = await getUserUsecase(UserEntity.empty);
        user.fold((error) {
          return emit(const AuthenticationState.unauthenticated());
        }, (user) {
          return emit(AuthenticationState.authenticated(user));
        });
      case AuthenticationStatus.unknown:
        return emit(const AuthenticationState.unknown());
    }
  }

  void _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    logoutUsecase(NoParams());
  }

  Future<bool> onDisposeAuth() async {
    final disposal = await disposeAuthUseCase(NoParams());

    disposal.fold((error) {
      return false;
    }, (success) {
      return true;
    });

    return false;
  }

  Future<bool> _onWatchAuthenticationStatus(
    WatchAuthenticationStatus event,
    Emitter<AuthenticationState> emit,
  ) async {
    await getStatusUsecase(NoParams()).then((either) {
      either.fold((failure) {
        // manejar el error
      }, (stream) {
        _authenticationStatusSubscription = stream.listen(
          (status) => add(_AuthenticationStatusChanged(status)),
        );
      });
    });
    print('escuchando auth status');
    return true;
  }
}
