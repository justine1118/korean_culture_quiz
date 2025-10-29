import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _sound = true;
  bool _notify = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('설정')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('사운드'),
            value: _sound,
            onChanged: (v) => setState(() => _sound = v),
          ),
          SwitchListTile(
            title: const Text('알림'),
            value: _notify,
            onChanged: (v) => setState(() => _notify = v),
          ),
          const ListTile(
            title: Text('버전'),
            subtitle: Text('0.1.0'),
          ),
        ],
      ),
    );
  }
}
