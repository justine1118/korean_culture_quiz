import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../router.dart';
import '../DTO/login_request.dart';
import '../api/auth_api.dart';
import '../info/user_info.dart';  // 🔥 여기로 변경 (UserSession 사용)

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const _bgColor = Color(0xFFEDE8E3);
  static const _primaryColor = Color(0xFF4E7C88);

  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  bool _loginFailed = false; // 처음은 false로 시작

  @override
  void dispose() {
    _idController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  // ==========================
  // 🚀 실제 로그인 시도 함수
  // ==========================
  Future<void> _tryLogin() async {
    final email = _idController.text.trim();
    final pw = _pwController.text.trim();

    final request = LoginRequest(email: email, password: pw);

    final user = await AuthApi.login(request);

    if (user != null) {
      // ✅ 로그인 성공: 세션에 사용자 정보 저장
      UserInfo.setUser(user);

      // 메인 화면으로 이동
      context.go(R.main);
    } else {
      // ❌ 로그인 실패: 안내 문구 변경
      setState(() {
        _loginFailed = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 상단 X 버튼
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),

              const SizedBox(height: 8),

              // ====== 호랑이 왼쪽 + 텍스트 오른쪽 =======
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/tiger_image.png',
                    width: 120,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!_loginFailed)
                          const Text(
                            '한국 문화 교육을 위한 앱,\nHanQ입니다.\n환영합니다!',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        else
                          const Text(
                            '아이디 혹은 비밀번호가\n일치하지 않습니다.\n\n다시 입력해 주십시오',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // 아이디 입력
              TextField(
                controller: _idController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: '아이디를 입력하세요.',
                  border: OutlineInputBorder(),
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
              ),
              const SizedBox(height: 12),

              // 비밀번호 입력
              TextField(
                controller: _pwController,
                obscureText: true,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: '비밀번호를 입력하세요.',
                  border: OutlineInputBorder(),
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
              ),

              const SizedBox(height: 20),

              // 로그인 버튼
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _tryLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  child: const Text(
                    '로그인',
                    style: TextStyle(fontSize: 16),
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
