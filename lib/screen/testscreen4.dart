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
                height: designHeight,
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
                          // spacing: 1,
                          children: [
                            Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(),
                              child: IconButton(
                                icon: Image.asset('image/arrow-left.png'),
                                onPressed: () {
                                  Get.to(
                                    () => const Testscreen3(),
                                    transition: Transition.fade,
                                  );
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
                          decoration: ShapeDecoration(
                            color: const Color(0xFF65A0FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 8,
                            children: [
                              TextButton(
                                child: Text(
                                  '다음으로 넘어가기',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w600,
                                    height: 1.40,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                onPressed: () {
                                  Get.to(
                                    () => const Testscreen5(),
                                    transition: Transition.fade,
                                  );
                                },
                              ),
                            ],
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
                                    spacing: 8,
                                    children: [
                                      Text(
                                        '2025년 8월 31일 일요일',
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
                                        'AND+7',
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
                                top: 154,
                                child: Container(
                                  width: 430,
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
                                    spacing: 8,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          spacing: 12,
                                          children: [
                                            Container(
                                              width: double.infinity,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                spacing: 28,
                                                children: [
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    decoration: ShapeDecoration(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              100,
                                                            ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      spacing: 8,
                                                      children: [
                                                        Text(
                                                          '월',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.40,
                                                            letterSpacing:
                                                                -0.30,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    decoration: ShapeDecoration(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              100,
                                                            ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      spacing: 8,
                                                      children: [
                                                        Text(
                                                          '화',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.40,
                                                            letterSpacing:
                                                                -0.30,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    decoration: ShapeDecoration(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              100,
                                                            ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      spacing: 8,
                                                      children: [
                                                        Text(
                                                          '수',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.40,
                                                            letterSpacing:
                                                                -0.30,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    decoration: ShapeDecoration(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              100,
                                                            ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      spacing: 8,
                                                      children: [
                                                        Text(
                                                          '목',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.40,
                                                            letterSpacing:
                                                                -0.30,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    decoration: ShapeDecoration(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              100,
                                                            ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      spacing: 8,
                                                      children: [
                                                        Text(
                                                          '금',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.40,
                                                            letterSpacing:
                                                                -0.30,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    decoration: ShapeDecoration(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              100,
                                                            ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      spacing: 8,
                                                      children: [
                                                        Text(
                                                          '토',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.40,
                                                            letterSpacing:
                                                                -0.30,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    decoration: ShapeDecoration(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              100,
                                                            ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      spacing: 8,
                                                      children: [
                                                        Text(
                                                          '일',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.40,
                                                            letterSpacing:
                                                                -0.30,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                spacing: 28,
                                                children: [
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    decoration: ShapeDecoration(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              100,
                                                            ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      spacing: 8,
                                                      children: [
                                                        Text(
                                                          '28',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: const Color(
                                                              0xFF7F8694,
                                                            ),
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.40,
                                                            letterSpacing:
                                                                -0.35,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    decoration: ShapeDecoration(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              100,
                                                            ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      spacing: 8,
                                                      children: [
                                                        Text(
                                                          '29',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: const Color(
                                                              0xFF7F8694,
                                                            ),
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.40,
                                                            letterSpacing:
                                                                -0.35,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    decoration: ShapeDecoration(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              100,
                                                            ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      spacing: 8,
                                                      children: [
                                                        Text(
                                                          '30',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: const Color(
                                                              0xFF7F8694,
                                                            ),
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.40,
                                                            letterSpacing:
                                                                -0.35,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    decoration: ShapeDecoration(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              100,
                                                            ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      spacing: 8,
                                                      children: [
                                                        Text(
                                                          '31',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: const Color(
                                                              0xFF7F8694,
                                                            ),
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.40,
                                                            letterSpacing:
                                                                -0.35,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    decoration: ShapeDecoration(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              100,
                                                            ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      spacing: 8,
                                                      children: [
                                                        Text(
                                                          '1',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.40,
                                                            letterSpacing:
                                                                -0.35,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    decoration: ShapeDecoration(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              100,
                                                            ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      spacing: 8,
                                                      children: [
                                                        Text(
                                                          '2',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.40,
                                                            letterSpacing:
                                                                -0.35,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    decoration: ShapeDecoration(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              100,
                                                            ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      spacing: 8,
                                                      children: [
                                                        Text(
                                                          '3',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.40,
                                                            letterSpacing:
                                                                -0.35,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                spacing: 28,
                                                children: [
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    decoration: ShapeDecoration(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              100,
                                                            ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      spacing: 8,
                                                      children: [
                                                        Text(
                                                          '4',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.40,
                                                            letterSpacing:
                                                                -0.35,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    decoration: ShapeDecoration(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              100,
                                                            ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      spacing: 8,
                                                      children: [
                                                        Text(
                                                          '5',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.40,
                                                            letterSpacing:
                                                                -0.35,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    decoration: ShapeDecoration(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              100,
                                                            ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      spacing: 8,
                                                      children: [
                                                        Text(
                                                          '6',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.40,
                                                            letterSpacing:
                                                                -0.35,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    decoration: ShapeDecoration(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              100,
                                                            ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      spacing: 8,
                                                      children: [
                                                        Text(
                                                          '7',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.40,
                                                            letterSpacing:
                                                                -0.35,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    decoration: ShapeDecoration(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              100,
                                                            ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      spacing: 8,
                                                      children: [
                                                        Text(
                                                          '8',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.40,
                                                            letterSpacing:
                                                                -0.35,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    decoration: ShapeDecoration(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              100,
                                                            ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      spacing: 8,
                                                      children: [
                                                        Text(
                                                          '9',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.40,
                                                            letterSpacing:
                                                                -0.35,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    decoration: ShapeDecoration(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              100,
                                                            ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      spacing: 8,
                                                      children: [
                                                        Text(
                                                          '10',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.40,
                                                            letterSpacing:
                                                                -0.35,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                spacing: 28,
                                                children: [
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    decoration: ShapeDecoration(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              100,
                                                            ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      spacing: 8,
                                                      children: [
                                                        Text(
                                                          '11',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.40,
                                                            letterSpacing:
                                                                -0.35,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    decoration: ShapeDecoration(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              100,
                                                            ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      spacing: 8,
                                                      children: [
                                                        Text(
                                                          '12',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.40,
                                                            letterSpacing:
                                                                -0.35,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    decoration: ShapeDecoration(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              100,
                                                            ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      spacing: 8,
                                                      children: [
                                                        Text(
                                                          '13',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.40,
                                                            letterSpacing:
                                                                -0.35,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    decoration: ShapeDecoration(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              100,
                                                            ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      spacing: 8,
                                                      children: [
                                                        Text(
                                                          '14',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.40,
                                                            letterSpacing:
                                                                -0.35,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    decoration: ShapeDecoration(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              100,
                                                            ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      spacing: 8,
                                                      children: [
                                                        Text(
                                                          '15',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.40,
                                                            letterSpacing:
                                                                -0.35,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    decoration: ShapeDecoration(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              100,
                                                            ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      spacing: 8,
                                                      children: [
                                                        Text(
                                                          '16',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.40,
                                                            letterSpacing:
                                                                -0.35,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    decoration: ShapeDecoration(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              100,
                                                            ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      spacing: 8,
                                                      children: [
                                                        Text(
                                                          '17',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.40,
                                                            letterSpacing:
                                                                -0.35,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                spacing: 28,
                                                children: [
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    decoration: ShapeDecoration(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              100,
                                                            ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      spacing: 8,
                                                      children: [
                                                        Text(
                                                          '18',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.40,
                                                            letterSpacing:
                                                                -0.35,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    decoration: ShapeDecoration(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              100,
                                                            ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      spacing: 8,
                                                      children: [
                                                        Text(
                                                          '19',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.40,
                                                            letterSpacing:
                                                                -0.35,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    decoration: ShapeDecoration(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              100,
                                                            ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      spacing: 8,
                                                      children: [
                                                        Text(
                                                          '20',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.40,
                                                            letterSpacing:
                                                                -0.35,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    decoration: ShapeDecoration(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              100,
                                                            ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      spacing: 8,
                                                      children: [
                                                        Text(
                                                          '21',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.40,
                                                            letterSpacing:
                                                                -0.35,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    decoration: ShapeDecoration(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              100,
                                                            ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      spacing: 8,
                                                      children: [
                                                        Text(
                                                          '22',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.40,
                                                            letterSpacing:
                                                                -0.35,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    decoration: ShapeDecoration(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              100,
                                                            ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      spacing: 8,
                                                      children: [
                                                        Text(
                                                          '23',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.40,
                                                            letterSpacing:
                                                                -0.35,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    decoration: ShapeDecoration(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              100,
                                                            ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      spacing: 8,
                                                      children: [
                                                        Text(
                                                          '24',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.40,
                                                            letterSpacing:
                                                                -0.35,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                spacing: 28,
                                                children: [
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    decoration: ShapeDecoration(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              100,
                                                            ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      spacing: 8,
                                                      children: [
                                                        Text(
                                                          '25',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.40,
                                                            letterSpacing:
                                                                -0.35,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    decoration: ShapeDecoration(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              100,
                                                            ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      spacing: 8,
                                                      children: [
                                                        Text(
                                                          '26',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.40,
                                                            letterSpacing:
                                                                -0.35,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    decoration: ShapeDecoration(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              100,
                                                            ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      spacing: 8,
                                                      children: [
                                                        Text(
                                                          '27',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.40,
                                                            letterSpacing:
                                                                -0.35,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    decoration: ShapeDecoration(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              100,
                                                            ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      spacing: 8,
                                                      children: [
                                                        Text(
                                                          '28',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.40,
                                                            letterSpacing:
                                                                -0.35,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    decoration: ShapeDecoration(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              100,
                                                            ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      spacing: 8,
                                                      children: [
                                                        Text(
                                                          '29',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.40,
                                                            letterSpacing:
                                                                -0.35,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    decoration: ShapeDecoration(
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              100,
                                                            ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      spacing: 8,
                                                      children: [
                                                        Text(
                                                          '30',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.40,
                                                            letterSpacing:
                                                                -0.35,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 32,
                                                    height: 32,
                                                    decoration: ShapeDecoration(
                                                      color: const Color(
                                                        0xFF65A0FF,
                                                      ),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              100,
                                                            ),
                                                      ),
                                                    ),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      spacing: 8,
                                                      children: [
                                                        Text(
                                                          '31',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            height: 1.40,
                                                            letterSpacing:
                                                                -0.35,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 16,
                                top: 104,
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(),
                                  child: Stack(),
                                ),
                              ),
                              Positioned(
                                left: 340,
                                top: 104,
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(),
                                  child: Stack(),
                                ),
                              ),
                              Positioned(
                                left: 136,
                                top: 102,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  spacing: 8,
                                  children: [
                                    Text(
                                      '2025. 08',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w500,
                                        height: 1.40,
                                        letterSpacing: -0.50,
                                      ),
                                    ),
                                    Container(
                                      width: 20,
                                      height: 20,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(),
                                      child: Stack(),
                                    ),
                                  ],
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

            if (scaledHeight > constraints.maxHeight) {
              return SingleChildScrollView(
                child: SizedBox(
                  width: screenWidth,
                  height: scaledHeight,
                  child: scaledContent,
                ),
              );
            } else {
              return SizedBox(
                width: screenWidth,
                height: scaledHeight,
                child: scaledContent,
              );
            }
          },
        ),
      ),
      // backgroundColor: const Color(0xFFEFF5FF),
      // body: SafeArea(
      //   child: Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.stretch,
      //       children: [
      //         const SizedBox(height: 8),
      //         Align(
      //           alignment: Alignment.topCenter,
      //           child: Text(
      //             '&',
      //             style: TextStyle(
      //               fontSize: 28,
      //               color: Colors.blue.shade200,
      //               fontWeight: FontWeight.w600,
      //             ),
      //           ),
      //         ),
      //         const SizedBox(height: 12),
      //         Container(
      //           padding: const EdgeInsets.symmetric(vertical: 10),
      //           decoration: BoxDecoration(
      //             color: Colors.white,
      //             borderRadius: BorderRadius.circular(8),
      //           ),
      //           child: const Center(
      //             child: Text(
      //               '사용자 기본 정보',
      //               style: TextStyle(fontWeight: FontWeight.w600),
      //             ),
      //           ),
      //         ),
      //         const SizedBox(height: 20),
      //         const Text(
      //           '이별 날짜',
      //           style: TextStyle(
      //             color: Color(0xFF2E5AAC),
      //             fontWeight: FontWeight.w600,
      //           ),
      //         ),
      //         const SizedBox(height: 8),
      //         Container(
      //           decoration: BoxDecoration(
      //             color: const Color(0xFFE6E9EE),
      //             borderRadius: BorderRadius.circular(6),
      //           ),
      //           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      //           child: Row(
      //             children: [
      //               Expanded(
      //                 child: _DropdownField<int>(
      //                   value: _year,
      //                   hint: '년',
      //                   items: _years
      //                       .map(
      //                         (y) => DropdownMenuItem<int>(
      //                           value: y,
      //                           child: Text('$y'),
      //                         ),
      //                       )
      //                       .toList(),
      //                   onChanged: (v) => setState(() {
      //                     _year = v;
      //                     if (_day != null && _day! > _days.length) {
      //                       _day = _days.length;
      //                     }
      //                   }),
      //                 ),
      //               ),
      //               const SizedBox(width: 8),
      //               Expanded(
      //                 child: _DropdownField<int>(
      //                   value: _month,
      //                   hint: '월',
      //                   items: _months
      //                       .map(
      //                         (m) => DropdownMenuItem<int>(
      //                           value: m,
      //                           child: Text('$m'),
      //                         ),
      //                       )
      //                       .toList(),
      //                   onChanged: (v) => setState(() {
      //                     _month = v;
      //                     if (_day != null && _day! > _days.length) {
      //                       _day = _days.length;
      //                     }
      //                   }),
      //                 ),
      //               ),
      //               const SizedBox(width: 8),
      //               Expanded(
      //                 child: _DropdownField<int>(
      //                   value: _day,
      //                   hint: '일',
      //                   items: _days
      //                       .map(
      //                         (d) => DropdownMenuItem<int>(
      //                           value: d,
      //                           child: Text('$d'),
      //                         ),
      //                       )
      //                       .toList(),
      //                   onChanged: (v) => setState(() => _day = v),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //         const Spacer(),
      //         Row(
      //           mainAxisAlignment: MainAxisAlignment.end,
      //           children: [
      //             SizedBox(
      //               width: 88,
      //               height: 36,
      //               child: ElevatedButton(
      //                 style: ElevatedButton.styleFrom(
      //                   backgroundColor: const Color(0xFF5C84D5),
      //                   foregroundColor: Colors.white,
      //                   elevation: 0,
      //                   shape: RoundedRectangleBorder(
      //                     borderRadius: BorderRadius.circular(18),
      //                   ),
      //                 ),
      //                 onPressed: () {
      //                   final date = _selectedDate;
      //                   if (date == null) {
      //                     ScaffoldMessenger.of(context).showSnackBar(
      //                       const SnackBar(content: Text('이별 날짜를 선택해 주세요.')),
      //                     );
      //                     return;
      //                   }
      //                   SurveyController.to.breakupDate = date;
      //                   Get.to(() => const Testscreen5());
      //                 },
      //                 child: const Text('다음'),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}

// class _DropdownField<T> extends StatelessWidget {
//   final T? value;
//   final String hint;
//   final List<DropdownMenuItem<T>> items;
//   final ValueChanged<T?> onChanged;
//   const _DropdownField({
//     required this.value,
//     required this.hint,
//     required this.items,
//     required this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 40,
//       padding: const EdgeInsets.symmetric(horizontal: 8),
//       decoration: BoxDecoration(
//         color: Colors.white.withOpacity(0.0),
//         borderRadius: BorderRadius.circular(4),
//       ),
//       child: DropdownButtonHideUnderline(
//         child: DropdownButton<T>(
//           isExpanded: true,
//           value: value,
//           hint: Text(hint),
//           items: items,
//           onChanged: onChanged,
//         ),
//       ),
//     );
//   }
// }
