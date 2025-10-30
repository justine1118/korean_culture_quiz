import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 임시 더미 데이터 (나중에 상태로 빼면 됨)
    final double missionProgress = 0.42; // 42%
    final String selectedCharacterName = '캐릭터 1번';
    final String selectedCharacterImage = 'https://placehold.co/116x119';

    return Scaffold(
      backgroundColor: const Color(0xFFFEF7FF), // Schemes-Surface
      body: SafeArea(
        child: Center(
          child: Container(
            width: 455, // Figma 고정 폭
            decoration: ShapeDecoration(
              color: const Color(0xFFFEF7FF), // Surface
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 8,
                  strokeAlign: BorderSide.strokeAlignOutside,
                  color: Color(0xFFCAC4D0), // Outline-Variant
                ),
                borderRadius: BorderRadius.circular(28),
              ),
            ),
            child: SingleChildScrollView(
              // ← 세로 스크롤 가능해지는 부분
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ===== 상단바 헤더 영역 =====
                  Padding(
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
                            // TODO: 프로필/마이페이지로 바로 갈지 나중에 결정
                          },
                        ),
                        Row(
                          children: [
                            _roundIconButton(
                              icon: Icons.notifications_outlined,
                              onTap: () {
                                // TODO: 알림 페이지
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

                  // ===== 학습 현황 =====
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 타이틀 라인
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              Text(
                                '학습 현황',
                                style: TextStyle(
                                  color: const Color(0xFF1D1B20), // On-Surface
                                  fontSize: 22,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  height: 1.27,
                                ),
                              ),
                              const SizedBox(width: 8),
                              _roundIconButton(
                                icon: Icons.bar_chart,
                                size: 24,
                                bgColor: Colors.transparent,
                                onTap: () {
                                  context.push(R.learningStatus);
                                },
                              ),
                            ],
                          ),
                        ),

                        // 그래프 placeholder (학습 통계)
                        SizedBox(
                          width: double.infinity,
                          height: 167,
                          child: InkWell(
                            onTap: () {
                              context.push(R.learningStatus);
                            },
                            child: Center(
                              child: Text(
                                '막대그래프 들어갈 자리',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  height: 1.27,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ===== 퀴즈 =====
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 타이틀 라인
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              Text(
                                '퀴즈',
                                style: TextStyle(
                                  color: const Color(0xFF1D1B20),
                                  fontSize: 22,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  height: 1.27,
                                ),
                              ),
                              const SizedBox(width: 8),
                              _roundIconButton(
                                icon: Icons.quiz_outlined,
                                size: 24,
                                bgColor: Colors.transparent,
                                onTap: () {
                                  // TODO: 퀴즈 기록/리포트 화면이 별도로 생기면 연결
                                },
                              ),
                            ],
                          ),
                        ),

                        // 퀴즈 카드 영역 (큰 카드 + 작은 카드)
                        SizedBox(
                          height: 221,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // 왼쪽 큰 카드
                                Expanded(
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(28),
                                    onTap: () {
                                      // 현재는 바로 퀴즈 시작
                                      context.push(R.quiz);
                                    },
                                    child: Container(
                                      decoration: ShapeDecoration(
                                        image: const DecorationImage(
                                          image: NetworkImage(
                                              "https://placehold.co/359x205"),
                                          fit: BoxFit.cover,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(28),
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
                                    // 여기서도 바로 퀴즈 시작
                                    context.push(R.quiz);
                                  },
                                  child: Container(
                                    width: 56,
                                    decoration: ShapeDecoration(
                                      image: const DecorationImage(
                                        image: NetworkImage(
                                            "https://placehold.co/56x205"),
                                        fit: BoxFit.cover,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(28),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // 퀴즈 설명 + 시작 버튼
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 텍스트 정보
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

                              // 퀴즈 시작 버튼(동그라미)
                              InkWell(
                                customBorder: const CircleBorder(),
                                onTap: () {
                                  context.push(R.quiz);
                                },
                                child: Container(
                                  width: 48,
                                  height: 48,
                                  decoration: const ShapeDecoration(
                                    color: Color(0xFFE8DEF8), // Secondary-Container
                                    shape: CircleBorder(),
                                  ),
                                  child: const Icon(
                                    Icons.play_arrow_rounded,
                                    size: 28,
                                    color: Colors.black,
                                  ),
                                ),
                              ),

                              // 우측 여백(피그마에서 56 공간 있었던 부분)
                              const SizedBox(width: 56),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ===== 도전과제 달성률 =====
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 타이틀 라인
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              Text(
                                '도전과제 달성률',
                                style: TextStyle(
                                  color: const Color(0xFF1D1B20),
                                  fontSize: 22,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  height: 1.27,
                                ),
                              ),
                              const SizedBox(width: 8),
                              _roundIconButton(
                                icon: Icons.emoji_events_outlined,
                                size: 24,
                                bgColor: Colors.transparent,
                                onTap: () {
                                  context.push(R.achievements);
                                },
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        // 퍼센트 바 + % 텍스트 + 이미지 영역
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 채워지는 바
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: LinearProgressIndicator(
                                  value: missionProgress,
                                  minHeight: 20,
                                  backgroundColor: const Color(
                                      0xFFECE6F0), // Surface-Container-High
                                  // foreground color는 테마 primary 사용
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${(missionProgress * 100).round()}% 달성',
                                style: TextStyle(
                                  color: const Color(0xFF1D1B20),
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                  height: 1.43,
                                  letterSpacing: 0.10,
                                ),
                              ),
                              const SizedBox(height: 16),
                              // 도전과제 관련 이미지 / 배지 모음
                              Center(
                                child: Container(
                                  width: 309,
                                  height: 160,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "https://placehold.co/309x160"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ===== 내 캐릭터 =====
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 타이틀 라인
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            children: [
                              Text(
                                '내 캐릭터',
                                style: TextStyle(
                                  color: const Color(0xFF1D1B20),
                                  fontSize: 22,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  height: 1.27,
                                ),
                              ),
                              const SizedBox(width: 8),
                              _roundIconButton(
                                icon: Icons.chevron_right,
                                size: 24,
                                bgColor: Colors.transparent,
                                onTap: () {
                                  context.push(R.characterView);
                                },
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 8),

                        // 선택된 캐릭터 카드 하나만
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              context.push(R.characterView);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFECE6F0), // Surface-Container-High
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
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
                                  // 캐릭터 정보
                                  Expanded(
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
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // 끝: bottomNavigationBar는 아래 Scaffold에서 따로 고정으로 렌더링하니까
                  // 여기 Column 안에는 안 넣는다.
                ],
              ),
            ),
          ),
        ),
      ),

      // ===== 하단 네비게이션 바 (고정) =====
      bottomNavigationBar: Container(
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
                // 현재 화면
              },
            ),
            _BottomNavItem(
              label: '도전과제',
              icon: Icons.emoji_events_outlined,
              active: false,
              onTap: () {
                // 나중에 탭 네비 구조로 바꾸면 여기서 push 대신 탭 변경
                // context.push(R.achievements); <- 이렇게 할 수도 있음, 근데 아직은 보류 가능
              },
            ),
            _BottomNavItem(
              label: '마이 페이지',
              icon: Icons.person_outline,
              active: false,
              onTap: () {
                // 추후 마이페이지 라우팅
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// 둥근 아이콘 버튼 (헤더 오른쪽 톱니, 알림 등)
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
        child: Icon(icon, size: 24, color: Colors.black),
      ),
    ),
  );
}

/// 하단 네비게이션 한 칸
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
