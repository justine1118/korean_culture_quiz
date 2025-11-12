import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

enum Difficulty { easy, medium, hard }

class _SignupScreenState extends State<SignupScreen> {
  final _bg = const Color(0xFFEDE8E3);
  final _btn = const Color(0xFF4E7C88);

  int step = 0;

  // 회원가입 폼
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _pwCtrl = TextEditingController();
  final _pw2Ctrl = TextEditingController();

  // 난이도 / 학습량
  Difficulty? _difficulty;
  int? _dailyCount;

  // (보존용) 검증 함수 — 지금은 사용하지 않음
  bool _validateAndNextFromSignup() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => step = 1);
      return true;
    }
    return false;
  }

  void _nextFromDifficulty() {
    if (_difficulty == null) {
      _showSnack('난이도를 선택해 주세요.');
      return;
    }
    setState(() => step = 2);
  }

  void _nextFromStudyAmount() {
    if (_dailyCount == null) {
      _showSnack('하루 학습 문제 수를 선택해 주세요.');
      return;
    }
    setState(() => step = 3);
  }

  void _showSnack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _pwCtrl.dispose();
    _pw2Ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: _buildStep(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              child: Row(
                children: [
                  if (step > 0 && step < 3)
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => setState(() => step -= 1),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: BorderSide(color: _btn),
                          foregroundColor: Colors.white,
                          backgroundColor: _btn.withOpacity(0.4),
                        ),
                        child: const Text('이전'),
                      ),
                    ),
                  if (step > 0 && step < 3) const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (step == 0) {
                          // ✅ 검증 없이 다음 단계로 이동
                          setState(() => step = 1);
                          // 필요 시 검증을 다시 켜려면 위 한 줄을 아래로 교체:
                          // _validateAndNextFromSignup();
                        } else if (step == 1) {
                          _nextFromDifficulty();
                        } else if (step == 2) {
                          _nextFromStudyAmount();
                        } else {
                          _showSnack('온보딩 완료! (메인으로 이동 로직 연결)');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _btn,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: Text(
                        step < 3 ? '다음' : '메인 페이지로',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
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
    );
  }

  Widget _buildStep() {
    switch (step) {
      case 0:
        return _SignupStep(
          key: const ValueKey('signup'),
          formKey: _formKey,
          nameCtrl: _nameCtrl,
          emailCtrl: _emailCtrl,
          pwCtrl: _pwCtrl,
          pw2Ctrl: _pw2Ctrl,
        );
      case 1:
        return _DifficultyStep(
          key: const ValueKey('difficulty'),
          selected: _difficulty,
          onSelect: (d) => setState(() => _difficulty = d),
        );
      case 2:
        return _StudyAmountStep(
          key: const ValueKey('study'),
          selected: _dailyCount,
          onSelect: (c) => setState(() => _dailyCount = c),
        );
      case 3:
      default:
        return _CompleteStep(
          key: const ValueKey('complete'),
          name: _nameCtrl.text,
          difficulty: _difficulty,
          count: _dailyCount,
        );
    }
  }
}

//
// ========= Step 0: 회원가입 =========
//
class _SignupStep extends StatelessWidget {
  const _SignupStep({
    super.key,
    required this.formKey,
    required this.nameCtrl,
    required this.emailCtrl,
    required this.pwCtrl,
    required this.pw2Ctrl,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController nameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController pwCtrl;
  final TextEditingController pw2Ctrl;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 캐릭터 + 문장 (가로)
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/tiger_image.png', width: 80, height: 80),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  '한국 문화 교육을 위한 앱, HanQ입니다.\n환영합니다!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    height: 1.3,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Form(
            key: formKey,
            child: Column(
              children: [
                _InputField(
                  label: '사용자 명을 입력하세요.',
                  controller: nameCtrl,
                  keyboardType: TextInputType.name,
                  validator: (v) =>
                  (v == null || v.trim().isEmpty) ? '이름을 입력해 주세요.' : null,
                ),
                const SizedBox(height: 16),
                _InputField(
                  label: '이메일을 입력하세요.',
                  controller: emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return '이메일을 입력해 주세요.';
                    final ok = RegExp(r'^\S+@\S+\.\S+$').hasMatch(v.trim());
                    return ok ? null : '올바른 이메일 형식이 아닙니다.';
                  },
                ),
                const SizedBox(height: 16),
                _InputField(
                  label: '비밀번호를 입력하세요.',
                  controller: pwCtrl,
                  obscureText: true,
                  validator: (v) {
                    if (v == null || v.length < 6) return '6자 이상 입력해 주세요.';
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _InputField(
                  label: '비밀번호를 다시 입력하세요.',
                  controller: pw2Ctrl,
                  obscureText: true,
                  validator: (v) {
                    if (v != pwCtrl.text) return '비밀번호가 일치하지 않습니다.';
                    return null;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//
// ========= Step 1: 난이도 선택 =========
//
class _DifficultyStep extends StatelessWidget {
  const _DifficultyStep({
    super.key,
    required this.selected,
    required this.onSelect,
  });

  final Difficulty? selected;
  final void Function(Difficulty) onSelect;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _HeaderWithTiger(title: '맞춤형 퀴즈 난이도를 설정할게요!'),
          const SizedBox(height: 16),
          _ChoiceButton(
            title: '쉬움',
            subtitle: '기초적인 상식 수준의 퀴즈',
            selected: selected == Difficulty.easy,
            onTap: () => onSelect(Difficulty.easy),
          ),
          const SizedBox(height: 12),
          _ChoiceButton(
            title: '중간',
            subtitle: '기본 상식과 중간 수준의 퀴즈',
            selected: selected == Difficulty.medium,
            onTap: () => onSelect(Difficulty.medium),
          ),
          const SizedBox(height: 12),
          _ChoiceButton(
            title: '어려움',
            subtitle: '어려운 수준의 상식 퀴즈',
            selected: selected == Difficulty.hard,
            onTap: () => onSelect(Difficulty.hard),
          ),
        ],
      ),
    );
  }
}

//
// ========= Step 2: 학습량 선택 =========
//
class _StudyAmountStep extends StatelessWidget {
  const _StudyAmountStep({
    super.key,
    required this.selected,
    required this.onSelect,
  });

  final int? selected;
  final void Function(int) onSelect;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 40, 20, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _HeaderWithTiger(title: '하루 퀴즈 문제 분량을 설정할게요!'),
          const SizedBox(height: 16),
          for (final n in const [3, 5, 7, 9]) ...[
            _ChoiceButton(
              title: '$n 문제',
              subtitle: n <= 5 ? '부담 없이 가볍게' : '꾸준히 실력 향상',
              selected: selected == n,
              onTap: () => onSelect(n),
            ),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

//
// ========= Step 3: 완료 =========
//
class _CompleteStep extends StatelessWidget {
  const _CompleteStep({
    super.key,
    required this.name,
    required this.difficulty,
    required this.count,
  });

  final String name;
  final Difficulty? difficulty;
  final int? count;

  String get _diffLabel {
    switch (difficulty) {
      case Difficulty.easy:
        return '쉬움';
      case Difficulty.medium:
        return '중간';
      case Difficulty.hard:
        return '어려움';
      default:
        return '-';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/tiger_image.png', width: 150, height: 150),
            const SizedBox(height: 24),
            const Text(
              '설정이 완료되었어요!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Text(
              '$name 님의 설정\n난이도: $_diffLabel • 하루 ${count ?? '-'}문제',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            const Text('이제 메인 페이지로 이동합니다.',
                style: TextStyle(color: Colors.black54)),
          ],
        ),
      ),
    );
  }
}

//
// ---------- 공용 위젯 ----------
//
class _HeaderWithTiger extends StatelessWidget {
  const _HeaderWithTiger({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset('assets/images/tiger_image.png', width: 72, height: 72),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

class _ChoiceButton extends StatelessWidget {
  const _ChoiceButton({
    super.key,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  static const _selectedBg = Color(0xFF9EB2B6);
  static const _unselectedBg = Color(0xFFF7F8F9);
  static const _border = Color(0xFFE8ECF4);

  @override
  Widget build(BuildContext context) {
    final bg = selected ? _selectedBg : _unselectedBg;
    final titleColor = selected ? Colors.white : Colors.black;
    final subColor = selected ? Colors.white70 : Colors.black54;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Ink(
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _border, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: titleColor,
                  )),
              const SizedBox(height: 4),
              Text(subtitle, style: TextStyle(color: subColor)),
            ],
          ),
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  const _InputField({
    required this.label,
    required this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
  });

  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      enableSuggestions: false,
      autocorrect: false,
      contextMenuBuilder: (context, editableTextState) => const SizedBox.shrink(),
      decoration: InputDecoration(
        hintText: label,
        filled: true,
        fillColor: const Color(0xFFF6F7F8),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFE8ECF4)),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFF9EB2B6)),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
