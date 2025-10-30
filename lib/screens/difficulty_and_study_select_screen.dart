import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../router.dart';

class DifficultyAndStudySelectScreen extends StatefulWidget {
  const DifficultyAndStudySelectScreen({super.key});

  @override
  State<DifficultyAndStudySelectScreen> createState() => _DifficultyAndStudySelectScreenState();
}

class _DifficultyAndStudySelectScreenState extends State<DifficultyAndStudySelectScreen> {
  // 선택 상태 저장
  String? _selectedDifficulty;
  String? _selectedStudyAmount;

  final List<String> difficultyOptions = ['쉬움', '보통', '어려움'];
  final List<String> studyOptions = ['학습량 1', '학습량 2', '학습량 3', '학습량 4', '학습량 5'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // 전체 흰색
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        title: const Text(
          '한국 문화 퀴즈',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 난이도 설정 섹션
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 12),
            child: Text(
              '난이도 설정',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                height: 1.4,
              ),
            ),
          ),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: difficultyOptions.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (_, i) {
              final option = difficultyOptions[i];
              final isSelected = _selectedDifficulty == option;

              return OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.black, width: 1), // 검은 테두리
                  backgroundColor: isSelected ? Colors.grey[200] : Colors.white, // 선택되면 연한 회색
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _selectedDifficulty = option;
                  });
                },
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    option,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                      color: Colors.black,
                    ),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 24),

          // 학습량 설정 섹션
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Text(
              '학습량 설정',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                height: 1.4,
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: studyOptions.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (_, i) {
                final option = studyOptions[i];
                final isSelected = _selectedStudyAmount == option;

                return OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Colors.black, width: 1),
                    backgroundColor: isSelected ? Colors.grey[200] : Colors.white,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedStudyAmount = option;
                    });
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      option,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                        color: Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // 확인 버튼 (둘 다 고른 뒤 확정)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.black, width: 1),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  // 여기서 실제로 선택 결과를 다음 화면으로 넘기고 싶으면
                  // queryParam, extra, stateful provider 등 네 방식으로 전달하면 됨.
                  // 지금은 기존 흐름 유지: 캐릭터 선택 화면으로 이동
                  context.go(R.characterSelect);
                },
                child: const Text(
                  '확인',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
