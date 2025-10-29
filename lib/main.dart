import 'package:flutter/material.dart';
import 'router.dart';

// screens
import 'screens/start_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/home_screen.dart';
import 'screens/quiz_screen.dart';
import 'screens/quiz_result_screen.dart';
import 'screens/achievement_screen.dart';
import 'screens/learning_status_screen.dart';
import 'screens/setting_screen.dart';
import 'screens/difficulty_select_screen.dart';
import 'screens/character_select_screen.dart';
import 'screens/character_view_screen.dart';
import 'screens/character_change_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '다문화 퀴즈앱',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
      routerConfig: appRouter,
    );
  }
}
