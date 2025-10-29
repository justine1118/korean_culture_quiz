import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../router.dart';

class CharacterViewScreen extends StatelessWidget {
  const CharacterViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('내 캐릭터')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Expanded(child: Center(child: Placeholder())),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => context.push(R.characterChange),
              child: const Text('꾸미기/변경'),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () => context.go(R.home),
              child: const Text('메인으로'),
            ),
          ],
        ),
      ),
    );
  }
}
