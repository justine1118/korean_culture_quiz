import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// screens
import 'screens/start_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/quiz_screen.dart';
import 'screens/quiz_result_screen.dart';
import 'screens/achievement_screen.dart';
import 'screens/learning_status_screen.dart';
import 'screens/setting_screen.dart';

// ⭐ 메인 탭 스크린
import 'screens/main_screen/main_tab_scaffold.dart';

// 라우트 경로 상수
class R {
  static const start = '/start';
  static const login = '/login';
  static const signup = '/signup';
  static const main = '/main';

  static const quiz = '/quiz';
  static const quizResult = '/quiz/result';

  static const achievements = '/achievements';
  static const learningStatus = '/learning-status';
  static const settings = '/settings';
  static const difficulty = '/difficulty';
  // 정보 모음(메인 탭 중 하나) 경로
  static const information = '/information';
}

/// 전역 라우터
final GoRouter appRouter = GoRouter(
  // 처음 들어갈 위치 (원하면 R.home 으로 바꿔도 됨)
  initialLocation: R.main,
  routes: [
    GoRoute(
      path: R.start,
      name: 'start',
      builder: (_, __) => const StartScreen(),
    ),
    GoRoute(
      path: R.login,
      name: 'login',
      builder: (_, __) => const LoginScreen(),
    ),
    GoRoute(
      path: R.signup,
      name: 'signup',
      builder: (_, __) => const SignupScreen(),
    ),

    // ⭐ 메인 탭 스크린 (홈)
    GoRoute(
      path: R.main,
      name: 'main',
      builder: (_, __) => const MainTabScaffold(),
    ),

    // ⭐ 정보 모음 경로도 같은 스크린으로 라우팅
    GoRoute(
      path: R.information,
      name: 'information',
      builder: (_, __) => const MainTabScaffold(),
    ),

    GoRoute(
      path: R.quiz,
      name: 'quiz',
      builder: (_, __) => const QuizScreen(),
    ),

    // 퀴즈 결과 화면
    GoRoute(
      path: R.quizResult,
      name: 'quizResult',
      builder: (context, state) {
        final extra = state.extra as Map<String, int>?;

        final total = extra?['total'] ?? 2;
        final correct = extra?['correct'] ?? 1;

        return QuizResultScreen(
          total: total,
          correct: correct,
        );
      },
    ),

    GoRoute(
      path: R.achievements,
      name: 'achievements',
      builder: (_, __) => const AchievementScreen(),
    ),
    GoRoute(
      path: R.learningStatus,
      name: 'learningStatus',
      builder: (_, __) => const LearningStatusScreen(),
    ),
    GoRoute(
      path: R.settings,
      name: 'settings',
      builder: (_, __) => const SettingScreen(),
    ),
  ],

  // 404 에러 처리
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text('페이지를 찾을 수 없습니다')),
    body: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            state.error?.toString() ?? 'Unknown route',
            textAlign: TextAlign.center,
          ),
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
