import 'package:flutter/material.dart';

class AchievementScreen extends StatelessWidget {
  const AchievementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      ('연속 3일 학습', '하루 10분 학습을 3일 연속 진행'),
      ('명절 퀴즈 10문제', '명절 카테고리 10문제 완료'),
      ('80점 달성', '한 번의 퀴즈에서 80점 이상'),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('업적')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (_, i) => Card(
          child: ListTile(
            leading: const Icon(Icons.emoji_events_outlined),
            title: Text(items[i].$1),
            subtitle: Text(items[i].$2),
            trailing: const Icon(Icons.check_circle_outline),
          ),
        ),
      ),
    );
  }
}
