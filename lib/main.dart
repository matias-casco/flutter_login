import 'package:flutter/widgets.dart';
import 'package:flutter_login/app.dart';
import 'package:flutter_login/features/login/injector.dart';

void main() async {
  await init('dev');
  runApp(const App());
}
