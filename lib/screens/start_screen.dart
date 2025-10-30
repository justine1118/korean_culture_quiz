import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../router.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Schemes-Surface-Container-Lowest
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),

              // 앱 타이틀
              const Text(
                '한국문화 퀴즈',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF1D1B20), // Schemes-On-Surface
                  fontSize: 28,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  height: 1.29,
                ),
              ),

              const SizedBox(height: 48),

              // 로그인 버튼
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFFE3E3E3), // Background-Neutral-Tertiary
                  foregroundColor: const Color(0xFF1E1E1E), // Text-Default-Default
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(
                      width: 1,
                      color: Color(0xFF767676), // Border-Neutral-Secondary
                    ),
                  ),
                ),
                onPressed: () => context.go(R.login),
                child: const Text('로그인'),
              ),

              const SizedBox(height: 12),

              // 회원가입 버튼
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF2C2C2C), // Background-Brand-Default
                  foregroundColor: const Color(0xFFF5F5F5), // Text-Brand-On-Brand
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: const BorderSide(
                      width: 1,
                      color: Color(0xFF2C2C2C), // Border-Brand-Default
                    ),
                  ),
                ),
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
