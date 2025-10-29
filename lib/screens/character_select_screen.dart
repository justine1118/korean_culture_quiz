import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../router.dart';

class CharacterSelectScreen extends StatelessWidget {
  const CharacterSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('캐릭터 선택')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, mainAxisSpacing: 8, crossAxisSpacing: 8),
          itemCount: 9,
          itemBuilder: (_, i) => GestureDetector(
            onTap: () => context.go(R.characterView),
            child: const Card(child: Center(child: Icon(Icons.person))),
          ),
        ),
      ),
    );
  }
}
