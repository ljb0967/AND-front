import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'loginScreen2.dart';
import 'registerscreen.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  bool _isMember = true; // 회원 탭이 기본 선택

  // 로그인 검증 상태 관리
  bool _isLoggingIn = false;
  String _loginError = '';

  // 로그인 검증
  Future<void> _validateLogin(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      setState(() {
        _loginError = '이메일과 비밀번호를 모두 입력해주세요';
      });
      return;
    }

    setState(() {
      _isLoggingIn = true;
      _loginError = '';
    });

    try {
      // TODO: 백엔드 API 호출하여 로그인 검증
      // final response = await apiService.login(email, password);
      //
      // if (response.success) {
      //   // 로그인 성공 시 다음 화면으로 이동
      //   Get.to(() => const LoginScreen2(), transition: Transition.fade);
      // } else {
      //   setState(() {
      //     _loginError = '이메일 주소 또는 비밀번호가 일치하지 않아요';
      //   });

      if (email == 'ljb0967@naver.com' && password == 'a12345678') {
        //디버깅 용
        Get.to(() => const LoginScreen2(), transition: Transition.fade);
      }

      // 임시로 항상 실패로 처리 (백엔드 구현 전)
      await Future.delayed(const Duration(milliseconds: 500)); // API 호출 시뮬레이션
      setState(() {
        _loginError = '이메일 주소 또는 비밀번호가 일치하지 않아요';
      });
    } catch (e) {
      setState(() {
        _loginError = '로그인 중 오류가 발생했습니다';
      });
    } finally {
      setState(() {
        _isLoggingIn = false;
      });
    }
  }

  // 로그인 API 호출 (백엔드 구현 필요)
  Future<void> _performLogin(String email, String password) async {
    // TODO: 백엔드 API 구현
    // try {
    //   final response = await apiService.login({
    //     'email': email,
    //     'password': password,
    //   });
    //
    //   if (response.success) {
    //     Get.to(() => const LoginScreen2(), transition: Transition.fade);
    //   } else {
    //     setState(() {
    //       _loginError = '이메일 주소 또는 비밀번호가 일치하지 않아요';
    //     });
    //   }
    // } catch (e) {
    //   print('로그인 오류: $e');
    //   setState(() {
    //     _loginError = '로그인 중 오류가 발생했습니다';
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController idController = TextEditingController();
    final TextEditingController pwController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      body: SafeArea(
        child: Column(
          children: [
            // 상단 여백
            SizedBox(height: 43.45),

            // 로고
            Padding(
              padding: EdgeInsets.only(right: 283.64),
              child: Image.asset('image/home_image.png', height: 20),
            ),

            SizedBox(height: 36.55),

            // 메인 타이틀
            Padding(
              padding: EdgeInsets.only(right: 165),
              child: Text(
                '끝, 그리고 그 다음\n어서오세요 AND 입니다',
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

            SizedBox(height: 4),

            // 서브 타이틀
            Padding(
              padding: EdgeInsets.only(right: 117),
              child: Text(
                '회원 / 비회원 / SNS 계정 로그인이 가능해요',
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

            SizedBox(height: 36),

            // 회원/비회원 탭
            Row(
              children: [
                // 회원 탭
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isMember = true;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        '회원',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                          height: 1.40,
                        ),
                      ),
                    ),
                  ),
                ),

                // 비회원 탭
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isMember = false;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        '비회원',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                          height: 1.40,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // 하단 흰색 바
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 2,
                    decoration: BoxDecoration(
                      color: _isMember ? Colors.white : const Color(0xFF232529),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 2,
                    decoration: BoxDecoration(
                      color: !_isMember
                          ? Colors.white
                          : const Color(0xFF232529),
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 34),

            // 메인 콘텐츠 영역 (스크롤 가능)
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  children: [
                    // 회원 로그인 섹션
                    if (_isMember) ...[
                      Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '회원 로그인',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                              height: 1.40,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 22),

                      // 이메일 입력 필드
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
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
                          controller: idController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                            color: const Color(0xFF8A9099),
                            fontSize: 16,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            height: 1.40,
                          ),
                          decoration: InputDecoration(
                            isCollapsed: true,
                            border: InputBorder.none,
                            hintText: "이메일 주소 입력",
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

                      SizedBox(height: 18),

                      // 비밀번호 입력 필드
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
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
                          obscureText: true,
                          controller: pwController,
                          style: TextStyle(
                            color: const Color(0xFF8A9099),
                            fontSize: 16,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            height: 1.40,
                          ),
                          decoration: InputDecoration(
                            isCollapsed: true,
                            border: InputBorder.none,
                            hintText: "비밀번호 입력",
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

                      SizedBox(height: 12),

                      // 로그인 오류 메시지
                      if (_loginError.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            _loginError,
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 12,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),

                      SizedBox(height: 15),

                      // 로그인 버튼
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isLoggingIn
                                ? const Color(0xFF7F8694)
                                : const Color(0xFF65A0FF),
                            disabledBackgroundColor: const Color(0xFF7F8694),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: _isLoggingIn
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              Colors.white,
                                            ),
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      '로그인 중...',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w600,
                                        height: 1.40,
                                      ),
                                    ),
                                  ],
                                )
                              : Text(
                                  '로그인',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w600,
                                    height: 1.40,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                          onPressed: _isLoggingIn
                              ? null
                              : () {
                                  _validateLogin(
                                    idController.text,
                                    pwController.text,
                                  );
                                },
                        ),
                      ),

                      SizedBox(height: 20),

                      // 하단 링크들
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '아이디 찾기',
                            style: TextStyle(
                              color: const Color(0xFFBDC7DB),
                              fontSize: 14,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              height: 1.40,
                            ),
                          ),
                          SizedBox(width: 12),
                          Container(
                            width: 1,
                            height: 14,
                            decoration: ShapeDecoration(
                              color: const Color(0xFF2D2F33),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          Text(
                            '비밀번호 찾기',
                            style: TextStyle(
                              color: const Color(0xFFBDC7DB),
                              fontSize: 14,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              height: 1.40,
                            ),
                          ),
                          SizedBox(width: 12),
                          Container(
                            width: 1,
                            height: 14,
                            decoration: ShapeDecoration(
                              color: const Color(0xFF2D2F33),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                          ),
                          SizedBox(width: 12),
                          TextButton(
                            onPressed: () {
                              Get.to(
                                () => const Registerscreen(),
                                transition: Transition.fade,
                              );
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size(0, 0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              '회원가입',
                              style: TextStyle(
                                color: const Color(0xFFBDC7DB),
                                fontSize: 14,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w500,
                                height: 1.40,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],

                    // 비회원 로그인 섹션
                    if (!_isMember) ...[
                      Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '비회원 로그인',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                              height: 1.40,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 32),

                      Padding(
                        padding: EdgeInsets.only(left: 16),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '① 일부 서비스 이용에 제한이 있을 수 있어요',
                            style: TextStyle(
                              color: const Color(0xFFBDC7DB),
                              fontSize: 14,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              height: 1.40,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 107),

                      // 비회원 로그인 버튼
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF65A0FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            '로그인',
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
                              () => const LoginScreen2(),
                              transition: Transition.fade,
                            );
                          },
                        ),
                      ),

                      SizedBox(height: 20),

                      // 비회원 회원가입 버튼
                      Center(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero, // ← 기본 패딩 제거
                            minimumSize: Size(0, 0), // ← 최소 크기도 제거
                            tapTargetSize:
                                MaterialTapTargetSize.shrinkWrap, // ← 터치 영역 축소
                          ),
                          onPressed: () {
                            Get.to(
                              () => const Registerscreen(),
                              transition: Transition.fade,
                            );
                          },
                          child: Text(
                            '회원가입',
                            style: TextStyle(
                              color: const Color(0xFFBDC7DB),
                              fontSize: 14,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              height: 1.40,
                            ),
                          ),
                        ),
                      ),
                    ],

                    // SNS 계정 로그인 섹션 (공통)
                    SizedBox(height: 42),

                    Center(
                      child: Text(
                        'SNS 계정 로그인',
                        style: TextStyle(
                          color: const Color(0xFFBDC7DB),
                          fontSize: 14,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                          height: 1.40,
                        ),
                      ),
                    ),

                    SizedBox(height: 22),

                    // SNS 로그인 버튼들
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFFEE500),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            image: DecorationImage(
                              image: AssetImage('image/kakao.png'),
                            ),
                          ),
                        ),
                        SizedBox(width: 24),
                        Container(
                          width: 40,
                          height: 40,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF03C75A),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            image: DecorationImage(
                              image: AssetImage('image/naver.png'),
                            ),
                          ),
                        ),
                        SizedBox(width: 24),
                        Container(
                          width: 40,
                          height: 40,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            image: DecorationImage(
                              image: AssetImage('image/google.png'),
                            ),
                          ),
                        ),
                        SizedBox(width: 24),
                        Container(
                          width: 40,
                          height: 40,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            image: DecorationImage(
                              image: AssetImage('image/apple.png'),
                            ),
                          ),
                        ),
                      ],
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
