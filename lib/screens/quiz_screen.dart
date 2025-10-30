import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import '../router.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final choices = ['설날', '추석', '한글날', '광복절'];
    return Scaffold(
      appBar: AppBar(title: const Text('퀴즈')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Q1. 한국의 대표적인 명절은?', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            for (final c in choices)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: OutlinedButton(
                  onPressed: () => context.go(R.quizResult),
                  child: Text(c),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
