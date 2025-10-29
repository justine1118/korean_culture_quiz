import 'package:flutter/material.dart';

class CharacterChangeScreen extends StatelessWidget {
  const CharacterChangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('캐릭터 변경')),
      body: Column(
        children: [
          const SizedBox(height: 12),
          const SizedBox(height: 180, child: Center(child: Placeholder())), // 미리보기
          const Divider(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: 20,
              itemBuilder: (_, i) => ListTile(
                leading: const CircleAvatar(child: Icon(Icons.star)),
                title: Text('아이템 #$i'),
                trailing: const Icon(Icons.add),
                onTap: () {}, // TODO: 적용 로직
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: FilledButton(
              onPressed: () => Navigator.of(context).pop(), // 저장 후 복귀
              child: const Text('저장'),
            ),
          ),
        ],
      ),
    );
  }
}
