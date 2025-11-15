import 'package:flutter/material.dart';

class InfoTabBody extends StatelessWidget {
  const InfoTabBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFEDE8E3),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _HeaderArea(),
            SizedBox(height: 32),

            _InfoEntryCard(text: '퀴즈 정보 모음'),
            SizedBox(height: 20),

            _InfoEntryCard(text: '생활 정보 모음'),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

/// -------------------------
/// 상단 캐릭터 + 말풍선 영역
/// -------------------------
class _HeaderArea extends StatelessWidget {
  const _HeaderArea();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // 호랑이 캐릭터
          SizedBox(
            width: 90,
            height: 120,
            child: Image.asset(
              'assets/images/tiger_image.png',
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(width: 12),

          // 오른쪽 말풍선 박스
          Expanded(
            child: Container(
              height: 110,
              decoration: BoxDecoration(
                color: const Color(0xFFF4F3F6),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),

              // ▶ 가운데 정렬 적용
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '정보 모음',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF2C2C2C),
                      fontSize: 22,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      height: 1.5,
                    ),
                  ),

                  // ▶ 기존 간격 4 → 6 (1.5배 증가)
                  SizedBox(height: 6),

                  Text(
                    '퀴즈 정보와 생활 정보 모음집',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF858494),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// -------------------------
/// 정보 목록 카드
/// -------------------------
class _InfoEntryCard extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;

  const _InfoEntryCard({
    required this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.lightbulb_outline,
              size: 48,
              color: Color(0xFF4E7C88),
            ),
            const SizedBox(width: 16),

            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  color: Color(0xFF2C2C2C),
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
