import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'homescreen.dart';
import '../state/survey_controller.dart';

class Testscreen8 extends StatefulWidget {
  const Testscreen8({super.key});

  @override
  State<Testscreen8> createState() => _Testscreen8State();
}

class _Testscreen8State extends State<Testscreen8> {
  final TextEditingController _toneController = TextEditingController();

  @override
  void dispose() {
    _toneController.dispose();
    super.dispose();
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
                    '사용자 기본 정보',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                '상대의 평상시 말투',
                style: TextStyle(
                  color: Color(0xFF2E5AAC),
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                '직접 입력',
                style: TextStyle(
                  color: Color(0xFF2E5AAC),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFE6E9EE),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: TextField(
                  controller: _toneController,
                  decoration: const InputDecoration(
                    hintText: '남/여',
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                '사진 첨부',
                style: TextStyle(
                  color: Color(0xFF2E5AAC),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              InkWell(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('사진 첨부 기능은 추후 추가 예정입니다.')),
                  );
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE6E9EE),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
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
                      onPressed: () {
                        SurveyController.to.desiredWords = _toneController.text
                            .trim();
                        Get.offAll(() => const Homescreen());
                      },
                      child: const Text('완료'),
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
