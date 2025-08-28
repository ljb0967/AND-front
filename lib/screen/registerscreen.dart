import 'package:flutter/material.dart';
import 'package:test1/screen/loginscreen.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Registerscreen extends StatefulWidget {
  const Registerscreen({super.key});

  @override
  State<Registerscreen> createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final TextEditingController pwoConfirmController = TextEditingController();

  // API 서비스
  // Android 에뮬레이터: 10.0.2.2, 실제 기기: 컴퓨터 IP 주소
  static const String _baseUrl = 'http://10.0.2.2:8080';
  static const String _lossCasesEndpoint = '/auth/signup';

  // 약관 동의 상태 관리
  bool _allTermsAgreed = false;
  bool _serviceTermsAgreed = false;
  bool _privacyTermsAgreed = false;
  bool _photoGalleryAgreed = false;
  bool _sensitiveInfoAgreed = false;
  bool _outsourcingTermsAgreed = false;
  bool _pushNotificationAgreed = false;
  bool _additionalServiceAgreed = false;

  // 입력 필드 검증 상태 관리
  bool _isEmailValid = false;
  bool _isPasswordValid = false;
  bool _isPasswordConfirmValid = false;
  bool _isEmailRegistered = false;
  bool _isPasswordRegistered = false;

  // 오류 메시지
  String _emailError = '';
  String _passwordError = '';
  String _passwordConfirmError = '';

  // 이메일 형식 검증
  bool _validateEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  // 비밀번호 조건 검증
  bool _validatePassword(String password) {
    return password.length >= 8 &&
        password.contains(RegExp(r'[0-9]')) &&
        password.contains(RegExp(r'[a-zA-Z]'));
  }

  // 이메일 입력 검증
  void _validateEmailInput() {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      setState(() {
        _isEmailValid = false;
        _emailError = '';
      });
      return;
    }

    if (!_validateEmail(email)) {
      setState(() {
        _isEmailValid = false;
        _emailError = '올바른 이메일 형식이 아니에요';
      });
      return;
    }

    // 백엔드 API 호출하여 이미 가입된 이메일인지 확인
    _checkEmailAvailability(email);

    setState(() {
      _isEmailValid = true;
      _emailError = '';
    });
  }

  // 비밀번호 입력 검증
  void _validatePasswordInput() {
    final password = pwController.text;
    if (password.isEmpty) {
      setState(() {
        _isPasswordValid = false;
        _passwordError = '';
      });
      return;
    }

    if (!_validatePassword(password)) {
      setState(() {
        _isPasswordValid = false;
        _passwordError = '숫자, 영문 포함 8자리 이상 입력해주세요';
      });
      return;
    }

    // 백엔드 API 호출하여 이미 사용된 비밀번호인지 확인
    _checkPasswordAvailability(password);

    setState(() {
      _isPasswordValid = true;
      _passwordError = '';
    });

    // 비밀번호가 변경되면 비밀번호 확인도 다시 검증
    if (pwoConfirmController.text.isNotEmpty) {
      _validatePasswordConfirmInput();
    }
  }

  // 비밀번호 확인 입력 검증
  void _validatePasswordConfirmInput() {
    final password = pwController.text;
    final passwordConfirm = pwoConfirmController.text;

    if (passwordConfirm.isEmpty) {
      setState(() {
        _isPasswordConfirmValid = false;
        _passwordConfirmError = '';
      });
      return;
    }

    if (password != passwordConfirm) {
      setState(() {
        _isPasswordConfirmValid = false;
        _passwordConfirmError = '비밀번호가 일치하지 않아요';
      });
      return;
    }

    setState(() {
      _isPasswordConfirmValid = true;
      _passwordConfirmError = '';
    });
  }

  // 이메일 가용성 확인 (백엔드 API 호출)
  Future<void> _checkEmailAvailability(String email) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/users/check-email?email=$email'),
        headers: {'Content-Type': 'application/json', 'accept': '*/*'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final isRegistered = data['exists'] ?? false;

        setState(() {
          _isEmailRegistered = isRegistered;
          if (_isEmailRegistered) {
            _isEmailValid = false;
            _emailError = '이미 가입된 이메일 주소예요';
          } else {
            _isEmailValid = true;
            _emailError = '';
          }
        });
      } else {
        // API 응답이 실패한 경우, 기본적으로 사용 가능한 것으로 처리
        setState(() {
          _isEmailRegistered = false;
          _isEmailValid = true;
          _emailError = '';
        });
      }
    } catch (e) {
      print('이메일 가용성 확인 오류: $e');
      // 네트워크 오류 등의 경우, 기본적으로 사용 가능한 것으로 처리
      setState(() {
        _isEmailRegistered = false;
        _isEmailValid = true;
        _emailError = '';
      });
    }
  }

  // 비밀번호 가용성 확인 (백엔드 API 호출)
  Future<void> _checkPasswordAvailability(String password) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/users/check-password?password=$password'),
        headers: {'Content-Type': 'application/json', 'accept': '*/*'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final isRegistered = data['exists'] ?? false;

        setState(() {
          _isPasswordRegistered = isRegistered;
          if (_isPasswordRegistered) {
            _isPasswordValid = false;
            _passwordError = '이미 사용된 비밀번호예요';
          } else {
            _isPasswordValid = true;
            _passwordError = '';
          }
        });
      } else {
        // API 응답이 실패한 경우, 기본적으로 사용 가능한 것으로 처리
        setState(() {
          _isPasswordRegistered = false;
          _isPasswordValid = true;
          _passwordError = '';
        });
      }
    } catch (e) {
      print('비밀번호 가용성 확인 오류: $e');
      // 네트워크 오류 등의 경우, 기본적으로 사용 가능한 것으로 처리
      setState(() {
        _isPasswordRegistered = false;
        _isPasswordValid = true;
        _passwordError = '';
      });
    }
  }

  // 전체 약관 동의 처리
  void _toggleAllTerms() {
    setState(() {
      _allTermsAgreed = !_allTermsAgreed;
      if (_allTermsAgreed) {
        _serviceTermsAgreed = true;
        _privacyTermsAgreed = true;
        _photoGalleryAgreed = true;
        _sensitiveInfoAgreed = true;
        _outsourcingTermsAgreed = true;
        _pushNotificationAgreed = true;
        _additionalServiceAgreed = true;
      } else {
        _serviceTermsAgreed = false;
        _privacyTermsAgreed = false;
        _photoGalleryAgreed = false;
        _sensitiveInfoAgreed = false;
        _outsourcingTermsAgreed = false;
        _pushNotificationAgreed = false;
        _additionalServiceAgreed = false;
      }
    });
  }

  // 개별 약관 동의 처리
  void _toggleIndividualTerm(String termType) {
    setState(() {
      switch (termType) {
        case 'service':
          _serviceTermsAgreed = !_serviceTermsAgreed;
          break;
        case 'privacy':
          _privacyTermsAgreed = !_privacyTermsAgreed;
          break;
        case 'photoGallery':
          _photoGalleryAgreed = !_photoGalleryAgreed;
          break;
        case 'sensitiveInfo':
          _sensitiveInfoAgreed = !_sensitiveInfoAgreed;
          break;
        case 'outsourcing':
          _outsourcingTermsAgreed = !_outsourcingTermsAgreed;
          break;
        case 'pushNotification':
          _pushNotificationAgreed = !_pushNotificationAgreed;
          break;
        case 'additionalService':
          _additionalServiceAgreed = !_additionalServiceAgreed;
          break;
      }

      // 모든 개별 약관이 동의되었는지 확인하여 전체 동의 상태 업데이트
      // _allTermsAgreed =
      //     _serviceTermsAgreed &&
      //     _privacyTermsAgreed &&
      //     _photoGalleryAgreed &&
      //     _sensitiveInfoAgreed &&
      //     _outsourcingTermsAgreed &&
      //     _pushNotificationAgreed &&
      //     _additionalServiceAgreed;

      _allTermsAgreed =
          _serviceTermsAgreed &&
          _privacyTermsAgreed &&
          _photoGalleryAgreed &&
          _sensitiveInfoAgreed;
    });
  }

  // 모든 필수 항목이 완료되었는지 확인
  bool get _isFormComplete {
    return _isEmailValid &&
        _isPasswordValid &&
        _isPasswordConfirmValid &&
        _allTermsAgreed;
  }

  // 회원가입 처리
  void _handleSignup() async {
    if (!_isFormComplete) {
      // 모든 필수 항목이 완료되지 않은 경우 처리
      return;
    }

    // 백엔드 API 호출하여 회원가입 처리
    final success = await _performSignup();

    if (success) {
      // 성공 시 로그인 화면으로 이동
      Get.to(() => const Loginscreen(), transition: Transition.fade);
    }
  }

  // 회원가입 API 호출 (백엔드 구현)
  Future<bool> _performSignup() async {
    try {
      // API 명세서에 따른 요청 데이터 구성
      final requestData = {
        "email": emailController.text.trim(),
        "password": pwController.text,
        "name": "string",
        "age": 0,
        "gender": "string",
      };

      // 요청 데이터 로그 출력P
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
        print('회원가입 성공: ${response.body}');
        _showErrorDialog('회원가입 성공! 로그인 화면으로 이동합니다.');
        return true;
      } else {
        print('회원가입 실패: ${response.statusCode} - ${response.body}');

        // 400 오류인 경우 더 자세한 정보 표시
        if (response.statusCode == 400) {
          try {
            final errorData = json.decode(response.body);
            final errorMessage =
                errorData['message'] ?? errorData['error'] ?? '잘못된 요청입니다.';
            _showErrorDialog('회원가입 실패: $errorMessage');
          } catch (e) {
            _showErrorDialog('회원가입에 실패했습니다. (400 오류)\n서버 로그를 확인해주세요.');
          }
        } else {
          _showErrorDialog('회원가입에 실패했습니다. 다시 시도해주세요.');
        }
        return false;
      }
    } catch (e) {
      print('회원가입 오류: $e');
      // 사용자에게 오류 메시지 표시
      _showErrorDialog('네트워크 오류가 발생했습니다. 다시 시도해주세요.');
      return false;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    pwController.dispose();
    pwoConfirmController.dispose();
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
                      '회원가입',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        height: 1.40,
                        letterSpacing: -0.50,
                      ),
                    ),

                    SizedBox(height: 16),

                    // 서브 타이틀
                    Text(
                      'AND의 소중한 회원이 되어주셔서 감사해요',
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

                    // 이메일 입력 필드
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
                          side: BorderSide(
                            color: _emailError.isNotEmpty
                                ? Colors.red
                                : _isEmailValid
                                ? Colors.green
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (value) => _validateEmailInput(),
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
                          if (_isEmailValid)
                            Icon(
                              Icons.check,
                              color: const Color(0xFF4CAF50),
                              size: 24,
                            ),
                        ],
                      ),
                    ),

                    // 이메일 오류 메시지
                    if (_emailError.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 8, left: 4),
                        child: Text(
                          _emailError,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                    SizedBox(height: 16),

                    // 비밀번호 입력 필드
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
                          side: BorderSide(
                            color: _passwordError.isNotEmpty
                                ? Colors.red
                                : _isPasswordValid
                                ? Colors.green
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              obscureText: true,
                              controller: pwController,
                              onChanged: (value) => _validatePasswordInput(),
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
                                hintText: "비밀번호 입력(숫자, 영문 포함 8자리 이상)",
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
                          if (_isPasswordValid)
                            Icon(
                              Icons.check,
                              color: const Color(0xFF4CAF50),
                              size: 24,
                            ),
                        ],
                      ),
                    ),

                    // 비밀번호 오류 메시지
                    if (_passwordError.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 8, left: 4),
                        child: Text(
                          _passwordError,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                    SizedBox(height: 16),

                    // 비밀번호 확인 입력 필드
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
                          side: BorderSide(
                            color: _passwordConfirmError.isNotEmpty
                                ? Colors.red
                                : _isPasswordConfirmValid
                                ? Colors.green
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              obscureText: true,
                              controller: pwoConfirmController,
                              onChanged: (value) =>
                                  _validatePasswordConfirmInput(),
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
                                hintText: "비밀번호 재입력",
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
                          if (_isPasswordConfirmValid)
                            Icon(
                              Icons.check,
                              color: const Color(0xFF4CAF50),
                              size: 24,
                            ),
                        ],
                      ),
                    ),

                    // 비밀번호 확인 오류 메시지
                    if (_passwordConfirmError.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 8, left: 4),
                        child: Text(
                          _passwordConfirmError,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                    SizedBox(height: 32),

                    // 약관 동의 섹션
                    Text(
                      '약관 동의',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        height: 1.40,
                        letterSpacing: -0.50,
                      ),
                    ),

                    SizedBox(height: 24),

                    // 전체 약관 동의
                    Container(
                      width: double.infinity,
                      height: 48,
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
                            onTap: _toggleAllTerms,
                            child: Container(
                              width: 18,
                              height: 18,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: _allTermsAgreed
                                      ? const Color(0xFF65A0FF)
                                      : const Color(0xFF7F8694),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(4),
                                color: _allTermsAgreed
                                    ? const Color(0xFF65A0FF)
                                    : Colors.transparent,
                              ),
                              child: _allTermsAgreed
                                  ? const Icon(
                                      Icons.check,
                                      size: 14,
                                      color: Colors.white,
                                    )
                                  : null,
                            ),
                          ),
                          SizedBox(width: 12),
                          Text(
                            '약관 전체 동의',
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
                    ),

                    SizedBox(height: 24),

                    // 개별 약관 동의 항목들
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Column(
                              children: [
                                _buildTermItem('service', '(필수) 서비스 이용약관 동의'),
                                SizedBox(height: 8),
                                _buildTermItem(
                                  'privacy',
                                  '(필수) 개인정보 수집 및 이용 동의',
                                ),
                                SizedBox(height: 8),
                                _buildTermItem(
                                  'photoGallery',
                                  '(필수) 사진/갤러리 접근 권한 동의',
                                ),
                                SizedBox(height: 8),
                                _buildTermItem(
                                  'sensitiveInfo',
                                  '(필수) 민감정보 처리 동의',
                                ),
                                // SizedBox(height: 8),
                                // _buildTermItem(
                                //   'outsourcing',
                                //   '(필수) 개인정보 처리 위탁 및 제3자 제공 동의',
                                // ),
                                SizedBox(height: 8),
                                _buildTermItem(
                                  'pushNotification',
                                  '(선택) 푸시 알림 수신 동의',
                                ),
                                SizedBox(height: 8),
                                _buildTermItem(
                                  'additionalService',
                                  '(선택) 부가 서비스 이용 동의',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 110),

                    // 회원가입 버튼
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _isFormComplete
                              ? const Color(0xFF65A0FF)
                              : const Color(0xFF1F2124),
                          disabledBackgroundColor: const Color(0xFF1F2124),
                          foregroundColor: _isFormComplete
                              ? Colors.white
                              : const Color(0xFF8A9099),
                          disabledForegroundColor: const Color(0xFF8A9099),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          '회원가입',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            height: 1.40,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        onPressed: _isFormComplete ? _handleSignup : null,
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

  // 오류 다이얼로그 표시
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1F2124),
          title: Text(
            '오류',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Text(
            message,
            style: TextStyle(
              color: const Color(0xFFBDC7DB),
              fontSize: 14,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                '확인',
                style: TextStyle(
                  color: const Color(0xFF65A0FF),
                  fontSize: 16,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog2(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1F2124),
          title: Text(
            '약관 내용',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
            ),
          ),
          content: SingleChildScrollView(
            child: Text(
              message,
              style: TextStyle(
                color: const Color(0xFFBDC7DB),
                fontSize: 14,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                '확인',
                style: TextStyle(
                  color: const Color(0xFF65A0FF),
                  fontSize: 16,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // 개별 약관 동의 항목 위젯
  Widget _buildTermItem(String termType, String title) {
    bool isAgreed = false;
    String text = "";
    switch (termType) {
      case 'service':
        isAgreed = _serviceTermsAgreed;
        break;
      case 'privacy':
        isAgreed = _privacyTermsAgreed;
        break;
      case 'photoGallery':
        isAgreed = _photoGalleryAgreed;
        break;
      case 'sensitiveInfo':
        isAgreed = _sensitiveInfoAgreed;
        break;
      case 'outsourcing':
        isAgreed = _outsourcingTermsAgreed;
        break;
      case 'pushNotification':
        isAgreed = _pushNotificationAgreed;
        break;
      case 'additionalService':
        isAgreed = _additionalServiceAgreed;
        break;
    }

    // title을 안전하게 분할
    final parts = title.split(') ');
    final prefix = parts.length > 1 ? parts[0] + ') ' : '';
    final suffix = parts.length > 1 ? parts[1] : title;

    if (suffix == '서비스 이용약관 동의') {
      text = '''제1조 (목적)
이 약관은 [AND] (이하 "회사")가 제공하는 서비스(이하 "서비스")의 이용과 관련하여 회사와 이용자 간의 권리, 의무 및 책임사항을 규정함을 목적으로 합니다.

제2조 (정의)
① "서비스"란 회사가 제공하는 모바일 애플리케이션 및 그와 관련된 모든 부가 서비스를 의미합니다.
② "이용자"란 본 약관에 동의하고 서비스를 이용하는 자를 말합니다.
③ "유료서비스"란 이용자가 결제를 통해 구매할 수 있는 디지털 콘텐츠 및 물품(예: 도서, 향초 등)을 의미합니다.

제3조 (약관의 효력 및 변경)
① 회사는 본 약관의 내용을 이용자가 쉽게 알 수 있도록 서비스 내에 게시합니다.
② 회사는 관련 법령을 위배하지 않는 범위에서 본 약관을 변경할 수 있으며, 변경 시 이용자에게 사전 공지합니다.

제4조 (서비스의 제공 및 변경)
① 회사는 다음과 같은 서비스를 제공합니다.
1. 일일문답 및 기록 서비스
2. 사진 업로드 및 갤러리 기능
3. 유료 상점(도서, 향초 등) 구매 서비스
② 회사는 서비스의 일부 또는 전부를 변경할 수 있으며, 중요한 변경 시 이용자에게 사전 공지합니다.

제5조 (서비스 이용 제한 및 중단)
① 회사는 다음 사유가 발생하는 경우 서비스 제공을 일시적으로 제한하거나 중단할 수 있습니다.
1. 시스템 점검 또는 개선
2. 천재지변, 정전, 통신 두절 등 불가항력적 사유
3. 기타 운영상 필요

제6조 (이용자의 의무)
① 이용자는 서비스 이용 시 다음 행위를 해서는 안 됩니다.
1. 타인의 정보를 도용하거나 허위 정보 입력
2. 저작권, 초상권 등 제3자의 권리 침해
3. 불법적이거나 부적절한 콘텐츠 업로드
② 이용자가 위 의무를 위반할 경우 회사는 이용을 제한하거나 계약을 해지할 수 있습니다.

제7조 (사진 및 콘텐츠 이용 관련 동의)
① 이용자가 서비스에 업로드한 사진, 글, 기타 콘텐츠는 본인의 소유이며, 회사는 서비스 운영을 위해 필요한 범위에서 이를 활용할 수 있습니다.
② 회사는 이용자의 사전 동의 없이 상업적 목적으로 이용자의 콘텐츠를 활용하지 않습니다.

제8조 (유료서비스 및 결제)
① 회사는 유료서비스에 대한 가격, 결제 방법, 환불 정책 등을 서비스 내에 명시합니다.
② 미성년자가 유료서비스를 이용할 경우 법정대리인의 동의가 필요합니다.
③ 환불은 관련 법령 및 회사의 환불 정책에 따릅니다.

제9조 (계약 해지 및 이용제한)
① 이용자가 서비스 탈퇴를 요청하면 회사는 관련 법령에 따라 즉시 회원 탈퇴를 처리합니다.
② 회사는 이용자가 본 약관을 위반할 경우 서비스 이용을 제한할 수 있습니다.

제10조 (면책조항)
① 회사는 천재지변, 통신망 장애 등 불가항력적 사유로 서비스를 제공할 수 없는 경우 책임을 지지 않습니다.
② 회사는 이용자 간 또는 이용자와 제3자 간에 발생한 분쟁에 개입하지 않으며, 이에 대한 책임을 지지 않습니다.

''';
    } else if (suffix == '개인정보 수집 및 이용 동의') {
      text = '''제1조 (수집하는 개인정보 항목)
회사는 서비스 제공을 위해 다음과 같은 개인정보를 수집할 수 있습니다.
① 회원 가입 시: 이름, 이메일, 비밀번호
② 유료결제 시: 결제 수단 정보(신용카드, 계좌번호 등), 구매 내역
③ 서비스 이용 시: 사진, 기록, 기기정보(접속IP, 쿠키, OS 등)

제2조 (개인정보의 수집 및 이용 목적)
① 서비스 회원가입 및 관리
② 서비스 제공 및 맞춤형 질문 추천
③ 유료서비스 결제 및 환불 처리
④ 불법·부정 이용 방지 및 분쟁 해결

제3조 (개인정보의 보관 및 이용 기간)
① 회사는 원칙적으로 개인정보 수집 및 이용 목적이 달성되면 지체 없이 파기합니다.
② 다만, 관련 법령에 따라 일정 기간 보관할 필요가 있는 경우 해당 기간 동안 보관합니다.

제4조 (개인정보의 제3자 제공)
회사는 원칙적으로 이용자의 개인정보를 제3자에게 제공하지 않습니다.
다만, 법령에 의거하여 요구되는 경우에 한해 예외적으로 제공할 수 있습니다.

제5조 (개인정보 처리의 위탁)
회사는 서비스 운영 및 결제 처리를 위해 일부 업무를 외부에 위탁할 수 있으며, 위탁업체 및 위탁 내용은 서비스 내에 공개합니다.

제6조 (이용자의 권리)
① 이용자는 언제든지 자신의 개인정보를 열람·정정·삭제·처리정지를 요구할 수 있습니다.
② 회사는 관련 법령에 따라 지체 없이 필요한 조치를 취합니다.

제7조 (개인정보 보호를 위한 노력)
회사는 개인정보 보호를 위해 기술적·관리적·물리적 안전 조치를 취합니다.

제8조 (문의처)
개인정보 관련 문의는 아래를 통해 접수할 수 있습니다.
[김루빈/01099156195]
''';
    } else if (suffix == '사진/갤러리 접근 권한 동의') {
      text = '''제1조 (목적)
본 앱은 사용자가 기록하는 이별 관리 및 추억 회고 기능 제공을 위하여 기기 내 저장된 사진 및 갤러리에 접근할 수 있습니다.

제2조 (이용 범위)
①사용자가 자발적으로 선택한 사진을 앱 내에 업로드하거나 기록으로 저장할 수 있습니다.
②앱은 사용자의 명시적 동의 없이 사진 전체를 자동으로 수집하지 않으며, 선택한 사진만 저장·이용합니다.
③접근 권한은 언제든 단말기 설정을 통해 철회할 수 있습니다.

''';
    } else if (suffix == '민감정보 처리 동의') {
      text = '''제1조 (처리 목적) 
본 앱은 이별 경험, 감정 기록, 심리 상태 등 「개인정보 보호법」 제23조에 따른 민감정보를 수집·이용할 수 있습니다. 

제2조 (처리 항목) 
① 감정 기록(슬픔, 분노, 불안 등) 
② 이별 관련 서술(대상, 사유 등) 
③ 사용자가 직접 작성한 개인 회고 내용 

제3조 (보관 및 파기)
수집된 민감정보는 앱 서비스 제공 목적 달성 시 즉시 파기됩니다. 사용자가 계정을 삭제하는 경우, 기록된 모든 민감정보는 복구 불가능한 방식으로 영구 삭제됩니다.
''';
    } else if (suffix == '개인정보 처리 위탁 및 제3자 제공 동의') {
      text = '''개인정보 처리 위탁 및 제3자 제공 동의''';
    } else if (suffix == '푸시 알림 수신 동의') {
      text = '''제1조 (목적)
본 앱은 사용자에게 서비스 이용 편의성을 제공하기 위하여 푸시 알림을 발송할 수 있습니다. 

제2조 (알림 내용) 
① 퀘스트 및 감정 기록 알림 
② 회고 및 자기관리 리마인더 서비스 
③ 공지사항 및 이용 관련 필수 안내 

제3조 (수신 관리)
사용자는 단말기 또는 앱 설정을 통해 언제든 수신을 차단할 수 있습니다. 필수 서비스 공지 알림은 동의 여부와 관계없이 발송될 수 있습니다.
''';
    } else if (suffix == '부가 서비스 이용 동의') {
      text = '''제1조 (정의)
본 앱은 기본 서비스 외에 별도로 판매되는 상품 또는 부가 콘텐츠(이하 "부가서비스 상품")를 제공합니다.

제2조 (구매 조건)
부가서비스 상품은 별도의 구매 절차를 통해 이용 가능합니다. 결제, 환불, 교환, 취소 등은 「전자상거래법」 등 관련 법령에 따라 처리됩니다. 구매자는 본인의 결제 수단을 사용하여야 하며, 타인의 동의 없는 무단 사용은 금지됩니다

 제3조 (권리 및 책임)
사용자가 부가서비스 상품을 구매하지 않더라도 기본 서비스 이용에는 제한이 없습니다. 회사는 부가서비스 상품의 품질·제공과 관련하여 관련 법령이 정하는 범위 내에서 책임을 집니다. 사용자가 구매한 상품의 소유권·이용권은 회사가 별도로 정하는 조건에 따릅니다.
''';
    }

    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => _toggleIndividualTerm(termType),
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isAgreed
                            ? const Color(0xFF65A0FF)
                            : const Color(0xFF7F8694),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(4),
                      color: isAgreed
                          ? const Color(0xFF65A0FF)
                          : Colors.transparent,
                    ),
                    child: isAgreed
                        ? const Icon(Icons.check, size: 14, color: Colors.white)
                        : null,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: prefix,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            height: 1.40,
                            letterSpacing: -0.35,
                          ),
                        ),
                        TextSpan(
                          text: suffix,
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
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              _showErrorDialog2(text);
            },
            child: Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFF7F8694),
              size: 16,
            ),
          ),
        ],
      ),
    );
  }
}
