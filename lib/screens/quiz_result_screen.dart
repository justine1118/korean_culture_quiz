import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../router.dart';

class QuizResultScreen extends StatelessWidget {
  const QuizResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('퀴즈 결과')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('점수: 80', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const Placeholder(fallbackHeight: 120, fallbackWidth: 200),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => context.go(R.home),
              child: const Text('메인으로'),
            ),
          ],
        ),
      ),
    );
  }
}
