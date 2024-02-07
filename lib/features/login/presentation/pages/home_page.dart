import 'package:flutter/material.dart';
import 'package:flutter_login/features/login/presentation/views/home_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return const HomeView();
  }
}
