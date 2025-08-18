import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'testscreen5.dart';
import '../state/survey_controller.dart';

class Testscreen4 extends StatefulWidget {
  const Testscreen4({super.key});

  @override
  State<Testscreen4> createState() => _Testscreen4State();
}

class _Testscreen4State extends State<Testscreen4> {
  int? _year;
  int? _month;
  int? _day;

  List<int> get _years {
    final now = DateTime.now().year;
    return List<int>.generate(51, (i) => now - i); // 최근 50년 + 올해
  }

  List<int> get _months => List<int>.generate(12, (i) => i + 1);

  List<int> get _days {
    final month = _month ?? 1;
    final year = _year ?? DateTime.now().year;
    final lastDay = DateTime(year, month + 1, 0).day;
    return List<int>.generate(lastDay, (i) => i + 1);
  }

  DateTime? get _selectedDate {
    if (_year == null || _month == null || _day == null) return null;
    return DateTime(_year!, _month!, _day!);
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
                '이별 날짜',
                style: TextStyle(
                  color: Color(0xFF2E5AAC),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFE6E9EE),
                  borderRadius: BorderRadius.circular(6),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  children: [
                    Expanded(
                      child: _DropdownField<int>(
                        value: _year,
                        hint: '년',
                        items: _years
                            .map(
                              (y) => DropdownMenuItem<int>(
                                value: y,
                                child: Text('$y'),
                              ),
                            )
                            .toList(),
                        onChanged: (v) => setState(() {
                          _year = v;
                          if (_day != null && _day! > _days.length) {
                            _day = _days.length;
                          }
                        }),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _DropdownField<int>(
                        value: _month,
                        hint: '월',
                        items: _months
                            .map(
                              (m) => DropdownMenuItem<int>(
                                value: m,
                                child: Text('$m'),
                              ),
                            )
                            .toList(),
                        onChanged: (v) => setState(() {
                          _month = v;
                          if (_day != null && _day! > _days.length) {
                            _day = _days.length;
                          }
                        }),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _DropdownField<int>(
                        value: _day,
                        hint: '일',
                        items: _days
                            .map(
                              (d) => DropdownMenuItem<int>(
                                value: d,
                                child: Text('$d'),
                              ),
                            )
                            .toList(),
                        onChanged: (v) => setState(() => _day = v),
                      ),
                    ),
                  ],
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
                        final date = _selectedDate;
                        if (date == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('이별 날짜를 선택해 주세요.')),
                          );
                          return;
                        }
                        SurveyController.to.breakupDate = date;
                        Get.to(() => const Testscreen5());
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

class _DropdownField<T> extends StatelessWidget {
  final T? value;
  final String hint;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
  const _DropdownField({
    required this.value,
    required this.hint,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.0),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          isExpanded: true,
          value: value,
          hint: Text(hint),
          items: items,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
