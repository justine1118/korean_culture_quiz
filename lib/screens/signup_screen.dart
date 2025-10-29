import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../router.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('회원가입')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const TextField(decoration: InputDecoration(labelText: '이메일')),
            const SizedBox(height: 12),
            const TextField(decoration: InputDecoration(labelText: '비밀번호'), obscureText: true),
            const SizedBox(height: 12),
            const TextField(decoration: InputDecoration(labelText: '닉네임')),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => context.go(R.difficulty),
              child: const Text('다음(난이도 선택)'),
            ),
          ],
        ),
      ),
    );
  }
}
