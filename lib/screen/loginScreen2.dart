import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'testscreen.dart';
import 'loginscreen.dart';

class LoginScreen2 extends StatefulWidget {
  const LoginScreen2({super.key});

  @override
  State<LoginScreen2> createState() => _LoginScreen2State();
}

class _LoginScreen2State extends State<LoginScreen2> {
  // bool requiredA = true;
  // bool requiredB = false;
  // bool optionalA = false;
  // bool optionalB = false;
  // bool allAgree = false;

  // bool get isAllRequiredChecked => requiredA && requiredB;

  // void _syncAllAgree() {
  //   setState(() {
  //     allAgree = requiredA && requiredB && optionalA && optionalB;
  //   });
  // }

  // void _toggleAll(bool value) {
  //   setState(() {
  //     allAgree = value;
  //     requiredA = value;
  //     requiredB = value;
  //     optionalA = value;
  //     optionalB = value;
  //   });
  // }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  String? _gender;

  // 필수 입력 검증을 위한 getter
  bool get _isFormValid {
    return nameController.text.trim().isNotEmpty &&
        ageController.text.trim().isNotEmpty &&
        _gender != null;
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
                          '만나서 반가워요 :)\n소중한 당신을 소개해주세요',
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
                          '건강한 이별 극복을 돕기 위해 몇 가지 정보가 필요해요',
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
                          width: 54.29,
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
                                    () => const Loginscreen(),
                                    transition: Transition.fade,
                                  );
                                },
                              ),
                            ),
                            Text(
                              '로그인 화면',
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
                        left: 16,
                        top: 280,
                        child: Container(
                          width: 380,
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
                          child: TextField(
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            style: const TextStyle(
                              color: const Color(0xFF8A9099),
                              fontSize: 16,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              height: 1.40,
                            ),
                            decoration: const InputDecoration(
                              isCollapsed: true,
                              border: InputBorder.none,
                              hintText: '이름 입력',
                              hintStyle: TextStyle(
                                color: Color(0xFF8A9099),
                                fontSize: 16,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w500,
                                height: 1.40,
                              ),
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        left: 16,
                        top: 382,
                        child: Container(
                          width: 380,
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
                          child: TextField(
                            controller: ageController,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                              color: const Color(0xFF8A9099),
                              fontSize: 16,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              height: 1.40,
                            ),
                            decoration: const InputDecoration(
                              isCollapsed: true,
                              border: InputBorder.none,
                              hintText: '나이 입력(숫자만)',
                              hintStyle: TextStyle(
                                color: Color(0xFF8A9099),
                                fontSize: 16,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w500,
                                height: 1.40,
                              ),
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        left: 32,
                        top: 248,
                        child: Text(
                          '사용자 이름',
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
                        left: 32,
                        top: 350,
                        child: Text(
                          '사용자 나이(만)',
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
                        left: 32,
                        top: 460,
                        child: Text(
                          '사용자 성별',
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
                        left: 20,
                        top: 723,
                        child: Container(
                          width: 370,
                          height: 48,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _isFormValid
                                  ? const Color(0xFF65A0FF)
                                  : const Color(0xFF1F2124),
                              disabledBackgroundColor: const Color(0xFF1F2124),
                              foregroundColor: _isFormValid
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
                            onPressed: _isFormValid
                                ? () {
                                    Get.to(
                                      () => const Testscreen(),
                                      transition: Transition.fade,
                                    );
                                  }
                                // : null,
                                : () {
                                    Get.to(
                                      () => const Testscreen(), // 디버깅을 위한 임시
                                      transition: Transition.fade,
                                    );
                                  },
                          ),
                        ),
                      ),

                      Positioned(
                        left: 16,
                        top: 492,
                        child: Container(
                          width: 380,
                          height: 46,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF1F2124),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _gender = 'male';
                                    });
                                  },
                                  child: Container(
                                    height: double.infinity,
                                    decoration: ShapeDecoration(
                                      color: _gender == 'male'
                                          ? const Color(0xFF2A2D31)
                                          : Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          100,
                                        ),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '남성',
                                        style: TextStyle(
                                          color: _gender == 'male'
                                              ? Colors.white
                                              : const Color(0xFFBDC7DB),
                                          fontSize: 16,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                          height: 1.40,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _gender = 'female';
                                    });
                                  },
                                  child: Container(
                                    height: double.infinity,
                                    decoration: ShapeDecoration(
                                      color: _gender == 'female'
                                          ? const Color(0xFF2A2D31)
                                          : Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          100,
                                        ),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '여성',
                                        style: TextStyle(
                                          color: _gender == 'female'
                                              ? Colors.white
                                              : const Color(0xFFBDC7DB),
                                          fontSize: 16,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                          height: 1.40,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 32,
                        top: 554,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (_gender == 'none') {
                                    _gender = null;
                                  } else {
                                    _gender = 'none';
                                  }
                                });
                              },
                              child: Container(
                                width: 18,
                                height: 18,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: _gender == 'none'
                                        ? const Color(0xFF66A1FF)
                                        : const Color(0xFFBDC7DB),
                                    width: 1.5,
                                  ),
                                  color: _gender == 'none'
                                      ? const Color(0xFF111111)
                                      : Colors.transparent,
                                ),
                                child: _gender == 'none'
                                    ? Center(
                                        child: Container(
                                          width: 8,
                                          height: 8,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color(0xFF66A1FF),
                                          ),
                                        ),
                                      )
                                    : null,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '성별을 선택하지 않을래요',
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
      //               '약관 동의',
      //               style: TextStyle(fontWeight: FontWeight.w600),
      //             ),
      //           ),
      //         ),
      //         const SizedBox(height: 12),
      //         const Text(
      //           '필수 동의 항목',
      //           style: TextStyle(
      //             fontSize: 13,
      //             fontWeight: FontWeight.w600,
      //             color: Color(0xFF5C6B8A),
      //           ),
      //         ),
      //         const SizedBox(height: 6),
      //         Container(
      //           padding: const EdgeInsets.all(8),
      //           decoration: BoxDecoration(
      //             color: const Color(0xFFE6E9EE),
      //             borderRadius: BorderRadius.circular(8),
      //           ),
      //           child: Column(
      //             children: [
      //               CheckboxListTile(
      //                 contentPadding: EdgeInsets.zero,
      //                 dense: true,
      //                 title: const Text('[필수] 서비스 이용약관 동의'),
      //                 value: requiredA,
      //                 onChanged: (v) {
      //                   setState(() => requiredA = v ?? false);
      //                   _syncAllAgree();
      //                 },
      //                 controlAffinity: ListTileControlAffinity.leading,
      //               ),
      //               CheckboxListTile(
      //                 contentPadding: EdgeInsets.zero,
      //                 dense: true,
      //                 title: const Text('[필수] 개인정보 처리방침 동의'),
      //                 value: requiredB,
      //                 onChanged: (v) {
      //                   setState(() => requiredB = v ?? false);
      //                   _syncAllAgree();
      //                 },
      //                 controlAffinity: ListTileControlAffinity.leading,
      //               ),
      //             ],
      //           ),
      //         ),
      //         const SizedBox(height: 12),
      //         const Text(
      //           '선택 동의 항목',
      //           style: TextStyle(
      //             fontSize: 13,
      //             fontWeight: FontWeight.w600,
      //             color: Color(0xFF5C6B8A),
      //           ),
      //         ),
      //         const SizedBox(height: 6),
      //         Container(
      //           padding: const EdgeInsets.all(8),
      //           decoration: BoxDecoration(
      //             color: const Color(0xFFE6E9EE),
      //             borderRadius: BorderRadius.circular(8),
      //           ),
      //           child: Column(
      //             children: [
      //               CheckboxListTile(
      //                 contentPadding: EdgeInsets.zero,
      //                 dense: true,
      //                 title: const Text('[선택] 마케팅 수신 동의'),
      //                 value: optionalA,
      //                 onChanged: (v) {
      //                   setState(() => optionalA = v ?? false);
      //                   _syncAllAgree();
      //                 },
      //                 controlAffinity: ListTileControlAffinity.leading,
      //               ),
      //               CheckboxListTile(
      //                 contentPadding: EdgeInsets.zero,
      //                 dense: true,
      //                 title: const Text('[선택] 맞춤 추천 동의'),
      //                 value: optionalB,
      //                 onChanged: (v) {
      //                   setState(() => optionalB = v ?? false);
      //                   _syncAllAgree();
      //                 },
      //                 controlAffinity: ListTileControlAffinity.leading,
      //               ),
      //             ],
      //           ),
      //         ),
      //         const SizedBox(height: 12),
      //         Row(
      //           children: [
      //             Checkbox(
      //               value: allAgree,
      //               onChanged: (v) => _toggleAll(v ?? false),
      //             ),
      //             const SizedBox(width: 4),
      //             const Text('전체 약관 동의하기'),
      //           ],
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
      //                 onPressed: isAllRequiredChecked
      //                     ? () {
      //                         Get.to(() => const Testscreen());
      //                       }
      //                     : () {
      //                         ScaffoldMessenger.of(context).showSnackBar(
      //                           const SnackBar(
      //                             content: Text('필수 약관에 동의해 주세요.'),
      //                           ),
      //                         );
      //                       },
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
