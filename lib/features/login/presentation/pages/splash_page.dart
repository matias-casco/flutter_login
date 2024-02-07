import 'package:flutter/material.dart';
import 'package:flutter_login/features/login/presentation/views/splash_view.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const SplashPage());
  }

  @override
  Widget build(BuildContext context) {
    return const SplashView();
  }
}
