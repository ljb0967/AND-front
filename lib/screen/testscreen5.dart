import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'testscreen6.dart';
import 'testscreen4.dart';
import '../state/survey_controller.dart';

// 반응형 UI 수정 아직 안됨

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
                          '소중한 당신은\n어떻게 이별에 대처하고 있을까요?',
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
                          '간단한 테스트를 통해 이별대처유형 맞춤 퀘스트를 제공해드려요',
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
                          width: 325.71,
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
                                  Get.back();
                                },
                              ),
                            ),
                            Text(
                              '이별한 날짜 선택',
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
                        left: 14,
                        top: 545,
                        child: Image.asset('image/cloud.png'),
                      ),
                      Positioned(
                        left: 20,
                        top: 723,
                        child: Container(
                          width: 370,
                          height: 48,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF65A0FF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              '테스트 시작하기',
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
                                () => const Testscreen6(),
                                transition: Transition.fade,
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        left: 14,
                        top: 345,
                        child: Image.asset('image/character2.png'),
                      ),
                      Positioned(
                        left: 34,
                        top: 555,
                        child: Image.asset('image/character3.png'),
                      ),
                      Positioned(
                        left: 198,
                        top: 425,
                        child: Image.asset('image/character4.png'),
                      ),
                      Positioned(
                        left: 154,
                        top: 235,
                        child: Image.asset('image/character5.png'),
                      ),
                      // Positioned(
                      //   left: 199,
                      //   top: 522.76,
                      //   child: Container(
                      //     transform: Matrix4.identity()
                      //       ..translate(0.0, 0.0)
                      //       ..rotateZ(-0.26),
                      //     width: 200,
                      //     height: 200,
                      //     child: Stack(
                      //       children: [
                      //         Positioned(
                      //           left: 94.67,
                      //           top: 134.07,
                      //           child: Container(
                      //             width: 41.26,
                      //             height: 46.92,
                      //             decoration: ShapeDecoration(
                      //               color: Colors.white,
                      //               shape: OvalBorder(),
                      //             ),
                      //           ),
                      //         ),
                      //         Positioned(
                      //           left: 125.58,
                      //           top: 125.78,
                      //           child: Container(
                      //             width: 41.26,
                      //             height: 46.92,
                      //             decoration: ShapeDecoration(
                      //               color: Colors.white,
                      //               shape: OvalBorder(),
                      //             ),
                      //           ),
                      //         ),
                      //         Positioned(
                      //           left: 100.60,
                      //           top: 143.86,
                      //           child: Container(
                      //             width: 26.57,
                      //             height: 32.22,
                      //             decoration: ShapeDecoration(
                      //               color: const Color(0xFF090909),
                      //               shape: OvalBorder(),
                      //             ),
                      //           ),
                      //         ),
                      //         Positioned(
                      //           left: 131.51,
                      //           top: 135.58,
                      //           child: Container(
                      //             width: 26.57,
                      //             height: 32.22,
                      //             decoration: ShapeDecoration(
                      //               color: const Color(0xFF090909),
                      //               shape: OvalBorder(),
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // Positioned(
                      //   left: 57.88,
                      //   top: 375,
                      //   child: Container(
                      //     transform: Matrix4.identity()
                      //       ..translate(0.0, 0.0)
                      //       ..rotateZ(0.52),
                      //     width: 140,
                      //     height: 140,
                      //     child: Stack(
                      //       children: [
                      //         Positioned(
                      //           left: 74.82,
                      //           top: 62.60,
                      //           child: Container(
                      //             width: 33.40,
                      //             height: 35.45,
                      //             decoration: ShapeDecoration(
                      //               color: Colors.white,
                      //               shape: OvalBorder(),
                      //             ),
                      //           ),
                      //         ),
                      //         Positioned(
                      //           left: 94.22,
                      //           top: 73.80,
                      //           child: Container(
                      //             width: 33.40,
                      //             height: 35.45,
                      //             decoration: ShapeDecoration(
                      //               color: Colors.white,
                      //               shape: OvalBorder(),
                      //             ),
                      //           ),
                      //         ),
                      //         Positioned(
                      //           left: 80.88,
                      //           top: 70.57,
                      //           child: Container(
                      //             width: 21.92,
                      //             height: 23.97,
                      //             decoration: ShapeDecoration(
                      //               color: const Color(0xFF090909),
                      //               shape: OvalBorder(),
                      //             ),
                      //           ),
                      //         ),
                      //         Positioned(
                      //           left: 100.28,
                      //           top: 81.77,
                      //           child: Container(
                      //             width: 21.92,
                      //             height: 23.97,
                      //             decoration: ShapeDecoration(
                      //               color: const Color(0xFF090909),
                      //               shape: OvalBorder(),
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // Positioned(
                      //   left: 32,
                      //   top: 583.06,
                      //   child: Container(
                      //     transform: Matrix4.identity()
                      //       ..translate(0.0, 0.0)
                      //       ..rotateZ(-0.26),
                      //     width: 120,
                      //     height: 120,
                      //     child: Stack(
                      //       children: [
                      //         Positioned(
                      //           left: 0,
                      //           top: 0,
                      //           child: Container(
                      //             width: 146.97,
                      //             height: 146.97,
                      //             decoration: ShapeDecoration(
                      //               gradient: LinearGradient(
                      //                 begin: Alignment(0.00, 0.00),
                      //                 end: Alignment(1.00, 1.00),
                      //                 colors: [
                      //                   const Color(0xFF65A0FF),
                      //                   const Color(0xFF007AFF),
                      //                 ],
                      //               ),
                      //               shape: OvalBorder(),
                      //             ),
                      //           ),
                      //         ),
                      //         Positioned(
                      //           left: 59.29,
                      //           top: 89.71,
                      //           child: Container(
                      //             width: 24.76,
                      //             height: 28.15,
                      //             decoration: ShapeDecoration(
                      //               color: Colors.white,
                      //               shape: OvalBorder(),
                      //             ),
                      //           ),
                      //         ),
                      //         Positioned(
                      //           left: 77.83,
                      //           top: 84.74,
                      //           child: Container(
                      //             width: 24.76,
                      //             height: 28.15,
                      //             decoration: ShapeDecoration(
                      //               color: Colors.white,
                      //               shape: OvalBorder(),
                      //             ),
                      //           ),
                      //         ),
                      //         Positioned(
                      //           left: 64.54,
                      //           top: 92.65,
                      //           child: Container(
                      //             width: 15.94,
                      //             height: 19.33,
                      //             decoration: ShapeDecoration(
                      //               color: const Color(0xFF090909),
                      //               shape: OvalBorder(),
                      //             ),
                      //           ),
                      //         ),
                      //         Positioned(
                      //           left: 83.09,
                      //           top: 87.68,
                      //           child: Container(
                      //             width: 15.94,
                      //             height: 19.33,
                      //             decoration: ShapeDecoration(
                      //               color: const Color(0xFF090909),
                      //               shape: OvalBorder(),
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      // Positioned(
                      //   left: 181,
                      //   top: 248,
                      //   child: Container(
                      //     transform: Matrix4.identity()
                      //       ..translate(0.0, 0.0)
                      //       ..rotateZ(0.26),
                      //     width: 160,
                      //     height: 160,
                      //     child: Stack(
                      //       children: [
                      //         Positioned(
                      //           left: 79.05,
                      //           top: 38.81,
                      //           child: Container(
                      //             width: 33.01,
                      //             height: 37.54,
                      //             decoration: ShapeDecoration(
                      //               color: Colors.white,
                      //               shape: OvalBorder(),
                      //             ),
                      //           ),
                      //         ),
                      //         Positioned(
                      //           left: 103.78,
                      //           top: 45.43,
                      //           child: Container(
                      //             width: 33.01,
                      //             height: 37.54,
                      //             decoration: ShapeDecoration(
                      //               color: Colors.white,
                      //               shape: OvalBorder(),
                      //             ),
                      //           ),
                      //         ),
                      //         Positioned(
                      //           left: 83.80,
                      //           top: 42.73,
                      //           child: Container(
                      //             width: 21.25,
                      //             height: 25.78,
                      //             decoration: ShapeDecoration(
                      //               color: const Color(0xFF090909),
                      //               shape: OvalBorder(),
                      //             ),
                      //           ),
                      //         ),
                      //         Positioned(
                      //           left: 108.52,
                      //           top: 49.35,
                      //           child: Container(
                      //             width: 21.25,
                      //             height: 25.78,
                      //             decoration: ShapeDecoration(
                      //               color: const Color(0xFF090909),
                      //               shape: OvalBorder(),
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
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
      //           '이별 대처 방안',
      //           style: TextStyle(
      //             color: Color(0xFF2E5AAC),
      //             fontWeight: FontWeight.w600,
      //           ),
      //         ),
      //         const SizedBox(height: 8),
      //         ...['억누르기형', '표출형', '회피형', '분석형'].map(
      //           (title) => Padding(
      //             padding: const EdgeInsets.only(bottom: 14.0),
      //             child: _RadioLine(
      //               title: title,
      //               groupValue: _selected,
      //               onChanged: (v) => setState(() => _selected = v),
      //             ),
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
      //                   if (_selected == null) {
      //                     ScaffoldMessenger.of(context).showSnackBar(
      //                       const SnackBar(content: Text('이별 대처 방안을 선택해 주세요.')),
      //                     );
      //                     return;
      //                   }
      //                   final cat = SurveyController.to.relationshipCategory;
      //                   if (cat == '가족') {
      //                     Get.to(() => const Testscreen6_1());
      //                   } else if (cat == '연인') {
      //                     Get.to(() => const Testscreen6());
      //                   } else if (cat == '친구') {
      //                     Get.to(() => const Testscreen6_2());
      //                   } else if (cat == '반려동물') {
      //                     Get.to(() => const Testscreen6_3());
      //                   } else {
      //                     // 기본: 연인 분기로
      //                     Get.to(() => const Testscreen6());
      //                   }
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
          fillColor: WidgetStateProperty.all(const Color(0xFFDCE6FA)),
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
