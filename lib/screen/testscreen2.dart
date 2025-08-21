import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test1/screen/testscreen.dart';
import 'testscreen3.dart';
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
                          '이별한 사람과\n어떻게 이별하게 되었나요?',
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
                          width: 162.86,
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
                                    () => const Testscreen(),
                                    transition: Transition.fade,
                                  );
                                },
                              ),
                            ),
                            Text(
                              '이별 상대 선택',
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
                                    () => const Testscreen3(),
                                    transition: Transition.fade,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 32,
                        top: 248,
                        child: Text(
                          '이별 사유 선택',
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
                        left: 16,
                        top: 280,
                        child: Container(
                          width: 380,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 8,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 24,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        spacing: 12,
                                        children: [
                                          Container(
                                            width: 18,
                                            height: 18,
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  left: 0.75,
                                                  top: 0.75,
                                                  child: Container(
                                                    width: 16.50,
                                                    height: 16.50,
                                                    decoration: ShapeDecoration(
                                                      shape: OvalBorder(
                                                        side: BorderSide(
                                                          width: 1.50,
                                                          strokeAlign: BorderSide
                                                              .strokeAlignCenter,
                                                          color: const Color(
                                                            0xFFBDC7DB,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 0.75,
                                                  top: 0.75,
                                                  child: Container(
                                                    width: 16.50,
                                                    height: 16.50,
                                                    decoration: ShapeDecoration(
                                                      shape: OvalBorder(
                                                        side: BorderSide(
                                                          width: 1.50,
                                                          strokeAlign: BorderSide
                                                              .strokeAlignCenter,
                                                          color: const Color(
                                                            0xFF65A0FF,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  left: 4.50,
                                                  top: 4.50,
                                                  child: Container(
                                                    width: 9,
                                                    height: 9,
                                                    decoration: ShapeDecoration(
                                                      color: const Color(
                                                        0xFF65A0FF,
                                                      ),
                                                      shape: OvalBorder(
                                                        side: BorderSide(
                                                          width: 1.50,
                                                          color: const Color(
                                                            0xFF65A0FF,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            '사망 (자연사)',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w500,
                                              height: 1.40,
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
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        spacing: 12,
                                        children: [
                                          Container(
                                            width: 18,
                                            height: 18,
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  left: 0.75,
                                                  top: 0.75,
                                                  child: Container(
                                                    width: 16.50,
                                                    height: 16.50,
                                                    decoration: ShapeDecoration(
                                                      shape: OvalBorder(
                                                        side: BorderSide(
                                                          width: 1.50,
                                                          strokeAlign: BorderSide
                                                              .strokeAlignCenter,
                                                          color: const Color(
                                                            0xFFBDC7DB,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            '사망 (사고사, 급작스러운 상실)',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w500,
                                              height: 1.40,
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
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        spacing: 12,
                                        children: [
                                          Container(
                                            width: 18,
                                            height: 18,
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  left: 0.75,
                                                  top: 0.75,
                                                  child: Container(
                                                    width: 16.50,
                                                    height: 16.50,
                                                    decoration: ShapeDecoration(
                                                      shape: OvalBorder(
                                                        side: BorderSide(
                                                          width: 1.50,
                                                          strokeAlign: BorderSide
                                                              .strokeAlignCenter,
                                                          color: const Color(
                                                            0xFFBDC7DB,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            '관계 단절',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w500,
                                              height: 1.40,
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
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        spacing: 12,
                                        children: [
                                          Container(
                                            width: 18,
                                            height: 18,
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  left: 0.75,
                                                  top: 0.75,
                                                  child: Container(
                                                    width: 16.50,
                                                    height: 16.50,
                                                    decoration: ShapeDecoration(
                                                      shape: OvalBorder(
                                                        side: BorderSide(
                                                          width: 1.50,
                                                          strokeAlign: BorderSide
                                                              .strokeAlignCenter,
                                                          color: const Color(
                                                            0xFFBDC7DB,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            '이혼 / 가족 구조 해체',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w500,
                                              height: 1.40,
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
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        spacing: 12,
                                        children: [
                                          Container(
                                            width: 18,
                                            height: 18,
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  left: 0.75,
                                                  top: 0.75,
                                                  child: Container(
                                                    width: 16.50,
                                                    height: 16.50,
                                                    decoration: ShapeDecoration(
                                                      shape: OvalBorder(
                                                        side: BorderSide(
                                                          width: 1.50,
                                                          strokeAlign: BorderSide
                                                              .strokeAlignCenter,
                                                          color: const Color(
                                                            0xFFBDC7DB,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            '장기적 거리감 (연락두절, 이민, 실종 등)',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w500,
                                              height: 1.40,
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
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        spacing: 12,
                                        children: [
                                          Container(
                                            width: 18,
                                            height: 18,
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  left: 0.75,
                                                  top: 0.75,
                                                  child: Container(
                                                    width: 16.50,
                                                    height: 16.50,
                                                    decoration: ShapeDecoration(
                                                      shape: OvalBorder(
                                                        side: BorderSide(
                                                          width: 1.50,
                                                          strokeAlign: BorderSide
                                                              .strokeAlignCenter,
                                                          color: const Color(
                                                            0xFFBDC7DB,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            '정확히 모르겠어요 / 복합적이에요',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w500,
                                              height: 1.40,
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
      //           '이별 상대 선택',
      //           style: TextStyle(
      //             color: Color(0xFF2E5AAC),
      //             fontWeight: FontWeight.w600,
      //           ),
      //         ),
      //         const SizedBox(height: 8),
      //         _RadioLine(
      //           title: '가족',
      //           groupValue: _selected,
      //           onChanged: (v) => setState(() => _selected = v),
      //         ),
      //         const SizedBox(height: 12),
      //         _RadioLine(
      //           title: '연인',
      //           groupValue: _selected,
      //           onChanged: (v) => setState(() => _selected = v),
      //         ),
      //         const SizedBox(height: 12),
      //         _RadioLine(
      //           title: '반려동물',
      //           groupValue: _selected,
      //           onChanged: (v) => setState(() => _selected = v),
      //         ),
      //         const SizedBox(height: 12),
      //         _RadioLine(
      //           title: '친구',
      //           groupValue: _selected,
      //           onChanged: (v) => setState(() => _selected = v),
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
      //                       const SnackBar(content: Text('이별 상대를 선택해 주세요.')),
      //                     );
      //                     return;
      //                   }
      //                   SurveyController.to.relationshipCategory = _selected;
      //                   if (_selected == '가족') {
      //                     Get.to(() => const Testscreen2_1());
      //                   } else {
      //                     Get.to(() => const Testscreen3());
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

// class _RadioLine extends StatelessWidget {
//   final String title;
//   final String? groupValue;
//   final ValueChanged<String?> onChanged;
//   const _RadioLine({
//     required this.title,
//     required this.groupValue,
//     required this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Radio<String>(
//           value: title,
//           groupValue: groupValue,
//           onChanged: onChanged,
//           visualDensity: VisualDensity.compact,
//           fillColor: MaterialStateProperty.all(const Color(0xFFDCE6FA)),
//         ),
//         const SizedBox(width: 8),
//         Text(
//           title,
//           style: const TextStyle(
//             color: Color(0xFF2E5AAC),
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ],
//     );
//   }
// }
