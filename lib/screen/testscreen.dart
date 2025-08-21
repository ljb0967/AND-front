import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test1/screen/loginScreen2.dart';
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
                          '소중한 당신,\n어떤 사람과 이별하셨나요?',
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
                          width: 108.58,
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
                                    () => const LoginScreen2(),
                                    transition: Transition.fade,
                                  );
                                },
                              ),
                            ),
                            Text(
                              '사용자 소개',
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
                                    () => const Testscreen2(),
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
                          '이별 상대 선택',
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
                          height: 46,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 8,
                            children: [
                              Container(
                                width: double.infinity,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  spacing: 12,
                                  children: [
                                    Container(
                                      height: 20,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        spacing: 113,
                                        children: [
                                          Row(
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
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(),
                                                child: Stack(),
                                              ),
                                              Text(
                                                '가족',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontFamily: 'Pretendard',
                                                  fontWeight: FontWeight.w600,
                                                  height: 1.40,
                                                  letterSpacing: -0.40,
                                                ),
                                              ),
                                            ],
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
                        top: 338,
                        child: Container(
                          width: 380,
                          height: 46,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 8,
                            children: [
                              Container(
                                width: double.infinity,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  spacing: 12,
                                  children: [
                                    Container(
                                      height: 20,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        spacing: 113,
                                        children: [
                                          Row(
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
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(),
                                                child: Stack(),
                                              ),
                                              Text(
                                                '연인',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontFamily: 'Pretendard',
                                                  fontWeight: FontWeight.w600,
                                                  height: 1.40,
                                                  letterSpacing: -0.40,
                                                ),
                                              ),
                                            ],
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
                        top: 396,
                        child: Container(
                          width: 380,
                          height: 46,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 8,
                            children: [
                              Container(
                                width: double.infinity,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  spacing: 12,
                                  children: [
                                    Container(
                                      height: 20,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        spacing: 113,
                                        children: [
                                          Row(
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
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(),
                                                child: Stack(),
                                              ),
                                              Text(
                                                '친구',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontFamily: 'Pretendard',
                                                  fontWeight: FontWeight.w600,
                                                  height: 1.40,
                                                  letterSpacing: -0.40,
                                                ),
                                              ),
                                            ],
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
                        top: 454,
                        child: Container(
                          width: 380,
                          height: 46,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 8,
                            children: [
                              Container(
                                width: double.infinity,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  spacing: 12,
                                  children: [
                                    Container(
                                      height: 20,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        spacing: 113,
                                        children: [
                                          Row(
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
                                                clipBehavior: Clip.antiAlias,
                                                decoration: BoxDecoration(),
                                                child: Stack(),
                                              ),
                                              Text(
                                                '반려동물',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16,
                                                  fontFamily: 'Pretendard',
                                                  fontWeight: FontWeight.w600,
                                                  height: 1.40,
                                                  letterSpacing: -0.40,
                                                ),
                                              ),
                                            ],
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
      // // backgroundColor: Colors.black,
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
      //           '이름',
      //           style: TextStyle(
      //             color: Color(0xFF2E5AAC),
      //             fontWeight: FontWeight.w600,
      //           ),
      //         ),
      //         const SizedBox(height: 8),
      //         _GreyField(
      //           child: TextField(
      //             controller: _nameController,
      //             decoration: const InputDecoration(
      //               isDense: true,
      //               border: InputBorder.none,
      //               contentPadding: EdgeInsets.symmetric(
      //                 horizontal: 12,
      //                 vertical: 10,
      //               ),
      //             ),
      //           ),
      //         ),
      //         const SizedBox(height: 16),
      //         const Text(
      //           '나이(숫자만)',
      //           style: TextStyle(
      //             color: Color(0xFF2E5AAC),
      //             fontWeight: FontWeight.w600,
      //           ),
      //         ),
      //         const SizedBox(height: 8),
      //         _GreyField(
      //           child: TextField(
      //             controller: _ageController,
      //             keyboardType: TextInputType.number,
      //             decoration: const InputDecoration(
      //               isDense: true,
      //               border: InputBorder.none,
      //               contentPadding: EdgeInsets.symmetric(
      //                 horizontal: 12,
      //                 vertical: 10,
      //               ),
      //             ),
      //           ),
      //         ),
      //         const SizedBox(height: 16),
      //         const Text(
      //           '성별',
      //           style: TextStyle(
      //             color: Color(0xFF2E5AAC),
      //             fontWeight: FontWeight.w600,
      //           ),
      //         ),
      //         const SizedBox(height: 8),
      //         _GreyField(
      //           child: DropdownButtonHideUnderline(
      //             child: DropdownButton<String>(
      //               hint: const Text('남/여'),
      //               value: _gender,
      //               isExpanded: true,
      //               items: const [
      //                 DropdownMenuItem(value: '남', child: Text('남')),
      //                 DropdownMenuItem(value: '여', child: Text('여')),
      //               ],
      //               onChanged: (v) {
      //                 setState(() => _gender = v);
      //               },
      //               padding: const EdgeInsets.symmetric(horizontal: 12),
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
      //                   if (_canProceed) {
      //                     Get.to(() => const Testscreen2());
      //                   } else {
      //                     ScaffoldMessenger.of(context).showSnackBar(
      //                       const SnackBar(
      //                         content: Text('이름, 나이(숫자), 성별을 입력해 주세요.'),
      //                       ),
      //                     );
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

// class _GreyField extends StatelessWidget {
//   final Widget child;
//   const _GreyField({required this.child});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: const Color(0xFFE6E9EE),
//         borderRadius: BorderRadius.circular(6),
//       ),
//       child: child,
//     );
//   }
// }
