import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../router.dart';

class CharacterSelectScreen extends StatefulWidget {
  const CharacterSelectScreen({super.key});

  @override
  State<CharacterSelectScreen> createState() => _CharacterSelectScreenState();
}

class _CharacterSelectScreenState extends State<CharacterSelectScreen> {
  // 어떤 캐릭터가 선택됐는지 인덱스로 기억 (-1이면 아직 선택 안 함)
  int _selectedIndex = -1;

  // 임시 데이터: 캐릭터 이름들
  final List<String> characterNames = [
    '캐릭터 1',
    '캐릭터 2',
    '캐릭터 3',
    '캐릭터 4',
    '캐릭터 5',
    '캐릭터 6',
    '캐릭터 7',
    '캐릭터 8',
    '캐릭터 9',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text(
          '한국 문화 퀴즈',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 섹션 타이틀
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Text(
              '캐릭터 선택',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                height: 1.3,
                color: Colors.black,
              ),
            ),
          ),

          // 캐릭터 그리드
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                itemCount: characterNames.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,          // 한 줄에 3개
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 0.8,      // 이미지+이름 비율
                ),
                itemBuilder: (context, index) {
                  final isSelected = _selectedIndex == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        // 선택 여부에 따라 테두리/배경 바뀜
                        color: isSelected ? Colors.grey[200] : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.black,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // 캐릭터 이미지 영역
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                // 실제 이미지 들어갈 자리
                                image: const DecorationImage(
                                  image: NetworkImage('https://placehold.co/100x100'),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 8),

                          // 캐릭터 이름
                          Text(
                            characterNames[index],
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              height: 1.4,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // 확인 버튼
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
                // 아무 것도 안 골랐으면 비활성화
                onPressed: _selectedIndex == -1
                    ? null
                    : () {
                  // TODO: 여기서 _selectedIndex나 characterNames[_selectedIndex]를
                  // 전역 상태 / Provider / 서버로 보내거나 저장하면 됨
                  context.go(R.home);
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
