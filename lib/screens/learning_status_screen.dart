import 'package:flutter/material.dart';

class LearningStatusScreen extends StatelessWidget {
  const LearningStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('학습 현황')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text('주간 학습량', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            const Placeholder(fallbackHeight: 120),
            const SizedBox(height: 24),
            Row(
              children: const [
                Expanded(child: LinearProgressIndicator(value: 0.6)),
                SizedBox(width: 12),
                Text('60%'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
