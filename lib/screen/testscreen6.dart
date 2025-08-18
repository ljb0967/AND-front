import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'testscreen7.dart';

class Testscreen6 extends StatefulWidget {
  const Testscreen6({super.key});

  @override
  State<Testscreen6> createState() => _Testscreen6State();
}

class _Testscreen6State extends State<Testscreen6> {
  String? _selected;

  List<String> get _reasons {
    // 연인 선택일 때의 예시 사유
    return const [
      '상대의 마음이 식었어요',
      '내가 마음이 떠났어요',
      '성격, 가치관 차이',
      '바람이나 배신',
      '상황/환경 문제',
      '정확히 모르겠어요 / 복합적이에요',
    ];
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
                    '이별 사유',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ..._reasons.map(
                (r) => Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: _RadioLine(
                    title: r,
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
                            const SnackBar(content: Text('이별 사유를 선택해 주세요.')),
                          );
                          return;
                        }
                        Get.to(() => const Testscreen7());
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
