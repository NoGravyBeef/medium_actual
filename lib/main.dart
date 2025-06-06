import 'package:flutter/material.dart';
import 'package:medium_actual/common/view/splash_screen.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SplashScreen());
  }
}
