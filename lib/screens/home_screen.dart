import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  /// 주간 학습량(월~일)
  List<double> weeklyData = [2.5, 3.0, 4.2, 3.5, 5.0, 4.8, 3.3];

  void setWeeklyData(List<double> data) {
    if (data.length != 7) return;
    setState(() => weeklyData = data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDE8E3),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== 상단: 환영합니다 =====
              Row(
                children: const [
                  Icon(Icons.wb_sunny_outlined, size: 18, color: Color(0xFF6B6B6B)),
                  SizedBox(width: 6),
                  Text(
                    '환영합니다!',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF6B6B6B),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // ===== 헤더 =====
              _HeaderSection(
                tierCard: _InfoCard(
                  // 왼쪽 아이콘 제거
                  leading: const SizedBox.shrink(),
                  // ✅ 제목 오른쪽에 이모지 배치
                  title: '내 티어: 새싹',
                  titleWidget: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        '내 티어: 새싹',
                        style: TextStyle(
                          color: Color(0xFF2C2C2C),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(width: 6),
                      Text('🌱', style: TextStyle(fontSize: 26)),
                    ],
                  ),
                  subtitle: '퀴즈를 풀어 단계를 올려보세요!',
                  onTap: () {},
                  showChevron: false,
                  backgroundColor: Colors.white,
                  // ✅ 티어 카드 전용: 세로 패딩 축소로 아래 여백 제거
                  contentPadding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                ),
              ),

              const SizedBox(height: 16),

              // 오늘의 퀴즈 카드 (🎓 배경/테두리 없음, 크게)
              _InfoCard(
                leading: const _LargeEmoji(emoji: '🎓'),
                title: '오늘의 퀴즈',
                subtitle: '한국 사회 전반에 대한 정보를 담은 퀴즈!',
                onTap: () {},
                showChevron: false,
                backgroundColor: Colors.white,
              ),

              const SizedBox(height: 12),

              // 학습 현황
              _ChartCard(
                title: '내 학습 현황',
                child: _WeeklyStudyChart(weeklyData: weeklyData),
                onTap: () {},
                backgroundColor: Colors.white,
              ),
            ],
          ),
        ),
      ),

      // ===== 하단 네비게이션 (선택 시 타원 배경 + 아이콘 흰색) =====
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFEDE8E2),
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,

          // 라벨(텍스트) 색: 선택/비선택 구분
          selectedItemColor: const Color(0xFF2C2C2C),
          unselectedItemColor: const Color(0xFF6D6D6D),
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),

          // 아이콘 색은 _PillIcon 내부에서 직접 지정 (선택 시 흰색)
          items: [
            BottomNavigationBarItem(
              icon: const _PillIcon(icon: Icons.home_rounded, active: false),
              activeIcon: const _PillIcon(icon: Icons.home_rounded, active: true),
              label: '메인',
            ),
            BottomNavigationBarItem(
              icon: const _PillIcon(icon: Icons.lightbulb_outline, active: false),
              activeIcon: const _PillIcon(icon: Icons.lightbulb_outline, active: true),
              label: '정보 모음',
            ),
            BottomNavigationBarItem(
              icon: const _PillIcon(icon: Icons.bar_chart_rounded, active: false),
              activeIcon: const _PillIcon(icon: Icons.bar_chart_rounded, active: true),
              label: '학습 현황',
            ),
            BottomNavigationBarItem(
              icon: const _PillIcon(icon: Icons.settings_outlined, active: false),
              activeIcon: const _PillIcon(icon: Icons.settings_outlined, active: true),
              label: '설정',
            ),
          ],
        ),
      ),
    );
  }
}

/// ===== 상단 헤더 =====
class _HeaderSection extends StatelessWidget {
  final Widget tierCard;
  const _HeaderSection({required this.tierCard});

  @override
  Widget build(BuildContext context) {
    const double headerHeight = 180;
    return SizedBox(
      height: headerHeight,
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                  width: 100,
                  child: Image.asset(
                    'assets/images/tiger_image.png',
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: SizedBox(
                    height: 90,
                    child: tierCard, // ✅ tierCard 자체 패딩을 줄여 하단 여백 제거
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Color(0xFFB7D3D9),
                  child: Icon(Icons.person, color: Colors.white, size: 20),
                ),
                SizedBox(height: 6),
                Text(
                  '홍길동',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF2C2C2C),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// ===== 카드 공통 =====
class _InfoCard extends StatelessWidget {
  final Widget leading;
  final String title;
  final Widget? titleWidget; // ✅ 추가: 제목 자리에 커스텀 위젯 사용
  final String subtitle;
  final VoidCallback? onTap;
  final bool showChevron;
  final Color backgroundColor;
  final EdgeInsets contentPadding; // 내부 패딩 커스터마이즈

  const _InfoCard({
    required this.leading,
    required this.title,
    required this.subtitle,
    this.titleWidget,
    this.onTap,
    this.showChevron = true,
    this.backgroundColor = const Color(0xFFF6F1EB),
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: contentPadding,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              leading,
              // leading이 없을 때 좌우 간격을 과도하게 차지하지 않도록 보정
              if (leading is! SizedBox) const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ✅ titleWidget이 있으면 우선 사용
                    titleWidget ??
                        Text(
                          title,
                          style: const TextStyle(
                            color: Color(0xFF2C2C2C),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Color(0xFF9B9B9B),
                        fontSize: 13,
                        height: 1.1,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (showChevron)
                const Icon(Icons.chevron_right_rounded, color: Color(0xFF9B9B9B)),
            ],
          ),
        ),
      ),
    );
  }
}

/// ===== 그래프 카드 =====
class _ChartCard extends StatelessWidget {
  final String title;
  final Widget child;
  final VoidCallback? onTap;
  final Color backgroundColor;

  const _ChartCard({
    required this.title,
    required this.child,
    this.onTap,
    this.backgroundColor = const Color(0xFFF6F1EB),
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(14, 14, 10, 12),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Color(0xFF212121),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const Icon(Icons.chevron_right_rounded, color: Color(0xFF9B9B9B)),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(height: 220, child: child),
            ],
          ),
        ),
      ),
    );
  }
}

/// ===== 배경/테두리 없는 큰 이모티콘 =====
class _LargeEmoji extends StatelessWidget {
  final String emoji;
  const _LargeEmoji({required this.emoji});

  @override
  Widget build(BuildContext context) {
    return Text(
      emoji,
      style: const TextStyle(fontSize: 56),
    );
  }
}

/// ===== 새싹 배지 (텍스트 크기 맞춤 + 여백 최소화) =====
class _EmojiBadge extends StatelessWidget {
  final String emoji;
  const _EmojiBadge({required this.emoji});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4),
      child: Text(
        emoji,
        style: const TextStyle(
          fontSize: 30, // 텍스트 높이에 자연스럽게 어울리는 크기
        ),
      ),
    );
  }
}

/// ===== 네비게이션: 아이콘 뒤 타원 배경 위젯 =====
class _PillIcon extends StatelessWidget {
  final IconData icon;
  final bool active;
  const _PillIcon({required this.icon, required this.active});

  @override
  Widget build(BuildContext context) {
    const pillColor = Color(0xFF4E7C88); // 선택 배경
    final iconColor = active ? Colors.white : const Color(0xFF6D6D6D);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      padding: EdgeInsets.symmetric(
        horizontal: active ? 12 : 0,
        vertical: active ? 6 : 0,
      ),
      decoration: BoxDecoration(
        color: active ? pillColor : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Icon(icon, color: iconColor),
    );
  }
}

/// ===== 막대 그래프 (점선 + y축 제거) =====
class _WeeklyStudyChart extends StatelessWidget {
  final List<double> weeklyData;

  const _WeeklyStudyChart({required this.weeklyData});

  @override
  Widget build(BuildContext context) {
    const days = ['월', '화', '수', '목', '금', '토', '일'];

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 6,
        minY: 0,
        titlesData: FlTitlesData(
          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, _) => Text(
                days[value.toInt()],
                style: const TextStyle(fontSize: 11),
              ),
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        gridData: const FlGridData(show: false),
        barGroups: List.generate(
          weeklyData.length,
              (i) => BarChartGroupData(
            x: i,
            barRods: [
              BarChartRodData(
                toY: weeklyData[i],
                width: 18,
                borderRadius: BorderRadius.circular(4),
                color: const Color(0xFF4E7C88),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
