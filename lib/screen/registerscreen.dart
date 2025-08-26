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
      _allTermsAgreed =
          _serviceTermsAgreed &&
          _privacyTermsAgreed &&
          _photoGalleryAgreed &&
          _sensitiveInfoAgreed &&
          _outsourcingTermsAgreed &&
          _pushNotificationAgreed &&
          _additionalServiceAgreed;
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
                                SizedBox(height: 8),
                                _buildTermItem(
                                  'outsourcing',
                                  '(필수) 개인정보 처리 위탁 및 제3자 제공 동의',
                                ),
                                SizedBox(height: 8),
                                _buildTermItem(
                                  'pushNotification',
                                  '(필수) 푸시 알림 수신 동의',
                                ),
                                SizedBox(height: 8),
                                _buildTermItem(
                                  'additionalService',
                                  '(필수) 부가 서비스 이용 동의',
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

  // 개별 약관 동의 항목 위젯
  Widget _buildTermItem(String termType, String title) {
    bool isAgreed = false;
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
          Icon(
            Icons.arrow_forward_ios,
            color: const Color(0xFF7F8694),
            size: 16,
          ),
        ],
      ),
    );
  }
}
