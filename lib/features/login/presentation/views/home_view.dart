import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/features/login/injector.dart';
import 'package:flutter_login/features/login/login.dart';
import 'package:flutter_login/features/login/presentation/bloc/authentication_bloc/authentication_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Builder(
              builder: (context) {
                final userId = context.select(
                  (AuthenticationBloc bloc) => bloc.state.user.id,
                );
                return Text('UserID: $userId');
              },
            ),
            ElevatedButton(
              child: const Text('Logout'),
              onPressed: () {
                sl<AuthenticationBloc>().add(AuthenticationLogoutRequested());
              },
            ),
          ],
        ),
      ),
    );
  }
}
