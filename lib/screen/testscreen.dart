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

  // 이별 상대 선택 관련 상태 변수
  String? _selectedCategory; // '가족', '연인', '친구', '반려동물'
  String? _selectedFamilyMember; // 가족 세부 선택 (아버지, 어머니 등)

  bool _isNumeric(String value) => RegExp(r'^\d+$').hasMatch(value);

  bool get _canProceed {
    // final name = _nameController.text.trim();
    // final age = _ageController.text.trim();
    final hasValidBreakupSelection =
        _selectedCategory != null &&
        (_selectedCategory != '가족' || _selectedFamilyMember != null);
    // return name.isNotEmpty &&
    //     _isNumeric(age) &&
    //     _gender != null &&
    //     hasValidBreakupSelection;
    return hasValidBreakupSelection;
  }

  @override
  void dispose() {
    _nameController.dispose(); //메모리 해제
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
                                  Get.back();
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
                                      () => Testscreen2(
                                        selectedCategory: _selectedCategory,
                                      ),
                                      transition: Transition.fade,
                                    );
                                  }
                                : null,
                            // : () {
                            //     Get.to(
                            //       () => Testscreen2(
                            //         selectedCategory: _selectedCategory,
                            //       ), // 디버깅을 위한 임시
                            //       transition: Transition.fade,
                            //     );
                            //   },
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
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (_selectedCategory == '가족') {
                                            _selectedCategory = null;
                                            _selectedFamilyMember = null;
                                          } else {
                                            _selectedCategory = '가족';
                                            _selectedFamilyMember = null;
                                          }
                                        });
                                      },
                                      child: Container(
                                        width: 18,
                                        height: 18,
                                        decoration: BoxDecoration(
                                          color: _selectedCategory == '가족'
                                              ? const Color(0xFF65A0FF)
                                              : Colors.transparent,
                                          border: Border.all(
                                            color: _selectedCategory == '가족'
                                                ? const Color(0xFF65A0FF)
                                                : const Color(0xFFBDC7DB),
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                        child: _selectedCategory == '가족'
                                            ? const Icon(
                                                Icons.check,
                                                color: Colors.black,
                                                size: 14,
                                              )
                                            : null,
                                      ),
                                    ),
                                    Text(
                                      '가족',
                                      style: TextStyle(
                                        color: _selectedCategory == '가족'
                                            ? Colors.white
                                            : const Color(0xFFBDC7DB),
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
                            ],
                          ),
                        ),
                      ),
                      // 가족 세부 선택 (가족이 선택되었을 때만 표시)
                      if (_selectedCategory == '가족')
                        Positioned(
                          left: 16,
                          top: 318,
                          child: Container(
                            width: 380,
                            padding: const EdgeInsets.all(16),
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
                                          _buildFamilyOption('아버지'),
                                          const SizedBox(height: 8),
                                          _buildFamilyOption('어머니'),
                                          const SizedBox(height: 8),
                                          _buildFamilyOption('아들'),
                                          const SizedBox(height: 8),
                                          _buildFamilyOption('딸'),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          _buildFamilyOption('할아버지'),
                                          const SizedBox(height: 8),
                                          _buildFamilyOption('할머니'),
                                          const SizedBox(height: 8),
                                          _buildFamilyOption('남자형제'),
                                          const SizedBox(height: 8),
                                          _buildFamilyOption('여자형제'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      Positioned(
                        left: 16,
                        top: _selectedCategory == '가족' ? 498 : 338,
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
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (_selectedCategory == '연인') {
                                            _selectedCategory = null;
                                          } else {
                                            _selectedCategory = '연인';
                                            _selectedFamilyMember = null;
                                          }
                                        });
                                      },
                                      child: Container(
                                        width: 18,
                                        height: 18,
                                        decoration: BoxDecoration(
                                          color: _selectedCategory == '연인'
                                              ? const Color(0xFF65A0FF)
                                              : Colors.transparent,
                                          border: Border.all(
                                            color: _selectedCategory == '연인'
                                                ? const Color(0xFF65A0FF)
                                                : const Color(0xFFBDC7DB),
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                        child: _selectedCategory == '연인'
                                            ? const Icon(
                                                Icons.check,
                                                color: Colors.black,
                                                size: 14,
                                              )
                                            : null,
                                      ),
                                    ),
                                    Text(
                                      '연인',
                                      style: TextStyle(
                                        color: _selectedCategory == '연인'
                                            ? Colors.white
                                            : const Color(0xFFBDC7DB),
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
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        top: _selectedCategory == '가족' ? 556 : 396,
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
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (_selectedCategory == '친구') {
                                            _selectedCategory = null;
                                          } else {
                                            _selectedCategory = '친구';
                                            _selectedFamilyMember = null;
                                          }
                                        });
                                      },
                                      child: Container(
                                        width: 18,
                                        height: 18,
                                        decoration: BoxDecoration(
                                          color: _selectedCategory == '친구'
                                              ? const Color(0xFF65A0FF)
                                              : Colors.transparent,
                                          border: Border.all(
                                            color: _selectedCategory == '친구'
                                                ? const Color(0xFF65A0FF)
                                                : const Color(0xFFBDC7DB),
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                        child: _selectedCategory == '친구'
                                            ? const Icon(
                                                Icons.check,
                                                color: Colors.black,
                                                size: 14,
                                              )
                                            : null,
                                      ),
                                    ),
                                    Text(
                                      '친구',
                                      style: TextStyle(
                                        color: _selectedCategory == '친구'
                                            ? Colors.white
                                            : const Color(0xFFBDC7DB),
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
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        top: _selectedCategory == '가족' ? 614 : 454,
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
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          if (_selectedCategory == '반려동물') {
                                            _selectedCategory = null;
                                          } else {
                                            _selectedCategory = '반려동물';
                                            _selectedFamilyMember = null;
                                          }
                                        });
                                      },
                                      child: Container(
                                        width: 18,
                                        height: 18,
                                        decoration: BoxDecoration(
                                          color: _selectedCategory == '반려동물'
                                              ? const Color(0xFF65A0FF)
                                              : Colors.transparent,
                                          border: Border.all(
                                            color: _selectedCategory == '반려동물'
                                                ? const Color(0xFF65A0FF)
                                                : const Color(0xFFBDC7DB),
                                            width: 2,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                        child: _selectedCategory == '반려동물'
                                            ? const Icon(
                                                Icons.check,
                                                color: Colors.black,
                                                size: 14,
                                              )
                                            : null,
                                      ),
                                    ),
                                    Text(
                                      '반려동물',
                                      style: TextStyle(
                                        color: _selectedCategory == '반려동물'
                                            ? Colors.white
                                            : const Color(0xFFBDC7DB),
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

  Widget _buildFamilyOption(String text) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFamilyMember = text;
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 12),
        decoration: BoxDecoration(
          color: _selectedFamilyMember == text
              ? const Color(0xFF2A2D31)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            // color: _selectedFamilyMember == text
            //     ? const Color(0xFF65A0FF)                    //선택하면 배경 테두리 바뀌게 하는 부분
            //     : Colors.transparent,
            color: Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: _selectedFamilyMember == text
                    ? const Color(0xFF111111)
                    : Colors.transparent,
                border: Border.all(
                  color: _selectedFamilyMember == text
                      ? const Color(0xFF65A0FF)
                      : const Color(0xFFBDC7DB),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: _selectedFamilyMember == text
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
            const SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                color: _selectedFamilyMember == text
                    ? Colors.white
                    : const Color(0xFFBDC7DB),
                fontSize: 14,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
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
