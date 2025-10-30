import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../router.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar 대신 Figma 스타일 상단 타이틀을 직접 넣을 거라서 AppBar는 제거
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          // Figma 카드가 화면 중앙에 있고 좌우 여백이 48 → 여기선 약간 더 일반화해서 24
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 상단 타이틀 영역 ("회원가입") + 뒤로가기 화살표
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 뒤로가기 아이콘 버튼
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => context.go(R.start), // StartScreen 으로 이동
                  ),

                  // 타이틀을 가운데에 보이게 하기 위한 Expanded
                  const Expanded(
                    child: Text(
                      '회원가입',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF1D1B20), // Schemes-On-Surface
                        fontSize: 28,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 1.29,
                      ),
                    ),
                  ),

                  // 오른쪽에 균형 맞추기용 공간 (아이콘만큼)
                  // 아이콘버튼과 좌우 균형을 맞추기 위한 SizedBox
                  SizedBox(
                    width: kMinInteractiveDimension, // IconButton과 비슷한 폭
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // 가운데 카드 (Figma에서 테두리 1px, radius 8, padding 24)
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
                    child: const _SignupFormCardContent(),
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

// 이 위젯은 카드 내부만 담당 (Email / Password / 버튼)
class _SignupFormCardContent extends StatelessWidget {
  const _SignupFormCardContent();

  @override
  Widget build(BuildContext context) {
    // Figma에서 각 필드 사이 간격은 24, 라벨-필드 간은 8
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 닉네임
        const _LabeledInputField(
          label: '닉네임',
          hintText: 'ex)홍길동',
          obscure: false,
        ),
        const SizedBox(height: 24),
        // 이메일
        const _LabeledInputField(
          label: '이메일',
          hintText: 'ex) example@ex.com',
          obscure: false,
        ),
        const SizedBox(height: 24),

        // 비밀번호
        const _LabeledInputField(
          label: '비밀번호',
          hintText: 'ex)123445678',
          obscure: true,
        ),
        const SizedBox(height: 24),

        // 회원가입 버튼
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
            // 회원가입 완료 후 난이도 선택 화면으로 이동
            onPressed: () => context.go(R.difficulty),
            child: const Text(
              '회원가입',
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// 재사용 가능한 라벨 + 입력 필드 묶음
class _LabeledInputField extends StatelessWidget {
  final String label;
  final String hintText;
  final bool obscure;

  const _LabeledInputField({
    required this.label,
    required this.hintText,
    required this.obscure,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 라벨 (Email / Password)
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF1E1E1E), // Text-Default-Default
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            height: 1.40,
          ),
        ),
        const SizedBox(height: 8),

        // 실제 입력 박스
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white, // Background-Default-Default
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              width: 1,
              color: Color(0xFFD9D9D9), // Border-Default-Default
            ),
          ),
          child: TextField(
            obscureText: obscure,
            decoration: InputDecoration(
              isDense: true,
              // Figma placeholder = 'Value'
              hintText: hintText,
              hintStyle: const TextStyle(
                color: Color(0xFFB3B3B3), // Text-Default-Tertiary
                fontSize: 16,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 1,
              ),
              // 기본 TextField의 밑줄(border) 제거
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
      ],
    );
  }
}

