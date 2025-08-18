import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'testscreen6.dart';
import 'testscreen6_1.dart';
import 'testscreen6_2.dart';
import 'testscreen6_3.dart';
import '../state/survey_controller.dart';

class Testscreen5 extends StatefulWidget {
  const Testscreen5({super.key});

  @override
  State<Testscreen5> createState() => _Testscreen5State();
}

class _Testscreen5State extends State<Testscreen5> {
  String? _selected; // 억누르기형/표출형/회피형/분석형

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
                '이별 대처 방안',
                style: TextStyle(
                  color: Color(0xFF2E5AAC),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              ...['억누르기형', '표출형', '회피형', '분석형'].map(
                (title) => Padding(
                  padding: const EdgeInsets.only(bottom: 14.0),
                  child: _RadioLine(
                    title: title,
                    groupValue: _selected,
                    onChanged: (v) => setState(() => _selected = v),
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
                        if (_selected == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('이별 대처 방안을 선택해 주세요.')),
                          );
                          return;
                        }
                        final cat = SurveyController.to.relationshipCategory;
                        if (cat == '가족') {
                          Get.to(() => const Testscreen6_1());
                        } else if (cat == '연인') {
                          Get.to(() => const Testscreen6());
                        } else if (cat == '친구') {
                          Get.to(() => const Testscreen6_2());
                        } else if (cat == '반려동물') {
                          Get.to(() => const Testscreen6_3());
                        } else {
                          // 기본: 연인 분기로
                          Get.to(() => const Testscreen6());
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
