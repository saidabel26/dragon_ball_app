import 'package:flutter/material.dart';
import 'package:dragon_ball_app/app/theme/app_theme.dart';
import 'package:dragon_ball_app/screens/portada/portada_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dragon Ball Super',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: const PortadaScreen(),
    );
  }
}
