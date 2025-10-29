import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../router.dart';

class DifficultySelectScreen extends StatelessWidget {
  const DifficultySelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final options = ['쉬움', '보통', '어려움'];
    return Scaffold(
      appBar: AppBar(title: const Text('난이도 선택')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: options.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (_, i) => Card(
          child: ListTile(
            title: Text(options[i]),
            onTap: () => context.go(R.characterSelect),
          ),
        ),
      ),
    );
  }
}
