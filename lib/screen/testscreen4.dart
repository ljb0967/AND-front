import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'testscreen5.dart';
import '../state/survey_controller.dart';
import 'testscreen3.dart';

class Testscreen4 extends StatefulWidget {
  const Testscreen4({super.key});

  @override
  State<Testscreen4> createState() => _Testscreen4State();
}

class _Testscreen4State extends State<Testscreen4> {
  DateTime _selectedDate = DateTime.now();
  DateTime _currentMonth = DateTime.now();

  bool get _canProceed {
    return !_selectedDate.isAfter(DateTime.now());
  }

  int get _elapsedDays {
    if (DateTime.now().difference(_selectedDate).inDays < 0) {
      return 0;
    }
    return DateTime.now().difference(_selectedDate).inDays;
  }

  String get _formattedSelectedDate {
    final weekdays = ['월', '화', '수', '목', '금', '토', '일'];
    final weekday = weekdays[_selectedDate.weekday - 1];
    return '${_selectedDate.year}년 ${_selectedDate.month}월 ${_selectedDate.day}일 $weekday요일';
  }

  void _selectDate(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
    });
  }

  List<DateTime> _getDaysInMonth() {
    final firstDayOfMonth = DateTime(
      _currentMonth.year,
      _currentMonth.month,
      1,
    );
    final lastDayOfMonth = DateTime(
      _currentMonth.year,
      _currentMonth.month + 1,
      0,
    );

    // 이전 달의 마지막 날들
    final firstWeekday = firstDayOfMonth.weekday;
    final daysFromPreviousMonth = firstWeekday - 1;
    final previousMonth = DateTime(
      _currentMonth.year,
      _currentMonth.month - 1,
      0,
    );

    List<DateTime> days = [];

    // 이전 달의 날들 추가
    for (int i = daysFromPreviousMonth - 1; i >= 0; i--) {
      days.add(previousMonth.subtract(Duration(days: i)));
    }

    // 현재 달의 날들 추가
    for (int i = 1; i <= lastDayOfMonth.day; i++) {
      days.add(DateTime(_currentMonth.year, _currentMonth.month, i));
    }

    // 다음 달의 첫날들 추가 (6주 표시를 위해)
    final remainingDays = 42 - days.length;
    for (int i = 1; i <= remainingDays; i++) {
      days.add(DateTime(_currentMonth.year, _currentMonth.month + 1, i));
    }

    return days;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double screenWidth = constraints.maxWidth;
            const double designWidth = 412.0;
            const double designHeight = 917.0;
            final double scale = screenWidth / designWidth;
            final double scaledHeight = designHeight * scale;

            final Widget scaledContent = FittedBox(
              alignment: Alignment.topLeft,
              fit: BoxFit.fitWidth,
              child: SizedBox(
                width: designWidth,
                height: scaledHeight,
                child: Container(
                  width: 412,
                  height: 917,
                  clipBehavior: Clip.none,
                  decoration: BoxDecoration(color: const Color(0xFF111111)),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        left: 32,
                        top: 132,
                        child: Text(
                          '함께한 사람과\n언제 이별하게 되셨나요?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            height: 1.40,
                            letterSpacing: -0.50,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 32,
                        top: 196,
                        child: Text(
                          'AND와의 여정을 위해 소중한 당신의 이야기를 들려주세요',
                          style: TextStyle(
                            color: const Color(0xFFBDC7DB),
                            fontSize: 14,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            height: 1.40,
                            letterSpacing: -0.35,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        top: 96,
                        child: Container(
                          width: 380,
                          height: 4,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF232529),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        top: 96,
                        child: Container(
                          width: 271.43,
                          height: 4,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF65A0FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 12,
                        top: 28,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(),
                              child: IconButton(
                                icon: Image.asset('image/arrow-left.png'),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                            ),
                            Text(
                              '함께한 기간 선택',
                              style: TextStyle(
                                color: const Color(0xFFBDC7DB),
                                fontSize: 14,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w500,
                                height: 1.40,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 20,
                        top: 723,
                        child: Container(
                          width: 370,
                          height: 48,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _canProceed
                                  ? const Color(0xFF65A0FF)
                                  : const Color(0xFF1F2124),
                              disabledBackgroundColor: const Color(0xFF1F2124),
                              foregroundColor: _canProceed
                                  ? Colors.white
                                  : const Color(0xFF8A9099),
                              disabledForegroundColor: const Color(0xFF8A9099),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              '다음으로 넘어가기',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w600,
                                height: 1.40,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            onPressed: _canProceed
                                ? () {
                                    Get.to(
                                      () => const Testscreen5(),
                                      transition: Transition.fade,
                                    );
                                  }
                                : null,
                            // : () {
                            //     Get.to(
                            //       () => const Testscreen5(), // 디버깅을 위한 임시
                            //       transition: Transition.fade,
                            //     );
                            //   },
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        top: 248,
                        child: Container(
                          width: 380,
                          height: 438,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 32,
                                child: Container(
                                  width: 380,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 12,
                                  ),
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 2,
                                        color: const Color(0xFF232529),
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        _formattedSelectedDate,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                          height: 1.40,
                                          letterSpacing: -0.40,
                                        ),
                                      ),
                                      Text(
                                        'AND+$_elapsedDays',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: const Color(0xFF65A0FF),
                                          fontSize: 16,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w600,
                                          height: 1.40,
                                          letterSpacing: -0.40,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 16,
                                top: 0,
                                child: Text(
                                  '이별 상대와 이별한 날짜',
                                  style: TextStyle(
                                    color: const Color(0xFFBDC7DB),
                                    fontSize: 14,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w500,
                                    height: 1.40,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                top: 74,
                                child: Container(
                                  width: 380,
                                  padding: const EdgeInsets.all(16),
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFF1F2124),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    shadows: [
                                      BoxShadow(
                                        color: Color(0x0A000000),
                                        blurRadius: 12,
                                        offset: Offset(0, 0),
                                        spreadRadius: 0,
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // 월 네비게이션
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          IconButton(
                                            onPressed: _previousMonth,
                                            icon: Icon(
                                              Icons.chevron_left,
                                              color: Colors.white,
                                              size: 24,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                '${_currentMonth.year}.${_currentMonth.month.toString().padLeft(2, '0')}',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontFamily: 'Pretendard',
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Icon(
                                                Icons.calendar_today,
                                                color: const Color(0xFFFFFFFF),
                                                size: 16,
                                              ),
                                            ],
                                          ),
                                          IconButton(
                                            onPressed: _nextMonth,
                                            icon: Icon(
                                              Icons.chevron_right,
                                              color: Colors.white,
                                              size: 24,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),

                                      // 요일 헤더
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children:
                                            [
                                              '월',
                                              '화',
                                              '수',
                                              '목',
                                              '금',
                                              '토',
                                              '일',
                                            ].map((day) {
                                              return Container(
                                                width: 32,
                                                height: 32,
                                                child: Center(
                                                  child: Text(
                                                    day,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 12,
                                                      fontFamily: 'Pretendard',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 1.40,
                                                      letterSpacing: -0.30,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                      ),
                                      const SizedBox(height: 8),

                                      // 달력 그리드
                                      ...List.generate(5, (weekIndex) {
                                        final weekDays = _getDaysInMonth()
                                            .skip(weekIndex * 7)
                                            .take(7)
                                            .toList();
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            bottom: 8,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: weekDays.map((date) {
                                              final isCurrentMonth =
                                                  date.month ==
                                                  _currentMonth.month;
                                              final isSelected =
                                                  date.year ==
                                                      _selectedDate.year &&
                                                  date.month ==
                                                      _selectedDate.month &&
                                                  date.day == _selectedDate.day;
                                              final isToday =
                                                  date.year ==
                                                      DateTime.now().year &&
                                                  date.month ==
                                                      DateTime.now().month &&
                                                  date.day ==
                                                      DateTime.now().day;

                                              return GestureDetector(
                                                onTap: () => _selectDate(date),
                                                child: Container(
                                                  width: 32,
                                                  height: 32,
                                                  decoration: BoxDecoration(
                                                    color: isSelected
                                                        ? const Color(
                                                            0xFF65A0FF,
                                                          )
                                                        : isToday
                                                        ? const Color(
                                                            0xFF2A2D31,
                                                          )
                                                        : Colors.transparent,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      '${date.day}',
                                                      style: TextStyle(
                                                        color: isSelected
                                                            ? Colors.white
                                                            : isCurrentMonth
                                                            ? Colors.white
                                                            : const Color(
                                                                0xFF7F8694,
                                                              ),
                                                        fontSize: 14,
                                                        fontFamily:
                                                            'Pretendard',
                                                        fontWeight:
                                                            isSelected ||
                                                                isToday
                                                            ? FontWeight.w600
                                                            : FontWeight.w500,
                                                        height: 1.40,
                                                        letterSpacing: -0.35,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );

            return SingleChildScrollView(child: scaledContent);
          },
        ),
      ),
    );
  }
}
