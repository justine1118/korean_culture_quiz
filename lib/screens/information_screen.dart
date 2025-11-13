import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../router.dart';

/// 정보 모음 메인 화면
/// file: information_screen.dart
class InformationScreen extends StatelessWidget {
  const InformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDE8E3),
      body: SafeArea(
        child: Column(
          children: [
            // 상단 + 컨텐츠 영역
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _HeaderArea(),
                    const SizedBox(height: 32),

                    // ── 퀴즈 정보 모음 카드 ────────────────────────
                    const _SectionTitle('퀴즈 정보 모음'),
                    const SizedBox(height: 12),
                    _InfoEntryCard(
                      text: '퀴즈 정보 모음',
                      onTap: () {
                        // TODO: 퀴즈 정보 모음 카테고리 화면으로 이동
                        // 예) context.go('/information/quiz');
                      },
                    ),

                    const SizedBox(height: 24),

                    // ── 생활 정보 모음 카드 ────────────────────────
                    const _SectionTitle('생활 정보 모음'),
                    const SizedBox(height: 12),
                    _InfoEntryCard(
                      text: '생활 정보 모음',
                      onTap: () {
                        // TODO: 생활 정보 모음 카테고리 화면으로 이동
                        // 예) context.go('/information/life');
                      },
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // 하단 네비게이션 바
            const _BottomNavBar(),
          ],
        ),
      ),
    );
  }
}

/// ─────────────────────────────────────────────────────────────
/// 상단 캐릭터 + 말풍선 영역
/// ─────────────────────────────────────────────────────────────
class _HeaderArea extends StatelessWidget {
  const _HeaderArea();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // 말풍선 박스
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              width: 228,
              height: 86,
              decoration: BoxDecoration(
                color: const Color(0xFFF4F3F6),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '정보 모음',
                    style: TextStyle(
                      color: Color(0xFF2C2C2C),
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '퀴즈 정보와 생활 정보 모음집',
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

          // 캐릭터 이미지
          Positioned(
            left: 8,
            bottom: 0,
            child: Container(
              width: 74,
              height: 112,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  // TODO: 실제 캐릭터 에셋으로 교체
                  image: NetworkImage('https://placehold.co/74x112'),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// 섹션 타이틀 (예: '퀴즈 정보 모음', '생활 정보 모음')
class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF2C2C2C),
        fontSize: 16,
        fontFamily: 'Inter',
        fontWeight: FontWeight.w600,
        height: 1.5,
      ),
    );
  }
}

/// 정보 목록에 쓰이는 공통 카드 (아이콘 + 텍스트)
/// 나중에 카테고리/리스트/세부 페이지에서도 그대로 재사용하면 됨.
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.lightbulb_outline,
              size: 24,
              color: Color(0xFF4E7C88),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  color: Color(0xFF2C2C2C),
                  fontSize: 15,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              size: 20,
              color: Color(0xFFB0B0B0),
            ),
          ],
        ),
      ),
    );
  }
}

/// ─────────────────────────────────────────────────────────────
/// 하단 네비게이션 바
/// (현재 탭: 정보 모음 탭이 선택된 상태)
/// ─────────────────────────────────────────────────────────────
class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      color: const Color(0xFFEDE8E3),
      padding: const EdgeInsets.only(top: 8, bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _BottomNavItem(
            icon: Icons.home_outlined,
            label: '메인',
            isSelected: false,
            onTap: () {
              context.go(R.home);
            },
          ),
          _BottomNavItem(
            icon: Icons.menu_book_outlined,
            label: '정보 모음',
            isSelected: true, // 현재 화면
            onTap: () {
              // 현재 페이지이므로 이동 없음
            },
          ),
          _BottomNavItem(
            icon: Icons.bar_chart_outlined,
            label: '학습 현황',
            isSelected: false,
            onTap: () {
              context.go(R.learningStatus);
            },
          ),
          _BottomNavItem(
            icon: Icons.settings_outlined,
            label: '설정',
            isSelected: false,
            onTap: () {
              context.go(R.settings);
            },
          ),
        ],
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  const _BottomNavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color activeColor = const Color(0xFF4E7C88);
    const Color inactiveColor = Color(0xFF6D6D6D);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 64,
            height: 32,
            decoration: BoxDecoration(
              color: isSelected ? activeColor : Colors.transparent,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              size: 22,
              color: isSelected ? Colors.white : inactiveColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isSelected ? activeColor : inactiveColor,
              fontSize: 12,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
              height: 1.33,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
