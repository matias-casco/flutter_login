import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/features/login/data/datasource/authentication_datasource.dart';
import 'package:flutter_login/features/login/data/datasource/user_datasource.dart';
import 'package:flutter_login/features/login/data/repositories/authentication_repository_impl.dart';
import 'package:flutter_login/features/login/data/repositories/user_repository_impl.dart';
import 'package:flutter_login/features/login/domain/usecases/get_status_usecase.dart';
import 'package:flutter_login/features/login/domain/usecases/get_user_usecase.dart';
import 'package:flutter_login/features/login/login.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final UserDataSourceImpl userDatasource;
  late final AuthenticationDatasourceImpl authenticationDatasource;
  late final UserRepositoryImpl userRepository;
  late final AuthenticationRepository _authenticationRepository;
  late final AuthenticationRepositoryImpl _authenticationRepositoryImpl;
  late final GetUserUseCase _getUserUseCase;
  late final GetStatusUsecase _getStatusUsecase;

  @override
  void initState() {
    super.initState();
    userDatasource = UserDataSourceImpl();
    authenticationDatasource = AuthenticationDatasourceImpl();
    userRepository = UserRepositoryImpl(userDatasource);
    _authenticationRepository = AuthenticationRepository();
    _authenticationRepositoryImpl =
        AuthenticationRepositoryImpl(authenticationDatasource);
    _getUserUseCase = GetUserUseCase(repository: userRepository);
    _getStatusUsecase =
        GetStatusUsecase(repository: _authenticationRepositoryImpl);
  }

  @override
  void dispose() {
    _authenticationRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: _authenticationRepository,
          getUserUseCase: _getUserUseCase,
          getStatusUsecase: _getStatusUsecase,
        ),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  HomePage.route(),
                  (route) => false,
                );
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  LoginPage.route(),
                  (route) => false,
                );
              case AuthenticationStatus.unknown:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
