import 'package:flutter/material.dart';
import 'package:flutter_login/features/login/presentation/views/login_view.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return const LoginView();
  }
}
