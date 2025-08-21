import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'homescreen.dart';
import '../state/survey_controller.dart';
import 'testscreen7.dart';
import 'testscreen9.dart';

class Testscreen8 extends StatefulWidget {
  const Testscreen8({super.key});

  @override
  State<Testscreen8> createState() => _Testscreen8State();
}

class _Testscreen8State extends State<Testscreen8> {
  final TextEditingController _toneController = TextEditingController();

  @override
  void dispose() {
    _toneController.dispose();
    super.dispose();
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
                          '이제 마지막이에요\n이별 상대의 대화 방식은 어땠나요?',
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
                          '이별 상대의 대화방식을 참고하여 다시 대화할 수 있게 해드릴게요',
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
                          width: 380,
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
                                    () => const Testscreen7(),
                                    transition: Transition.fade,
                                  );
                                },
                              ),
                            ),
                            Text(
                              '테스트 결과 확인',
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
                                  'AND 시작하기',
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
                                    () => const Testscreen9(),
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
                        top: 362,
                        child: Container(
                          width: 380,
                          height: 68,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 2,
                                color: const Color(0xFF232529),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 141,
                                top: 22,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  spacing: 10,
                                  children: [
                                    Container(
                                      width: 24,
                                      height: 24,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(),
                                      child: Stack(),
                                    ),
                                    Text(
                                      '텍스트 추가',
                                      style: TextStyle(
                                        color: const Color(0xFF7F8694),
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
                      ),
                      Positioned(
                        left: 16,
                        top: 535,
                        child: Container(
                          width: 380,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 12,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 118.67,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        "https://placehold.co/119x119",
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 118.67,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        "https://placehold.co/119x119",
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 118.67,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 2,
                                        color: const Color(0xFF232529),
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 47.67,
                                        top: 47,
                                        child: Container(
                                          width: 24,
                                          height: 24,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(),
                                          child: Stack(),
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
                      Positioned(
                        left: 16,
                        top: 282,
                        child: Container(
                          width: 380,
                          height: 68,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: ShapeDecoration(
                            color: const Color(0xFF1F2124),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 8,
                            children: [
                              SizedBox(
                                width: 348,
                                child: Text(
                                  '텍스트를 입력하세요 (복사/붙여넣기 가능)',
                                  style: TextStyle(
                                    color: const Color(0xFF8A9099),
                                    fontSize: 16,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w500,
                                    height: 1.40,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 32,
                        top: 248,
                        child: Text(
                          '텍스트 직접 첨부',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            height: 1.40,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 32,
                        top: 462,
                        child: Text(
                          '텍스트가 포함된 이미지 첨부',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            height: 1.40,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 32,
                        top: 488,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 8,
                          children: [
                            Container(
                              width: 14,
                              height: 14,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(),
                              child: Stack(),
                            ),
                            Text(
                              '정확한 텍스트 인식을 위해 메신저 화면 캡쳐를 권장드려요',
                              style: TextStyle(
                                color: const Color(0xFFBDC7DB),
                                fontSize: 14,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w500,
                                height: 1.40,
                                letterSpacing: -0.35,
                              ),
                            ),
                          ],
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
      //           '상대의 평상시 말투',
      //           style: TextStyle(
      //             color: Color(0xFF2E5AAC),
      //             fontWeight: FontWeight.w700,
      //             fontSize: 16,
      //           ),
      //         ),
      //         const SizedBox(height: 16),
      //         const Text(
      //           '직접 입력',
      //           style: TextStyle(
      //             color: Color(0xFF2E5AAC),
      //             fontWeight: FontWeight.w600,
      //           ),
      //         ),
      //         const SizedBox(height: 6),
      //         Container(
      //           decoration: BoxDecoration(
      //             color: const Color(0xFFE6E9EE),
      //             borderRadius: BorderRadius.circular(8),
      //           ),
      //           padding: const EdgeInsets.symmetric(horizontal: 8),
      //           child: TextField(
      //             controller: _toneController,
      //             decoration: const InputDecoration(
      //               hintText: '남/여',
      //               border: InputBorder.none,
      //             ),
      //           ),
      //         ),
      //         const SizedBox(height: 16),
      //         const Text(
      //           '사진 첨부',
      //           style: TextStyle(
      //             color: Color(0xFF2E5AAC),
      //             fontWeight: FontWeight.w600,
      //           ),
      //         ),
      //         const SizedBox(height: 6),
      //         InkWell(
      //           onTap: () {
      //             ScaffoldMessenger.of(context).showSnackBar(
      //               const SnackBar(content: Text('사진 첨부 기능은 추후 추가 예정입니다.')),
      //             );
      //           },
      //           child: Container(
      //             height: 40,
      //             decoration: BoxDecoration(
      //               color: const Color(0xFFE6E9EE),
      //               borderRadius: BorderRadius.circular(8),
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
      //                   SurveyController.to.desiredWords = _toneController.text
      //                       .trim();
      //                   Get.offAll(() => const Homescreen());
      //                 },
      //                 child: const Text('완료'),
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
