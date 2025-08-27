import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'testscreen.dart';
import 'loginscreen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../state/user_controller.dart';

class LoginScreen2 extends StatefulWidget {
  const LoginScreen2({super.key});

  @override
  State<LoginScreen2> createState() => _LoginScreen2State();
}

class _LoginScreen2State extends State<LoginScreen2> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  String? _gender;

  // UserController 가져오기
  final UserController userController = Get.find<UserController>();

  static const String _baseUrl = 'http://10.0.2.2:8080';
  static const String _lossCasesEndpoint = '/auth/signup';

  bool get _isFormValid {
    return nameController.text.trim().isNotEmpty &&
        ageController.text.trim().isNotEmpty &&
        _gender != null;
  }
  // 검증 함수

  Future<bool> _performSignup() async {
    // userController.setuserId(userController.userId.value);
    // userController.setEmail(userController.userEmail.value);
    userController.setuserName(nameController.text.trim());
    userController.setuserAge(int.parse(ageController.text.trim()));
    userController.setuserGender(_gender ?? '');

    try {
      // API 명세서에 따른 요청 데이터 구성
      final requestData = {
        "email": userController.userEmail.value,
        "password": userController.userPassword.value,
        "name": nameController.text.trim(),
        "age": int.parse(ageController.text.trim()),
        "gender": _gender,
      };

      // 요청 데이터 로그 출력
      print('요청 데이터: ${json.encode(requestData)}');

      final response = await http.post(
        Uri.parse('$_baseUrl$_lossCasesEndpoint'),
        headers: {'Content-Type': 'application/json', 'accept': '*/*'},
        body: json.encode(requestData),
      );

      // 응답 상세 로그 출력
      print('응답 상태 코드: ${response.statusCode}');
      print('응답 헤더: ${response.headers}');
      print('응답 본문: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('정보 입력 성공: ${response.body}');
        Get.to(() => const Testscreen(), transition: Transition.fade);
        return true;
      } else {
        print('정보 입력 실패: ${response.statusCode} - ${response.body}');

        // 400 오류인 경우 더 자세한 정보 표시
        if (response.statusCode == 400) {
          try {
            final errorData = json.decode(response.body);
            final errorMessage =
                errorData['message'] ?? errorData['error'] ?? '잘못된 요청입니다.';
          } catch (e) {}
        } else {}
        return false;
      }
    } catch (e) {
      print('정보 입력 오류: $e');
      // 사용자에게 오류 메시지 표시

      return false;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
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
              padding: const EdgeInsets.fromLTRB(8, 12, 8, 8),
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

            // 프로그레스 바
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    width: 54.29,
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

                    SizedBox(height: 10),

                    // 서브 타이틀
                    Text(
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

                    SizedBox(height: 38),

                    // 사용자 이름 라벨
                    Text(
                      '사용자 이름',
                      style: TextStyle(
                        color: const Color(0xFFBDC7DB),
                        fontSize: 14,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                        height: 1.40,
                      ),
                    ),

                    SizedBox(height: 8),

                    // 이름 입력 필드
                    Container(
                      width: double.infinity,
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
                        keyboardType: TextInputType.text,
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

                    SizedBox(height: 38),

                    // 사용자 나이 라벨
                    Text(
                      '사용자 나이(만)',
                      style: TextStyle(
                        color: const Color(0xFFBDC7DB),
                        fontSize: 14,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                        height: 1.40,
                      ),
                    ),

                    SizedBox(height: 8),

                    // 나이 입력 필드
                    Container(
                      width: double.infinity,
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

                    SizedBox(height: 38),

                    // 사용자 성별 라벨
                    Text(
                      '사용자 성별',
                      style: TextStyle(
                        color: const Color(0xFFBDC7DB),
                        fontSize: 14,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                        height: 1.40,
                      ),
                    ),

                    SizedBox(height: 8),

                    // 성별 선택 버튼
                    Container(
                      width: double.infinity,
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
                                    borderRadius: BorderRadius.circular(100),
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
                                    borderRadius: BorderRadius.circular(100),
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

                    SizedBox(height: 18),

                    // 성별 선택하지 않음 옵션
                    Row(
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

                    SizedBox(height: 70),

                    // 다음으로 넘어가기 버튼
                    SizedBox(
                      width: double.infinity,
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
                                _performSignup();
                                Get.to(
                                  () => const Testscreen(),
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
