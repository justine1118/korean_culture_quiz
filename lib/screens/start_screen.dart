import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../router.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              const Text('다문화 퀴즈앱', textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: () => context.go(R.login),
                child: const Text('로그인'),
              ),
              TextButton(
                onPressed: () => context.go(R.signup),
                child: const Text('회원가입'),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
