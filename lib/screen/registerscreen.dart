import 'package:flutter/material.dart';
import 'package:test1/screen/loginscreen.dart';
import 'package:get/get.dart';

class Registerscreen extends StatefulWidget {
  const Registerscreen({super.key});

  @override
  State<Registerscreen> createState() => _RegisterscreenState();
}

class _RegisterscreenState extends State<Registerscreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController pwController = TextEditingController();
  final TextEditingController pwoConfirmController = TextEditingController();

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

    // TODO: 백엔드 API 호출하여 이미 가입된 이메일인지 확인
    // _checkEmailAvailability(email);

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

    // TODO: 백엔드 API 호출하여 이미 사용된 비밀번호인지 확인
    // _checkPasswordAvailability(password);

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
    // TODO: 백엔드 API 구현
    // try {
    //   final response = await apiService.checkEmailAvailability(email);
    //   setState(() {
    //     _isEmailRegistered = response.isRegistered;
    //     if (_isEmailRegistered) {
    //       _isEmailValid = false;
    //       _emailError = '이미 가입된 이메일 주소예요';
    //     }
    //   });
    // } catch (e) {
    //   print('이메일 가용성 확인 오류: $e');
    // }
  }

  // 비밀번호 가용성 확인 (백엔드 API 호출)
  Future<void> _checkPasswordAvailability(String password) async {
    // TODO: 백엔드 API 구현
    // try {
    //   final response = await apiService.checkPasswordAvailability(password);
    //   setState(() {
    //     _isPasswordRegistered = response.isRegistered;
    //     if (_isPasswordRegistered) {
    //       _isPasswordValid = false;
    //       _passwordError = '이미 사용된 비밀번호예요';
    //     }
    //   });
    // } catch (e) {
    //   print('비밀번호 가용성 확인 오류: $e');
    // }
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
  void _handleSignup() {
    if (!_isFormComplete) {
      // 모든 필수 항목이 완료되지 않은 경우 처리
      return;
    }

    // TODO: 백엔드 API 호출하여 회원가입 처리
    // _performSignup();

    // 성공 시 로그인 화면으로 이동
    Get.to(() => const Loginscreen(), transition: Transition.fade);
  }

  // 회원가입 API 호출 (백엔드 구현 필요)
  Future<void> _performSignup() async {
    // TODO: 백엔드 API 구현
    // try {
    //   final response = await apiService.signup({
    //     'email': emailController.text.trim(),
    //     'password': pwController.text,
    //     'termsAgreed': {
    //       'service': _serviceTermsAgreed,
    //       'privacy': _privacyTermsAgreed,
    //       'photoGallery': _photoGalleryAgreed,
    //       'sensitiveInfo': _sensitiveInfoAgreed,
    //       'outsourcing': _outsourcingTermsAgreed,
    //       'pushNotification': _pushNotificationAgreed,
    //       'additionalService': _additionalServiceAgreed,
    //     },
    //   });
    //
    //   if (response.success) {
    //     Get.to(() => const Loginscreen(), transition: Transition.fade);
    //   }
    // } catch (e) {
    //   print('회원가입 오류: $e');
    // }
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
                        top: 80,
                        child: Text(
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
                      ),
                      Positioned(
                        left: 32,
                        top: 112,
                        child: Text(
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
                        left: 32,
                        top: 421,
                        child: Text(
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
                      ),

                      Positioned(
                        left: 16,
                        top: 743,
                        child: Container(
                          width: 370,
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
                      ),

                      Positioned(
                        left: 6,
                        top: 463,
                        child: Container(
                          width: 380,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 24,
                            children: [
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
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 8,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        spacing: 12,
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
                                                borderRadius:
                                                    BorderRadius.circular(4),
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
                                  ],
                                ),
                              ),
                              Container(
                                width: 348,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  spacing: 8,
                                  children: [
                                    Container(
                                      width: 348,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        spacing: 3,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            spacing: 12,
                                            children: [
                                              GestureDetector(
                                                onTap: () =>
                                                    _toggleIndividualTerm(
                                                      'service',
                                                    ),
                                                child: Container(
                                                  width: 18,
                                                  height: 18,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: _serviceTermsAgreed
                                                          ? const Color(
                                                              0xFF65A0FF,
                                                            )
                                                          : const Color(
                                                              0xFF7F8694,
                                                            ),
                                                      width: 2,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          4,
                                                        ),
                                                    color: _serviceTermsAgreed
                                                        ? const Color(
                                                            0xFF65A0FF,
                                                          )
                                                        : Colors.transparent,
                                                  ),
                                                  child: _serviceTermsAgreed
                                                      ? const Icon(
                                                          Icons.check,
                                                          size: 14,
                                                          color: Colors.white,
                                                        )
                                                      : null,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 290,
                                                child: Text.rich(
                                                  TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: '(필수)',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontFamily:
                                                              'Pretendard',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          height: 1.40,
                                                          letterSpacing: -0.35,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: ' 서비스 이용약관 동의',
                                                        style: TextStyle(
                                                          color: const Color(
                                                            0xFFBDC7DB,
                                                          ),
                                                          fontSize: 14,
                                                          fontFamily:
                                                              'Pretendard',
                                                          fontWeight:
                                                              FontWeight.w500,
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
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            color: const Color(0xFF7F8694),
                                            size: 16,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 348,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        spacing: 3,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            spacing: 12,
                                            children: [
                                              GestureDetector(
                                                onTap: () =>
                                                    _toggleIndividualTerm(
                                                      'privacy',
                                                    ),
                                                child: Container(
                                                  width: 18,
                                                  height: 18,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: _privacyTermsAgreed
                                                          ? const Color(
                                                              0xFF65A0FF,
                                                            )
                                                          : const Color(
                                                              0xFF7F8694,
                                                            ),
                                                      width: 2,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          4,
                                                        ),
                                                    color: _privacyTermsAgreed
                                                        ? const Color(
                                                            0xFF65A0FF,
                                                          )
                                                        : Colors.transparent,
                                                  ),
                                                  child: _privacyTermsAgreed
                                                      ? const Icon(
                                                          Icons.check,
                                                          size: 14,
                                                          color: Colors.white,
                                                        )
                                                      : null,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 290,
                                                child: Text.rich(
                                                  TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: '(필수)',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontFamily:
                                                              'Pretendard',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          height: 1.40,
                                                          letterSpacing: -0.35,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            ' 개인정보 수집 및 이용 동의',
                                                        style: TextStyle(
                                                          color: const Color(
                                                            0xFFBDC7DB,
                                                          ),
                                                          fontSize: 14,
                                                          fontFamily:
                                                              'Pretendard',
                                                          fontWeight:
                                                              FontWeight.w500,
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
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            color: const Color(0xFF7F8694),
                                            size: 16,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 348,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        spacing: 3,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            spacing: 12,
                                            children: [
                                              GestureDetector(
                                                onTap: () =>
                                                    _toggleIndividualTerm(
                                                      'photoGallery',
                                                    ),
                                                child: Container(
                                                  width: 18,
                                                  height: 18,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: _photoGalleryAgreed
                                                          ? const Color(
                                                              0xFF65A0FF,
                                                            )
                                                          : const Color(
                                                              0xFF7F8694,
                                                            ),
                                                      width: 2,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          4,
                                                        ),
                                                    color: _photoGalleryAgreed
                                                        ? const Color(
                                                            0xFF65A0FF,
                                                          )
                                                        : Colors.transparent,
                                                  ),
                                                  child: _photoGalleryAgreed
                                                      ? const Icon(
                                                          Icons.check,
                                                          size: 14,
                                                          color: Colors.white,
                                                        )
                                                      : null,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 290,
                                                child: Text.rich(
                                                  TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: '(필수)',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontFamily:
                                                              'Pretendard',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          height: 1.40,
                                                          letterSpacing: -0.35,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            ' 사진/갤러리 접근 권한 동의',
                                                        style: TextStyle(
                                                          color: const Color(
                                                            0xFFBDC7DB,
                                                          ),
                                                          fontSize: 14,
                                                          fontFamily:
                                                              'Pretendard',
                                                          fontWeight:
                                                              FontWeight.w500,
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
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            color: const Color(0xFF7F8694),
                                            size: 16,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 348,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        spacing: 3,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            spacing: 12,
                                            children: [
                                              GestureDetector(
                                                onTap: () =>
                                                    _toggleIndividualTerm(
                                                      'sensitiveInfo',
                                                    ),
                                                child: Container(
                                                  width: 18,
                                                  height: 18,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color:
                                                          _sensitiveInfoAgreed
                                                          ? const Color(
                                                              0xFF65A0FF,
                                                            )
                                                          : const Color(
                                                              0xFF7F8694,
                                                            ),
                                                      width: 2,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          4,
                                                        ),
                                                    color: _sensitiveInfoAgreed
                                                        ? const Color(
                                                            0xFF65A0FF,
                                                          )
                                                        : Colors.transparent,
                                                  ),
                                                  child: _sensitiveInfoAgreed
                                                      ? const Icon(
                                                          Icons.check,
                                                          size: 14,
                                                          color: Colors.white,
                                                        )
                                                      : null,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 290,
                                                child: Text.rich(
                                                  TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: '(필수)',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontFamily:
                                                              'Pretendard',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          height: 1.40,
                                                          letterSpacing: -0.35,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: ' 민감정보 처리 동의',
                                                        style: TextStyle(
                                                          color: const Color(
                                                            0xFFBDC7DB,
                                                          ),
                                                          fontSize: 14,
                                                          fontFamily:
                                                              'Pretendard',
                                                          fontWeight:
                                                              FontWeight.w500,
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
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            color: const Color(0xFF7F8694),
                                            size: 16,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 348,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        spacing: 3,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            spacing: 12,
                                            children: [
                                              GestureDetector(
                                                onTap: () =>
                                                    _toggleIndividualTerm(
                                                      'outsourcing',
                                                    ),
                                                child: Container(
                                                  width: 18,
                                                  height: 18,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color:
                                                          _outsourcingTermsAgreed
                                                          ? const Color(
                                                              0xFF65A0FF,
                                                            )
                                                          : const Color(
                                                              0xFF7F8694,
                                                            ),
                                                      width: 2,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          4,
                                                        ),
                                                    color:
                                                        _outsourcingTermsAgreed
                                                        ? const Color(
                                                            0xFF65A0FF,
                                                          )
                                                        : Colors.transparent,
                                                  ),
                                                  child: _outsourcingTermsAgreed
                                                      ? const Icon(
                                                          Icons.check,
                                                          size: 14,
                                                          color: Colors.white,
                                                        )
                                                      : null,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 290,
                                                child: Text.rich(
                                                  TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: '(필수)',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontFamily:
                                                              'Pretendard',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          height: 1.40,
                                                          letterSpacing: -0.35,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            ' 개인정보 처리 위탁 및 제3자 제공 동의',
                                                        style: TextStyle(
                                                          color: const Color(
                                                            0xFFBDC7DB,
                                                          ),
                                                          fontSize: 14,
                                                          fontFamily:
                                                              'Pretendard',
                                                          fontWeight:
                                                              FontWeight.w500,
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
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            color: const Color(0xFF7F8694),
                                            size: 16,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 348,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        spacing: 3,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            spacing: 12,
                                            children: [
                                              GestureDetector(
                                                onTap: () =>
                                                    _toggleIndividualTerm(
                                                      'pushNotification',
                                                    ),
                                                child: Container(
                                                  width: 18,
                                                  height: 18,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color:
                                                          _pushNotificationAgreed
                                                          ? const Color(
                                                              0xFF65A0FF,
                                                            )
                                                          : const Color(
                                                              0xFF7F8694,
                                                            ),
                                                      width: 2,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          4,
                                                        ),
                                                    color:
                                                        _pushNotificationAgreed
                                                        ? const Color(
                                                            0xFF65A0FF,
                                                          )
                                                        : Colors.transparent,
                                                  ),
                                                  child: _pushNotificationAgreed
                                                      ? const Icon(
                                                          Icons.check,
                                                          size: 14,
                                                          color: Colors.white,
                                                        )
                                                      : null,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 290,
                                                child: Text.rich(
                                                  TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: '(필수)',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontFamily:
                                                              'Pretendard',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          height: 1.40,
                                                          letterSpacing: -0.35,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: ' 푸시 알림 수신 동의',
                                                        style: TextStyle(
                                                          color: const Color(
                                                            0xFFBDC7DB,
                                                          ),
                                                          fontSize: 14,
                                                          fontFamily:
                                                              'Pretendard',
                                                          fontWeight:
                                                              FontWeight.w500,
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
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            color: const Color(0xFF7F8694),
                                            size: 16,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 348,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        spacing: 3,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            spacing: 12,
                                            children: [
                                              GestureDetector(
                                                onTap: () =>
                                                    _toggleIndividualTerm(
                                                      'additionalService',
                                                    ),
                                                child: Container(
                                                  width: 18,
                                                  height: 18,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color:
                                                          _additionalServiceAgreed
                                                          ? const Color(
                                                              0xFF65A0FF,
                                                            )
                                                          : const Color(
                                                              0xFF7F8694,
                                                            ),
                                                      width: 2,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          4,
                                                        ),
                                                    color:
                                                        _additionalServiceAgreed
                                                        ? const Color(
                                                            0xFF65A0FF,
                                                          )
                                                        : Colors.transparent,
                                                  ),
                                                  child:
                                                      _additionalServiceAgreed
                                                      ? const Icon(
                                                          Icons.check,
                                                          size: 14,
                                                          color: Colors.white,
                                                        )
                                                      : null,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 290,
                                                child: Text.rich(
                                                  TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text: '(필수)',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14,
                                                          fontFamily:
                                                              'Pretendard',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          height: 1.40,
                                                          letterSpacing: -0.35,
                                                        ),
                                                      ),
                                                      TextSpan(
                                                        text: ' 부가 서비스 이용 동의',
                                                        style: TextStyle(
                                                          color: const Color(
                                                            0xFFBDC7DB,
                                                          ),
                                                          fontSize: 14,
                                                          fontFamily:
                                                              'Pretendard',
                                                          fontWeight:
                                                              FontWeight.w500,
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
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            color: const Color(0xFF7F8694),
                                            size: 16,
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
                        top: 164,
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
                              side: BorderSide(
                                color: _emailError.isNotEmpty
                                    ? Colors.red
                                    : _isEmailValid
                                    ? Colors.transparent
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
                      ),
                      if (_emailError.isNotEmpty)
                        Positioned(
                          left: 16,
                          top: 220,
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
                      Positioned(
                        left: 16,
                        top: 251,
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
                              side: BorderSide(
                                color: _passwordError.isNotEmpty
                                    ? Colors.red
                                    : _isPasswordValid
                                    ? Colors.transparent
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
                                  onChanged: (value) =>
                                      _validatePasswordInput(),
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
                      ),
                      if (_passwordError.isNotEmpty)
                        Positioned(
                          left: 16,
                          top: 307,
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
                      Positioned(
                        left: 16,
                        top: 338,
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
                              side: BorderSide(
                                color: _passwordConfirmError.isNotEmpty
                                    ? Colors.red
                                    : _isPasswordConfirmValid
                                    ? Colors.transparent
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
                      ),
                      if (_passwordConfirmError.isNotEmpty)
                        Positioned(
                          left: 16,
                          top: 394,
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
}
