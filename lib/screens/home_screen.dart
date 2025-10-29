import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('홈')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const Placeholder(fallbackHeight: 140), // 통계/배지 등 자리
            const SizedBox(height: 16),
            FilledButton(onPressed: () => context.push(R.quiz), child: const Text('퀴즈 시작')),
            const SizedBox(height: 8),
            FilledButton(onPressed: () => context.push(R.learningStatus), child: const Text('학습 현황')),
            const SizedBox(height: 8),
            FilledButton(onPressed: () => context.push(R.achievements), child: const Text('도전과제/업적')),
            const SizedBox(height: 8),
            FilledButton(onPressed: () => context.push(R.settings), child: const Text('설정')),
            const SizedBox(height: 8),
            FilledButton(onPressed: () => context.push(R.characterView), child: const Text('내 캐릭터 보기')),
          ],
        ),
      ),
    );
  }
}

