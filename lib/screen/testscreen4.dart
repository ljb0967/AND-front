import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'testscreen5.dart';
import '../state/survey_controller.dart';
import 'testscreen3.dart';
import '../state/loss_case_controller.dart';
import 'package:flutter/cupertino.dart';

class Testscreen4 extends StatefulWidget {
  const Testscreen4({super.key});

  @override
  State<Testscreen4> createState() => _Testscreen4State();
}

class _Testscreen4State extends State<Testscreen4> {
  DateTime _selectedDate = DateTime.now();
  DateTime _currentMonth = DateTime.now();

  final LossCaseController lossCaseController = Get.find<LossCaseController>();

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

  void _showYearMonthPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return _YearMonthPicker(
          currentYear: _currentMonth.year,
          currentMonth: _currentMonth.month,
          onYearMonthSelected: (int year, int month) {
            setState(() {
              // 현재 월을 선택된 연도와 월로 업데이트
              _currentMonth = DateTime(year, month);

              // 선택된 날짜가 새로운 월에 없으면 1일로 설정
              if (_selectedDate.month != month || _selectedDate.year != year) {
                _selectedDate = DateTime(year, month, 1);
              }
            });
            Navigator.pop(context);
          },
        );
      },
    );
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
      backgroundColor: const Color(0xFF111111),
      body: SafeArea(
        child: Column(
          children: [
            // 상단 헤더 영역
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 28, 12, 0),
              child: Row(
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

            // 프로그레스 바
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: Row(
                children: [
                  Container(
                    width: 271.43,
                    height: 4,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF65A0FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 4,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF232529),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 메인 콘텐츠 영역 (스크롤 가능)
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),

                    // 메인 타이틀
                    Text(
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

                    SizedBox(height: 20),

                    // 서브 타이틀
                    Text(
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

                    SizedBox(height: 32),

                    // 이별 상대와 이별한 날짜 라벨
                    Text(
                      '이별 상대와 이별한 날짜',
                      style: TextStyle(
                        color: const Color(0xFFBDC7DB),
                        fontSize: 14,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                        height: 1.40,
                      ),
                    ),

                    SizedBox(height: 16),

                    // 선택된 날짜와 경과일 표시
                    Container(
                      width: double.infinity,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

                    SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            GestureDetector(
                              onTap: _showYearMonthPicker,
                              child: Icon(
                                Icons.calendar_today,
                                color: const Color(0xFFFFFFFF),
                                size: 16,
                              ),
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

                    // 달력 컨테이너
                    Container(
                      width: double.infinity,
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),

                          // 요일 헤더
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: ['월', '화', '수', '목', '금', '토', '일'].map((
                              day,
                            ) {
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
                                      fontWeight: FontWeight.w500,
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
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: weekDays.map((date) {
                                  final isCurrentMonth =
                                      date.month == _currentMonth.month;
                                  final isSelected =
                                      date.year == _selectedDate.year &&
                                      date.month == _selectedDate.month &&
                                      date.day == _selectedDate.day;
                                  final isToday =
                                      date.year == DateTime.now().year &&
                                      date.month == DateTime.now().month &&
                                      date.day == DateTime.now().day;

                                  return GestureDetector(
                                    onTap: () => _selectDate(date),
                                    child: Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? const Color(0xFF65A0FF)
                                            : isToday
                                            ? const Color(0xFF2A2D31)
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
                                                : const Color(0xFF7F8694),
                                            fontSize: 14,
                                            fontFamily: 'Pretendard',
                                            fontWeight: isSelected || isToday
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

                    SizedBox(height: 10),

                    // 다음으로 넘어가기 버튼
                    SizedBox(
                      width: double.infinity,
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
                                lossCaseController.setLossDate(_selectedDate);

                                print('Testscreen4 데이터 저장 완료');
                                lossCaseController.printCurrentData();
                                Get.to(
                                  () => const Testscreen5(),
                                  transition: Transition.fade,
                                );
                              }
                            : null,
                      ),
                    ),

                    SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _YearMonthPicker extends StatefulWidget {
  final int currentYear;
  final int currentMonth;
  final Function(int year, int month) onYearMonthSelected;

  const _YearMonthPicker({
    required this.currentYear,
    required this.currentMonth,
    required this.onYearMonthSelected,
  });

  @override
  State<_YearMonthPicker> createState() => _YearMonthPickerState();
}

class _YearMonthPickerState extends State<_YearMonthPicker> {
  late FixedExtentScrollController _yearController;
  late FixedExtentScrollController _monthController;
  late int _selectedYear;
  late int _selectedMonth;

  @override
  void initState() {
    super.initState();
    _selectedYear = widget.currentYear;
    _selectedMonth = widget.currentMonth;
    _yearController = FixedExtentScrollController(
      initialItem: _selectedYear - 1900,
    );
    _monthController = FixedExtentScrollController(
      initialItem: _selectedMonth - 1,
    );
  }

  @override
  void dispose() {
    _yearController.dispose();
    _monthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF2A2D31),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 드래그 핸들
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 20),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFF7F8694),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // 연도와 월 선택 영역
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              children: [
                // 연도 선택
                Expanded(
                  child: Column(
                    children: [
                      // 위쪽 화살표
                      Icon(
                        Icons.keyboard_arrow_up,
                        color: const Color(0xFF7F8694),
                        size: 24,
                      ),

                      // 연도 리스트
                      Container(
                        height: 120,
                        child: CupertinoPicker(
                          scrollController: _yearController,
                          itemExtent: 40,
                          onSelectedItemChanged: (index) {
                            setState(() {
                              _selectedYear = 1900 + index;
                            });
                          },
                          children: List.generate(200, (index) {
                            final year = 1900 + index;
                            final isSelected = year == _selectedYear;
                            return Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFF1F2124)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '$year',
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : const Color(0xFF7F8694),
                                    fontSize: 18,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),

                      // 아래쪽 화살표
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: const Color(0xFF7F8694),
                        size: 24,
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 40),

                // 월 선택
                Expanded(
                  child: Column(
                    children: [
                      // 위쪽 화살표
                      Icon(
                        Icons.keyboard_arrow_up,
                        color: const Color(0xFF7F8694),
                        size: 24,
                      ),

                      // 월 리스트
                      Container(
                        height: 120,
                        child: CupertinoPicker(
                          scrollController: _monthController,
                          itemExtent: 40,
                          onSelectedItemChanged: (index) {
                            setState(() {
                              _selectedMonth = index + 1;
                            });
                          },
                          children: List.generate(12, (index) {
                            final month = index + 1;
                            final isSelected = month == _selectedMonth;
                            return Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFF1F2124)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '${month.toString().padLeft(2, '0')}',
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : const Color(0xFF7F8694),
                                    fontSize: 18,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),

                      // 아래쪽 화살표
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: const Color(0xFF7F8694),
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // 확인 버튼 추가
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF65A0FF),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  // 사용자가 선택한 연도와 월로 콜백 호출
                  widget.onYearMonthSelected(_selectedYear, _selectedMonth);
                },
                child: Text(
                  '확인',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                    height: 1.40,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
