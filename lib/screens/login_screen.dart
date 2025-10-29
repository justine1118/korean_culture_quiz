import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final email = TextEditingController();
    final pw = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('로그인')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(controller: email, decoration: const InputDecoration(labelText: '이메일')),
            const SizedBox(height: 12),
            TextField(controller: pw, obscureText: true, decoration: const InputDecoration(labelText: '비밀번호')),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => context.go(R.home), // TODO: 실제 인증 후 이동
              child: const Text('로그인'),
            ),
            TextButton(
              onPressed: () => context.go(R.signup),
              child: const Text('회원가입으로 이동'),
            ),
          ],
        ),
      ),
    );
  }
}
