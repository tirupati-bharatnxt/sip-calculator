import 'package:flutter/material.dart';
import 'package:sippy/components/app_theme.dart';
import 'home.dart';

Future<void> main() async {
  runApp(const Sippy());
}

class Sippy extends StatelessWidget {
  const Sippy({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sippy',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const HomePage(),
    );
  }
}

