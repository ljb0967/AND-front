import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test1/screen/loginScreen2.dart';
import 'testscreen2.dart';
import '../state/loss_case_controller.dart';
import '../state/user_controller.dart';

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

  // 컨트롤러 가져오기
  final LossCaseController lossCaseController = Get.find<LossCaseController>();
  final UserController userController = Get.find<UserController>();

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

            // 프로그레스 바
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: Row(
                children: [
                  Container(
                    width: 108.58,
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

                    // 이별 상대 선택 라벨
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

                    SizedBox(height: 16),

                    // 가족 선택 옵션
                    Container(
                      width: double.infinity,
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
                      child: Row(
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
                                borderRadius: BorderRadius.circular(4),
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
                          SizedBox(width: 12),
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

                    // 가족 세부 선택 (가족이 선택되었을 때만 표시)
                    if (_selectedCategory == '가족') ...[
                      SizedBox(height: 16),
                      Container(
                        width: double.infinity,
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
                    ],

                    SizedBox(height: 16),

                    // 연인 선택 옵션
                    Container(
                      width: double.infinity,
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
                      child: Row(
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
                                borderRadius: BorderRadius.circular(4),
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
                          SizedBox(width: 12),
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

                    SizedBox(height: 16),

                    // 친구 선택 옵션
                    Container(
                      width: double.infinity,
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
                      child: Row(
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
                                borderRadius: BorderRadius.circular(4),
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
                          SizedBox(width: 12),
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

                    SizedBox(height: 16),

                    // 반려동물 선택 옵션
                    Container(
                      width: double.infinity,
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
                      child: Row(
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
                                borderRadius: BorderRadius.circular(4),
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
                          SizedBox(width: 12),
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

                    SizedBox(height: 130),

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
                                // 선택된 카테고리를 LossCaseController에 저장
                                if (_selectedCategory == '가족') {
                                  lossCaseController.setSubject('FAMILY');
                                } else if (_selectedCategory == '연인') {
                                  lossCaseController.setSubject('LOVER');
                                } else if (_selectedCategory == '친구') {
                                  lossCaseController.setSubject('FRIEND');
                                } else if (_selectedCategory == '반려동물') {
                                  lossCaseController.setSubject('PET');
                                }

                                // 사용자 정보도 함께 저장
                                lossCaseController.setUserInfo(
                                  email: userController.userEmail.value,
                                  pw: userController.userPassword.value,
                                  name: userController.userName.value,
                                  age: userController.userAge.value,
                                  gender: userController.userGender.value,
                                );

                                print('Testscreen1 데이터 저장 완료');
                                lossCaseController.printCurrentData();

                                Get.to(
                                  () => Testscreen2(
                                    selectedCategory: _selectedCategory,
                                  ),
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
