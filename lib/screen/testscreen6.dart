import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'testscreen7.dart';
import 'testscreen5.dart';

class Testscreen6 extends StatefulWidget {
  const Testscreen6({super.key});

  @override
  State<Testscreen6> createState() => _Testscreen6State();
}

class _Testscreen6State extends State<Testscreen6> {
  String? _selectedOption;

  bool get _canProceed {
    final hasValidBreakupSelection = _selectedOption != null;
    return hasValidBreakupSelection;
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
                          'Q. 01\n마음이 힘들 때면 나는...',
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
                          '4개의 선택지 중 나를 가장 잘 나타내는 선택지 하나를 선택하세요',
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
                              '테스트 시작 화면',
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
                                      () => const Testscreen7(),
                                      transition: Transition.fade,
                                    );
                                  }
                                // : null,
                                : () {
                                    Get.to(
                                      () => const Testscreen7(), // 디버깅을 위한 임시
                                      transition: Transition.fade,
                                    );
                                  },
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        top: 248,
                        child: Container(
                          width: 380,
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: const Color(0xFF111111),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        _buildOption('A.', '감정을 숨기고 혼자 견딘다'),
                                        const SizedBox(height: 12),
                                        _buildOption(
                                          'B.',
                                          '다른 일에 몰두해 아예 생각을 차단한다',
                                        ),
                                        const SizedBox(height: 12),
                                        _buildOption(
                                          'C.',
                                          '글을 쓰거나 노래를 듣고 울어버린다',
                                        ),
                                        const SizedBox(height: 12),
                                        _buildOption(
                                          'D.',
                                          '당시 상황을 떠올리며 ‘여기서 뭐가 잘못됐지?’하고 따\n져본다',
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      //           Positioned(
                      //             left: 16,
                      //             top: 248,
                      //             child: Container(
                      //               width: 380,
                      //               padding: const EdgeInsets.symmetric(
                      //                 horizontal: 16,
                      //                 vertical: 12,
                      //               ),
                      //               decoration: ShapeDecoration(
                      //                 color: const Color(0xFF1F2124),
                      //                 shape: RoundedRectangleBorder(
                      //                   borderRadius: BorderRadius.circular(10),
                      //                 ),
                      //               ),
                      //               child: Row(
                      //                 mainAxisSize: MainAxisSize.min,
                      //                 mainAxisAlignment: MainAxisAlignment.start,
                      //                 crossAxisAlignment: CrossAxisAlignment.center,
                      //                 spacing: 8,
                      //                 children: [
                      //                   Row(
                      //                     mainAxisSize: MainAxisSize.min,
                      //                     mainAxisAlignment: MainAxisAlignment.start,
                      //                     crossAxisAlignment: CrossAxisAlignment.start,
                      //                     spacing: 12,
                      //                     children: [
                      //                       SizedBox(
                      //                         width: 16,
                      //                         child: Text(
                      //                           'A.',
                      //                           style: TextStyle(
                      //                             color: Colors.white,
                      //                             fontSize: 16,
                      //                             fontFamily: 'Pretendard',
                      //                             fontWeight: FontWeight.w500,
                      //                             height: 1.40,
                      //                             letterSpacing: -0.40,
                      //                           ),
                      //                         ),
                      //                       ),
                      //                       Text(
                      //                         '감정을 숨기고 혼자 견딘다',
                      //                         style: TextStyle(
                      //                           color: Colors.white,
                      //                           fontSize: 16,
                      //                           fontFamily: 'Pretendard',
                      //                           fontWeight: FontWeight.w500,
                      //                           height: 1.40,
                      //                           letterSpacing: -0.40,
                      //                         ),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ],
                      //               ),
                      //             ),
                      //           ),
                      //           Positioned(
                      //             left: 16,
                      //             top: 306,
                      //             child: Container(
                      //               width: 380,
                      //               padding: const EdgeInsets.symmetric(
                      //                 horizontal: 16,
                      //                 vertical: 12,
                      //               ),
                      //               decoration: ShapeDecoration(
                      //                 color: const Color(0xFF1F2124),
                      //                 shape: RoundedRectangleBorder(
                      //                   borderRadius: BorderRadius.circular(10),
                      //                 ),
                      //               ),
                      //               child: Row(
                      //                 mainAxisSize: MainAxisSize.min,
                      //                 mainAxisAlignment: MainAxisAlignment.start,
                      //                 crossAxisAlignment: CrossAxisAlignment.center,
                      //                 spacing: 8,
                      //                 children: [
                      //                   Row(
                      //                     mainAxisSize: MainAxisSize.min,
                      //                     mainAxisAlignment: MainAxisAlignment.start,
                      //                     crossAxisAlignment: CrossAxisAlignment.start,
                      //                     spacing: 12,
                      //                     children: [
                      //                       SizedBox(
                      //                         width: 16,
                      //                         child: Text(
                      //                           'B.',
                      //                           style: TextStyle(
                      //                             color: Colors.white,
                      //                             fontSize: 16,
                      //                             fontFamily: 'Pretendard',
                      //                             fontWeight: FontWeight.w500,
                      //                             height: 1.40,
                      //                             letterSpacing: -0.40,
                      //                           ),
                      //                         ),
                      //                       ),
                      //                       Text(
                      //                         '다른 일에 몰두해 아예 생각을 차단한다',
                      //                         style: TextStyle(
                      //                           color: Colors.white,
                      //                           fontSize: 16,
                      //                           fontFamily: 'Pretendard',
                      //                           fontWeight: FontWeight.w500,
                      //                           height: 1.40,
                      //                           letterSpacing: -0.40,
                      //                         ),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ],
                      //               ),
                      //             ),
                      //           ),
                      //           Positioned(
                      //             left: 16,
                      //             top: 364,
                      //             child: Container(
                      //               width: 380,
                      //               padding: const EdgeInsets.symmetric(
                      //                 horizontal: 16,
                      //                 vertical: 12,
                      //               ),
                      //               decoration: ShapeDecoration(
                      //                 color: const Color(0xFF1F2124),
                      //                 shape: RoundedRectangleBorder(
                      //                   borderRadius: BorderRadius.circular(10),
                      //                 ),
                      //               ),
                      //               child: Row(
                      //                 mainAxisSize: MainAxisSize.min,
                      //                 mainAxisAlignment: MainAxisAlignment.start,
                      //                 crossAxisAlignment: CrossAxisAlignment.center,
                      //                 spacing: 8,
                      //                 children: [
                      //                   Row(
                      //                     mainAxisSize: MainAxisSize.min,
                      //                     mainAxisAlignment: MainAxisAlignment.start,
                      //                     crossAxisAlignment: CrossAxisAlignment.start,
                      //                     spacing: 12,
                      //                     children: [
                      //                       SizedBox(
                      //                         width: 16,
                      //                         child: Text(
                      //                           'C.',
                      //                           style: TextStyle(
                      //                             color: Colors.white,
                      //                             fontSize: 16,
                      //                             fontFamily: 'Pretendard',
                      //                             fontWeight: FontWeight.w500,
                      //                             height: 1.40,
                      //                             letterSpacing: -0.40,
                      //                           ),
                      //                         ),
                      //                       ),
                      //                       Text(
                      //                         '글을 쓰거나 노래를 듣고 울어버린다',
                      //                         style: TextStyle(
                      //                           color: Colors.white,
                      //                           fontSize: 16,
                      //                           fontFamily: 'Pretendard',
                      //                           fontWeight: FontWeight.w500,
                      //                           height: 1.40,
                      //                           letterSpacing: -0.40,
                      //                         ),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ],
                      //               ),
                      //             ),
                      //           ),
                      //           Positioned(
                      //             left: 16,
                      //             top: 422,
                      //             child: Container(
                      //               width: 380,
                      //               padding: const EdgeInsets.symmetric(
                      //                 horizontal: 16,
                      //                 vertical: 12,
                      //               ),
                      //               decoration: ShapeDecoration(
                      //                 color: const Color(0xFF1F2124),
                      //                 shape: RoundedRectangleBorder(
                      //                   borderRadius: BorderRadius.circular(10),
                      //                 ),
                      //               ),
                      //               child: Row(
                      //                 mainAxisSize: MainAxisSize.min,
                      //                 mainAxisAlignment: MainAxisAlignment.start,
                      //                 crossAxisAlignment: CrossAxisAlignment.center,
                      //                 spacing: 8,
                      //                 children: [
                      //                   Row(
                      //                     mainAxisSize: MainAxisSize.min,
                      //                     mainAxisAlignment: MainAxisAlignment.start,
                      //                     crossAxisAlignment: CrossAxisAlignment.start,
                      //                     spacing: 12,
                      //                     children: [
                      //                       SizedBox(
                      //                         width: 16,
                      //                         child: Text(
                      //                           'D.',
                      //                           style: TextStyle(
                      //                             color: Colors.white,
                      //                             fontSize: 16,
                      //                             fontFamily: 'Pretendard',
                      //                             fontWeight: FontWeight.w500,
                      //                             height: 1.40,
                      //                             letterSpacing: -0.40,
                      //                           ),
                      //                         ),
                      //                       ),
                      //                       SizedBox(
                      //                         width: 320,
                      //                         child: Text(
                      //                           '당시 상황을 떠올리며 ‘여기서 뭐가 잘못됐지?’하고 따져본다',
                      //                           style: TextStyle(
                      //                             color: Colors.white,
                      //                             fontSize: 16,
                      //                             fontFamily: 'Pretendard',
                      //                             fontWeight: FontWeight.w500,
                      //                             height: 1.40,
                      //                             letterSpacing: -0.40,
                      //                           ),
                      //                         ),
                      //                       ),
                      //                     ],
                      //                   ),
                      //                 ],
                      //               ),
                      //             ),
                      //           ),
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
    );
  }

  Widget _buildOption(String text1, String text2) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_selectedOption == text1) {
            _selectedOption = null;
          } else {
            _selectedOption = text1;
          }
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
        decoration: BoxDecoration(
          color: _selectedOption == text1
              ? const Color(0xFF2A2D31)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: _selectedOption == text1
                ? const Color(0xFF65A0FF) //선택하면 배경 테두리 바뀌게 하는 부분
                : Colors.transparent,
            // color: Colors.transparent,
            width: 2,
          ),
        ),
        child: Container(
          width: 380,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          decoration: ShapeDecoration(
            color: const Color(0xFF1F2124),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 8,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 12,
                children: [
                  SizedBox(
                    width: 16,
                    child: Text(
                      text1,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                        height: 1.40,
                        letterSpacing: -0.40,
                      ),
                    ),
                  ),
                  Text(
                    text2,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w500,
                      height: 1.40,
                      letterSpacing: -0.40,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // child: Row(
        //   children: [
        //     Container(
        //       width: 16,
        //       height: 16,
        //       decoration: BoxDecoration(
        //         color: _selectedOption == text
        //             ? const Color(0xFF111111)
        //             : Colors.transparent,
        //         border: Border.all(
        //           color: _selectedOption == text
        //               ? const Color(0xFF65A0FF)
        //               : const Color(0xFFBDC7DB),
        //           width: 1.5,
        //         ),
        //         borderRadius: BorderRadius.circular(8),
        //       ),
        //       child: _selectedOption == text
        //           ? Center(
        //               child: Container(
        //                 width: 8,
        //                 height: 8,
        //                 decoration: const BoxDecoration(
        //                   shape: BoxShape.circle,
        //                   color: Color(0xFF66A1FF),
        //                 ),
        //               ),
        //             )
        //           : null,
        //     ),
        //     const SizedBox(width: 8),
        //     Text(
        //       text,
        //       style: TextStyle(
        //         color: Colors.white,
        //         fontSize: 14,
        //         fontFamily: 'Pretendard',
        //         fontWeight: FontWeight.w500,
        //       ),
        //     ),
        //   ],
        // ),
      ),
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
//           fillColor: WidgetStateProperty.all(const Color(0xFFDCE6FA)),
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
