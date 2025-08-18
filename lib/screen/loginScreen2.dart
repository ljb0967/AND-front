import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'testscreen.dart';

class LoginScreen2 extends StatefulWidget {
  const LoginScreen2({super.key});

  @override
  State<LoginScreen2> createState() => _LoginScreen2State();
}

class _LoginScreen2State extends State<LoginScreen2> {
  bool requiredA = true;
  bool requiredB = false;
  bool optionalA = false;
  bool optionalB = false;
  bool allAgree = false;

  bool get isAllRequiredChecked => requiredA && requiredB;

  void _syncAllAgree() {
    setState(() {
      allAgree = requiredA && requiredB && optionalA && optionalB;
    });
  }

  void _toggleAll(bool value) {
    setState(() {
      allAgree = value;
      requiredA = value;
      requiredB = value;
      optionalA = value;
      optionalB = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF5FF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  '&',
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.blue.shade200,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    '약관 동의',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                '필수 동의 항목',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF5C6B8A),
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFE6E9EE),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: const Text('[필수] 서비스 이용약관 동의'),
                      value: requiredA,
                      onChanged: (v) {
                        setState(() => requiredA = v ?? false);
                        _syncAllAgree();
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: const Text('[필수] 개인정보 처리방침 동의'),
                      value: requiredB,
                      onChanged: (v) {
                        setState(() => requiredB = v ?? false);
                        _syncAllAgree();
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                '선택 동의 항목',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF5C6B8A),
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFE6E9EE),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: const Text('[선택] 마케팅 수신 동의'),
                      value: optionalA,
                      onChanged: (v) {
                        setState(() => optionalA = v ?? false);
                        _syncAllAgree();
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      title: const Text('[선택] 맞춤 추천 동의'),
                      value: optionalB,
                      onChanged: (v) {
                        setState(() => optionalB = v ?? false);
                        _syncAllAgree();
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Checkbox(
                    value: allAgree,
                    onChanged: (v) => _toggleAll(v ?? false),
                  ),
                  const SizedBox(width: 4),
                  const Text('전체 약관 동의하기'),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 88,
                    height: 36,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF5C84D5),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      onPressed: isAllRequiredChecked
                          ? () {
                              Get.to(() => const Testscreen());
                            }
                          : () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('필수 약관에 동의해 주세요.'),
                                ),
                              );
                            },
                      child: const Text('다음'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
