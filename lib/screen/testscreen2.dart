import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'testscreen3.dart';
import 'testscreen2_1.dart';
import '../state/survey_controller.dart';

class Testscreen2 extends StatefulWidget {
  const Testscreen2({super.key});

  @override
  State<Testscreen2> createState() => _Testscreen2State();
}

class _Testscreen2State extends State<Testscreen2> {
  String? _selected; // '가족', '연인', '반려동물', '친구'

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
                '이별 상대 선택',
                style: TextStyle(
                  color: Color(0xFF2E5AAC),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              _RadioLine(
                title: '가족',
                groupValue: _selected,
                onChanged: (v) => setState(() => _selected = v),
              ),
              const SizedBox(height: 12),
              _RadioLine(
                title: '연인',
                groupValue: _selected,
                onChanged: (v) => setState(() => _selected = v),
              ),
              const SizedBox(height: 12),
              _RadioLine(
                title: '반려동물',
                groupValue: _selected,
                onChanged: (v) => setState(() => _selected = v),
              ),
              const SizedBox(height: 12),
              _RadioLine(
                title: '친구',
                groupValue: _selected,
                onChanged: (v) => setState(() => _selected = v),
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
                        if (_selected == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('이별 상대를 선택해 주세요.')),
                          );
                          return;
                        }
                        SurveyController.to.relationshipCategory = _selected;
                        if (_selected == '가족') {
                          Get.to(() => const Testscreen2_1());
                        } else {
                          Get.to(() => const Testscreen3());
                        }
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

class _RadioLine extends StatelessWidget {
  final String title;
  final String? groupValue;
  final ValueChanged<String?> onChanged;
  const _RadioLine({
    required this.title,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<String>(
          value: title,
          groupValue: groupValue,
          onChanged: onChanged,
          visualDensity: VisualDensity.compact,
          fillColor: MaterialStateProperty.all(const Color(0xFFDCE6FA)),
        ),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF2E5AAC),
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
