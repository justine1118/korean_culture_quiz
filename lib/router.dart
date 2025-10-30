import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
import 'screens/difficulty_and_study_select_screen.dart';
import 'screens/character_select_screen.dart';
import 'screens/character_view_screen.dart';
import 'screens/character_change_screen.dart';

//라우트 경로 상수
class R {
  static const start = '/start';
  static const login = '/login';
  static const signup = '/signup';
  static const home = '/home';

  static const quiz = '/quiz';
  static const quizResult = '/quiz/result';

  static const achievements = '/achievements';
  static const learningStatus = '/learning-status';
  static const settings = '/settings';
  static const difficulty = '/difficulty';

  static const characterSelect = '/character/select';
  static const characterView = '/character/view';
  static const characterChange = '/character/change';
}

/// 전역 라우터
final GoRouter appRouter = GoRouter(
  initialLocation: R.start,
  routes: [
    GoRoute(path: R.start,       name: 'start',        builder: (_, __) => const
    StartScreen()),
    GoRoute(path: R.login,       name: 'login',        builder: (_, __) => const LoginScreen()),
    GoRoute(path: R.signup,      name: 'signup',       builder: (_, __) => const SignupScreen()),
    GoRoute(path: R.home,        name: 'home',         builder: (_, __) => const HomeScreen()),

    GoRoute(path: R.quiz,        name: 'quiz',         builder: (_, __) => const QuizScreen()),
    GoRoute(path: R.quizResult,  name: 'quizResult',    builder: (_, __) => const QuizResultScreen()),

    GoRoute(path: R.achievements,    name: 'achievements',    builder: (_, __) => const AchievementScreen()),
    GoRoute(path: R.learningStatus,  name: 'learningStatus',  builder: (_, __) => const LearningStatusScreen()),
    GoRoute(path: R.settings,        name: 'settings',        builder: (_, __) => const SettingScreen()),
    GoRoute(path: R.difficulty,      name: 'difficulty',      builder: (_, __) => const DifficultyAndStudySelectScreen( )),

    GoRoute(path: R.characterSelect, name: 'characterSelect', builder: (_, __) => const CharacterSelectScreen()),
    GoRoute(path: R.characterView,   name: 'characterView',   builder: (_, __) => const CharacterViewScreen()),
    GoRoute(path: R.characterChange, name: 'characterChange', builder: (_, __) => const CharacterChangeScreen()),
  ],
  // 404 등 에러 처리(임시)
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text('페이지를 찾을 수 없습니다')),
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(state.error?.toString() ?? 'Unknown route', textAlign: TextAlign.center),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: () => context.go(R.start),
            child: const Text('시작 화면으로'),
          ),
        ],
      ),
    ),
  ),
);