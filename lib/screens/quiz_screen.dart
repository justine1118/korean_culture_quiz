import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// ===== 모델 =====
class Choice {
  final String text;
  final String explanation;
  final bool isAnswer;
  const Choice(this.text, {required this.explanation, this.isAnswer = false});
}

class Question {
  final String title;
  final List<Choice> choices;
  const Question({required this.title, required this.choices});
  int get answerIndex => choices.indexWhere((c) => c.isAnswer);
}

/// ===== 컨트롤러 =====
enum QuizStage { question, feedback }

class QuizController {
  final List<Question> questions;

  int index = 0;
  int? selected;        // 화면에 현재 보이는 선택
  int? firstSelected;   // ✅ 채점에 쓰일 '처음 선택'
  int correctCount = 0;
  QuizStage stage = QuizStage.question;

  QuizController(this.questions);

  Question get q => questions[index];
  int get total => questions.length;
  bool get isLast => index == total - 1;
  bool get hasSelection => selected != null;
  bool get isCorrectNow => selected != null && selected == q.answerIndex;           // 화면 표시용
  bool get isFirstCorrect => firstSelected != null && firstSelected == q.answerIndex; // 채점용
  double get progress => (index + 1) / total;
  Choice? get selectedChoice => (selected == null) ? null : q.choices[selected!];

  /// ✅ 언제든 다른 선지로 변경 가능
  /// 처음 선택일 때만 firstSelected를 기록(채점에 사용)
  void select(int i) {
    if (stage == QuizStage.question) {
      stage = QuizStage.feedback;
    }
    selected ??= i;      // 화면 첫 선택 기록
    firstSelected ??= i; // ✅ 채점용 첫 선택 기록(이미 있으면 유지)
    selected = i;        // 화면용 현재 선택은 언제든 변경 가능
  }

  /// ✅ 다음 문제로 진행(채점은 '처음 선택' 기준)
  bool next() {
    if (stage != QuizStage.feedback) return false;

    if (isFirstCorrect) correctCount++;

    if (isLast) return true;

    index++;
    selected = null;
    firstSelected = null;   // ✅ 다음 문제에서 다시 초기화
    stage = QuizStage.question;
    return false;
  }
}

/// ===== 화면 =====
class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late final QuizController c;

  @override
  void initState() {
    super.initState();
    c = QuizController(const [
      Question(
        title: '다음은 한국의 문화와 전통에 대한 문제이다.\n다음 중 한국의 대표적인 요리가 아닌 것은?',
        choices: [
          Choice('불고기', explanation: '불고기는 한국의 대표적인 구이 요리입니다. 따라서 정답이 아닙니다.'),
          Choice('비빔밥', explanation: '비빔밥은 한국의 대표적인 혼합밥 요리입니다. 따라서 정답이 아닙니다.'),
          Choice('동파육',
              explanation: '동파육은 중국 요리로, 돼지고기를 간장과 설탕으로 졸여 만든 음식입니다.', isAnswer: true),
          Choice('삼계탕',
              explanation: '삼계탕은 닭과 인삼, 대추, 찹쌀 등을 넣고 끓이는 한국 보양식입니다. 정답이 아닙니다.'),
        ],
      ),
      Question(
        title: '추석에 즐기는 대표적인 민속놀이는?',
        choices: [
          Choice('크리켓', explanation: '크리켓은 한국의 전통 민속놀이가 아닙니다.'),
          Choice('윷놀이', explanation: '윷놀이는 한국의 전통 보드게임으로 명절에 즐깁니다.', isAnswer: true),
          Choice('하키', explanation: '하키는 한국 전통 민속놀이가 아닙니다.'),
          Choice('럭비', explanation: '럭비는 한국의 전통 민속놀이는 아닙니다.'),
        ],
      ),
    ]);
  }

  /// 선택한 타일만 강조(정답/오답을 전체에 드러내지 않음)
  Color _optionBg(int i) {
    if (c.stage == QuizStage.feedback && c.selected != null) {
      if (i == c.selected) {
        return c.isCorrectNow ? const Color(0xFF6D9E8D) : const Color(0xFFCC8275);
      }
    }
    return const Color(0xFFF4F3F6);
  }

  void _onTapChoice(int i) => setState(() => c.select(i));

  void _onTapNext() {
    if (c.stage != QuizStage.feedback) return;
    final goResult = c.next();
    if (goResult && mounted) {
      context.go('/quiz/result', extra: {'total': c.total, 'correct': c.correctCount});
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final double filledWidth = 300 * c.progress;
    final bool nextEnabled = c.stage == QuizStage.feedback && c.hasSelection;

    return Scaffold(
      backgroundColor: const Color(0xFFEDE8E3),
      body: SafeArea(
        child: Center(
          child: Container(
            width: 375,
            height: 812,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(color: Color(0xFFEDE8E3)),
            child: Stack(
              children: [
                // 상단 타이틀
                const Positioned(
                  left: 143,
                  top: 56,
                  child: Text(
                    '오늘의 퀴즈',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                // 진행바
                Positioned(
                  left: 20,
                  top: 104,
                  child: Container(
                    width: 300,
                    height: 12,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F3F6),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                Positioned(
                  left: 20,
                  top: 104,
                  child: Container(
                    width: filledWidth.clamp(0, 300),
                    height: 12,
                    decoration: BoxDecoration(
                      color: const Color(0xFF4E7C88),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                Positioned(
                  left: 332,
                  top: 100,
                  child: Text(
                    '${c.index + 1}/${c.total}',
                    style: const TextStyle(
                      color: Color(0xFF757575),
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                // 문제
                Positioned(
                  left: 20,
                  top: 160,
                  child: SizedBox(
                    width: 335,
                    child: Text(
                      c.q.title,
                      style: const TextStyle(
                        color: Color(0xFF2C2C2C),
                        fontSize: 17,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w600,
                        height: 1.76,
                      ),
                    ),
                  ),
                ),

                // 피드백 패널(선택한 보기의 해설만 표시)
                if (c.stage == QuizStage.feedback && c.selectedChoice != null)
                  Positioned(
                    left: 22,
                    top: 243,
                    child: Container(
                      width: 333,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: c.isCorrectNow ? const Color(0xFF6D9E8D) : const Color(0xFFCC8275),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/tiger_image.png',
                            width: 60,
                            height: 60,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              c.isCorrectNow
                                  ? '정답입니다! ${c.selectedChoice!.explanation}'
                                  : '오답입니다. ${c.selectedChoice!.explanation}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w600,
                                height: 1.54,
                              ),
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                // 보기(항상 onTap 허용: 자유롭게 갈아탈 수 있음)
                for (int i = 0; i < c.q.choices.length; i++)
                  Positioned(
                    left: 20,
                    top: 414 + (i * 70),
                    child: _OptionTile(
                      letter: String.fromCharCode(65 + i),
                      text: c.q.choices[i].text,
                      color: _optionBg(i),
                      isSelected: c.selected == i,
                      onTap: () => _onTapChoice(i),
                    ),
                  ),

                // 하단 버튼
                Positioned(
                  left: 20,
                  top: 694,
                  child: GestureDetector(
                    onTap: nextEnabled ? _onTapNext : null,
                    child: Container(
                      width: 335,
                      height: 60,
                      decoration: BoxDecoration(
                        color: nextEnabled ? const Color(0xFF4E7C88) : const Color(0xFFB0BEC5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        (c.isLast && c.stage == QuizStage.feedback) ? '결과 보기' : '계속',
                        style: const TextStyle(
                          color: Color(0xFFF4F3F6),
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// 보기 타일
class _OptionTile extends StatelessWidget {
  final String letter;
  final String text;
  final Color color;
  final bool isSelected;
  final VoidCallback? onTap;

  const _OptionTile({
    required this.letter,
    required this.text,
    required this.color,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        width: 335,
        height: 60,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            // 왼쪽 동그라미
            Positioned(
              left: 16,
              top: 12,
              child: Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: Color(0xFFEDE8E3),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: isSelected
                    ? const Icon(Icons.check, size: 20, color: Color(0xFF4E7C88))
                    : Text(
                  letter,
                  style: const TextStyle(
                    color: Color(0xFF060710),
                    fontSize: 16,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            // 보기 텍스트
            Positioned(
              left: 70,
              top: 20,
              child: Text(
                text,
                style: const TextStyle(
                  color: Color(0xFF2C2C2C),
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
