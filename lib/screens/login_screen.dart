import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 입력값 컨트롤러 유지
    final email = TextEditingController();
    final pw = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          // 화면 전체 여백
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 상단 영역: 뒤로가기 화살표 + "로그인" 타이틀
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => context.go(R.start), // 시작 화면으로 이동
                  ),
                  const Expanded(
                    child: Text(
                      '로그인',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF1D1B20), // Schemes-On-Surface
                        fontSize: 28,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w500,
                        height: 1.29,
                      ),
                    ),
                  ),
                  // 오른쪽에 빈 공간을 넣어 타이틀이 정확히 가운데 오도록 균형 맞춤
                  SizedBox(
                    width: kMinInteractiveDimension,
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // 가운데 카드 (Figma 스타일)
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 360),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white, // Background-Default-Default
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        width: 1,
                        color: Color(0xFFD9D9D9), // Border-Default-Default
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 이메일 필드
                        const Text(
                          'Email',
                          style: TextStyle(
                            color: Color(0xFF1E1E1E), // Text-Default-Default
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 1.40,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              width: 1,
                              color: Color(0xFFD9D9D9), // Border-Default-Default
                            ),
                          ),
                          child: TextField(
                            controller: email,
                            decoration: const InputDecoration(
                              isDense: true,
                              hintText: '이메일을 입력하세요',
                              hintStyle: TextStyle(
                                color: Color(0xFFB3B3B3), // Text-Default-Tertiary
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 1,
                              ),
                              border: InputBorder.none,
                            ),
                            style: const TextStyle(
                              color: Color(0xFF1E1E1E),
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 1,
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // 비밀번호 필드
                        const Text(
                          'Password',
                          style: TextStyle(
                            color: Color(0xFF1E1E1E),
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 1.40,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              width: 1,
                              color: Color(0xFFD9D9D9),
                            ),
                          ),
                          child: TextField(
                            controller: pw,
                            obscureText: true,
                            decoration: const InputDecoration(
                              isDense: true,
                              hintText: '비밀번호를 입력하세요',
                              hintStyle: TextStyle(
                                color: Color(0xFFB3B3B3),
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 1,
                              ),
                              border: InputBorder.none,
                            ),
                            style: const TextStyle(
                              color: Color(0xFF1E1E1E),
                              fontSize: 16,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                              height: 1,
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // 로그인 버튼
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            style: FilledButton.styleFrom(
                              backgroundColor: Color(0xFF2C2C2C), // Background-Brand-Default
                              foregroundColor: Color(0xFFF5F5F5), // Text-Brand-On-Brand
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                                side: const BorderSide(
                                  width: 1,
                                  color: Color(0xFF2C2C2C), // Border-Brand-Default
                                ),
                              ),
                            ),
                            onPressed: () => context.go(R.main), // TODO: 실제 인증 후 이동
                            child: const Text(
                              '로그인',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 1,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // 회원가입으로 이동 (텍스트 버튼)
                        Center(
                          child: TextButton(
                            onPressed: () => context.go(R.signup),
                            child: const Text(
                              '회원가입으로 이동',
                              style: TextStyle(
                                color: Color(0xFF2C2C2C),
                                fontSize: 14,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
