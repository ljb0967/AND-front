import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'testscreen2.dart';

class Testscreen extends StatefulWidget {
  const Testscreen({super.key});

  @override
  State<Testscreen> createState() => _TestscreenState();
}

class _TestscreenState extends State<Testscreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String? _gender; // '남' or '여'

  bool _isNumeric(String value) => RegExp(r'^\d+$').hasMatch(value);
  bool get _canProceed {
    final name = _nameController.text.trim();
    final age = _ageController.text.trim();
    return name.isNotEmpty && _isNumeric(age) && _gender != null;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
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
                '이름',
                style: TextStyle(
                  color: Color(0xFF2E5AAC),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              _GreyField(
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                '나이(숫자만)',
                style: TextStyle(
                  color: Color(0xFF2E5AAC),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              _GreyField(
                child: TextField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                '성별',
                style: TextStyle(
                  color: Color(0xFF2E5AAC),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              _GreyField(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    hint: const Text('남/여'),
                    value: _gender,
                    isExpanded: true,
                    items: const [
                      DropdownMenuItem(value: '남', child: Text('남')),
                      DropdownMenuItem(value: '여', child: Text('여')),
                    ],
                    onChanged: (v) {
                      setState(() => _gender = v);
                    },
                    padding: const EdgeInsets.symmetric(horizontal: 12),
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
                        if (_canProceed) {
                          Get.to(() => const Testscreen2());
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('이름, 나이(숫자), 성별을 입력해 주세요.'),
                            ),
                          );
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

class _GreyField extends StatelessWidget {
  final Widget child;
  const _GreyField({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFE6E9EE),
        borderRadius: BorderRadius.circular(6),
      ),
      child: child,
    );
  }
}
