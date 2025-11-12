import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 더미 데이터 (나중에 상태 연결)
    final String selectedCharacterName = '캐릭터 1번';
    final String selectedCharacterImage = 'https://placehold.co/116x119';

    return Scaffold(
      backgroundColor: const Color(0xFFFEF7FF), // 바깥 전체 배경

      // ===== 상단바 =====
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: SafeArea(
          bottom: false,
          child: Container(
            width: double.infinity,
            color: const Color(0xFFFEF7FF),
            padding: const EdgeInsets.only(
              top: 8,
              left: 4,
              right: 4,
              bottom: 12,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _roundIconButton(
                  icon: Icons.person,
                  onTap: () {
                    // TODO: 마이페이지 라우팅 붙이면 여기서 push
                  },
                ),
                Row(
                  children: [
                    _roundIconButton(
                      icon: Icons.notifications_outlined,
                      onTap: () {
                        // TODO: 알림 화면
                      },
                    ),
                    _roundIconButton(
                      icon: Icons.settings_outlined,
                      onTap: () {
                        context.push(R.settings);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),

      // ===== 가운데 본문 =====
      // Expanded 비율로 반반 나눠야 하니까 Column + Expanded로 짜고
      // 전체 프레임 모양(455폭, 외곽선, 둥근 모서리 등)은 body에서 직접 그림.
      body: SafeArea(
        top: false,
        bottom: false,
        child: Center(
          child: Container(
            width: 455,
            // 바깥 프레임 (기기 모형)
            decoration: ShapeDecoration(
              color: const Color(0xFFFEF7FF),
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 8,
                  strokeAlign: BorderSide.strokeAlignOutside,
                  color: Color(0xFFCAC4D0),
                ),
                borderRadius: BorderRadius.circular(28),
              ),
            ),
            // 안쪽은 상단만 둥글고, 하단은 직각으로 떨어지게 해서
            // bottomNavigationBar랑 만나는 부분에 둥근 그림자 안 보이게 함.
            child: Column(
              children: [
                // 이 Expanded 2개가 각각 화면 높이의 반씩 차지
                Expanded(
                  child: _CharacterSection(
                    selectedCharacterImage: selectedCharacterImage,
                    selectedCharacterName: selectedCharacterName,
                  ),
                ),
                Expanded(
                  child: _QuizSection(),
                ),
              ],
            ),
          ),
        ),
      ),

      // ===== 하단 네비게이션 바 =====
      bottomNavigationBar: SafeArea(
        top: false,
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xFFF3EDF7), // Schemes-Surface-Container
          ),
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            children: [
              _BottomNavItem(
                label: '메인 화면',
                icon: Icons.home,
                active: true,
                onTap: () {
                  // 이미 홈
                },
              ),
              _BottomNavItem(
                label: '마이 페이지',
                icon: Icons.person_outline,
                active: false,
                onTap: () {
                  // TODO: 마이페이지 라우트 붙이면 사용
                  // context.push(R.myPage);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================
// 상단 우측/좌측 둥근 아이콘 버튼
// =====================================================
Widget _roundIconButton({
  required IconData icon,
  required VoidCallback onTap,
  double size = 40,
  Color? bgColor,
}) {
  return InkWell(
    customBorder: const CircleBorder(),
    onTap: onTap,
    child: Container(
      width: 48,
      height: 48,
      alignment: Alignment.center,
      child: Container(
        width: size,
        height: size,
        decoration: ShapeDecoration(
          color: bgColor,
          shape: const CircleBorder(),
        ),
        alignment: Alignment.center,
        child: Icon(
          icon,
          size: 24,
          color: Colors.black,
        ),
      ),
    ),
  );
}

// =====================================================
// 내 캐릭터 섹션 (화면 상단 절반)
// =====================================================
class _CharacterSection extends StatelessWidget {
  final String selectedCharacterImage;
  final String selectedCharacterName;

  const _CharacterSection({
    required this.selectedCharacterImage,
    required this.selectedCharacterName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // 위쪽/아래쪽 영역 경계를 깔끔하게 하기 위해 배경은 그대로 Surface 색
      color: const Color(0xFFFEF7FF),
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: 8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // "내 캐릭터  >" 헤더
          InkWell(
            onTap: () {
              context.push(R.characterView);
            },
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '내 캐릭터',
                    style: TextStyle(
                      color: const Color(0xFF1D1B20),
                      fontSize: 22,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 1.27,
                    ),
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: Colors.black,
                  size: 24,
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // 선택된 캐릭터 카드 하나만 표시
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                context.push(R.characterView);
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFECE6F0),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 캐릭터 이미지
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        selectedCharacterImage,
                        width: 116,
                        height: 119,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(width: 12),

                    // 캐릭터 이름
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          selectedCharacterName,
                          style: TextStyle(
                            color: const Color(0xFF1D1B20),
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w500,
                            height: 1.50,
                            letterSpacing: 0.10,
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
    );
  }
}

// =====================================================
// 퀴즈 섹션 (화면 하단 절반)
// =====================================================
class _QuizSection extends StatelessWidget {
  const _QuizSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      // 아랫부분도 같은 배경색으로, 둥근 모서리 없이 하단바랑 바로 맞닿게
      color: const Color(0xFFFEF7FF),
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: 0, // bottomNavBar랑 딱 붙도록 0
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // "퀴즈  >" 헤더
          InkWell(
            onTap: () {
              context.push(R.quiz);
            },
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '퀴즈',
                    style: TextStyle(
                      color: const Color(0xFF1D1B20),
                      fontSize: 22,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 1.27,
                    ),
                  ),
                ),
                const Icon(
                  Icons.chevron_right,
                  color: Colors.black,
                  size: 24,
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // 두 개의 퀴즈 카드 (왼쪽 큰 카드 + 오른쪽 얇은 카드)
          SizedBox(
            height: 150,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 왼쪽 큰 카드
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(28),
                    onTap: () {
                      context.push(R.quiz);
                    },
                    child: Container(
                      decoration: ShapeDecoration(
                        image: const DecorationImage(
                          image: NetworkImage("https://placehold.co/359x205"),
                          fit: BoxFit.cover,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),

                // 오른쪽 얇은 카드
                InkWell(
                  borderRadius: BorderRadius.circular(28),
                  onTap: () {
                    context.push(R.quiz);
                  },
                  child: Container(
                    width: 56,
                    decoration: ShapeDecoration(
                      image: const DecorationImage(
                        image: NetworkImage("https://placehold.co/56x205"),
                        fit: BoxFit.cover,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // 퀴즈 정보 + 즉시 시작(▶) 버튼
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 설명 텍스트
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '카테고리 이름',
                      style: TextStyle(
                        color: const Color(0xFF1D1B20),
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 1.50,
                        letterSpacing: 0.50,
                      ),
                    ),
                    Text(
                      '난이도: 쉬움 • 최근 점수 8/10',
                      style: TextStyle(
                        color: const Color(0xFF49454F),
                        fontSize: 14,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 1.43,
                        letterSpacing: 0.25,
                      ),
                    ),
                  ],
                ),
              ),

              // 재생 버튼
              InkWell(
                customBorder: const CircleBorder(),
                onTap: () {
                  context.push(R.quiz);
                },
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: const ShapeDecoration(
                    color: Color(0xFFE8DEF8),
                    shape: CircleBorder(),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.play_arrow_rounded,
                    size: 28,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// =====================================================
// 하단 네비게이션 바 아이템 (2개만 남김)
// =====================================================
class _BottomNavItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool active;
  final VoidCallback onTap;

  const _BottomNavItem({
    required this.label,
    required this.icon,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color activeBg = const Color(0xFFE8DEF8); // Secondary-Container
    final Color activeText = const Color(0xFF625B71); // Secondary
    final Color inactiveText = const Color(0xFF49454F); // On-Surface-Variant

    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: onTap,
            child: Container(
              width: 56,
              height: 32,
              decoration: BoxDecoration(
                color: active ? activeBg : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.center,
              child: Icon(
                icon,
                size: 24,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 4),
          SizedBox(
            width: 80,
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: active ? activeText : inactiveText,
                fontSize: 12,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                height: 1.33,
                letterSpacing: 0.50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
