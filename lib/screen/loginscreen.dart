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

  @override
  Widget build(BuildContext context) {
    final TextEditingController idController = TextEditingController();
    final TextEditingController pwController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double screenWidth = constraints.maxWidth;
            const double designWidth = 412.0;
            const double designHeight = 917.0;
            final double devicePixelRatio = MediaQuery.of(
              context,
            ).devicePixelRatio;
            final double epsilon = 1.0 / devicePixelRatio; // 1 physical pixel
            final double safeWidth = (screenWidth - epsilon).clamp(
              0.0,
              double.infinity,
            );
            final double scale = safeWidth / designWidth;
            final double scaledHeight = designHeight * scale;

            final Widget scaledContent = Transform.scale(
              scale: scale,
              alignment: Alignment.topLeft,
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
                        left: 33.64,
                        top: 43.45,
                        child: Image.asset('image/home_image.png', height: 20),
                      ),
                      Positioned(
                        left: 32,
                        top: 100,
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
                      Positioned(
                        left: 32,
                        top: 164,
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

                      // 회원 탭 (클릭 가능)
                      Positioned(
                        left: 0,
                        top: 200,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isMember = true;
                            });
                          },
                          child: Container(
                            width: 206,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              spacing: 8,
                              children: [
                                Text(
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
                              ],
                            ),
                          ),
                        ),
                      ),

                      // 비회원 탭 (클릭 가능)
                      Positioned(
                        left: 206,
                        top: 200,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isMember = false;
                            });
                          },
                          child: Container(
                            width: 206,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              spacing: 8,
                              children: [
                                Text(
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
                              ],
                            ),
                          ),
                        ),
                      ),

                      // 하단 흰색 바 (회원 탭 선택 시)
                      Positioned(
                        left: 0,
                        top: 254,
                        child: Container(
                          width: 206,
                          height: 2,
                          decoration: BoxDecoration(
                            color: _isMember
                                ? Colors.white
                                : const Color(0xFF232529),
                          ),
                        ),
                      ),

                      // 하단 흰색 바 (비회원 탭 선택 시)
                      Positioned(
                        left: 206,
                        top: 254,
                        child: Container(
                          width: 206,
                          height: 2,
                          decoration: BoxDecoration(
                            color: !_isMember
                                ? Colors.white
                                : const Color(0xFF232529),
                          ),
                        ),
                      ),

                      // 회원 로그인 섹션 (회원 탭 선택 시에만 표시)
                      if (_isMember) ...[
                        Positioned(
                          left: 32,
                          top: 288,
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
                        Positioned(
                          left: 16,
                          top: 340,
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
                              controller: idController,
                              keyboardType: TextInputType.emailAddress,
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
                        ),
                        Positioned(
                          left: 16,
                          top: 398,
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
                              obscureText: true,
                              controller: pwController,
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
                        ),

                        // 250822 로그인 텍스트버튼 ElevatedButton 로 변경완료. positioned()는 조정 필요.
                        Positioned(
                          left: 16,
                          top: 485,
                          child: Container(
                            width: 370,
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
                        ),

                        Positioned(
                          left: 86,
                          top: 555,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 12,
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
                              Text(
                                '회원가입',
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

                      // 비회원 로그인 섹션 (비회원 탭 선택 시에만 표시)
                      if (!_isMember) ...[
                        Positioned(
                          left: 32,
                          top: 288,
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
                        Positioned(
                          left: 32,
                          top: 320,
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
                        Positioned(
                          left: 16,
                          top: 485,
                          child: Container(
                            width: 370,
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
                        ),
                        Positioned(
                          left: 164,
                          top: 555,
                          child: TextButton(
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
                      Positioned(
                        left: 158,
                        top: 633,
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
                      Positioned(
                        left: 90,
                        top: 685,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 24,
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
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 10,
                                    top: 10,
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(),
                                      child: Stack(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 10,
                                    top: 10,
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(),
                                      child: Stack(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 10,
                                    top: 10,
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(),
                                      child: Stack(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 12,
                                    top: 10,
                                    child: Container(
                                      width: 16,
                                      height: 20,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(),
                                      child: Stack(),
                                    ),
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
      // backgroundColor: Colors.black,
      // body: SafeArea(
      //   child: Center(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         const SizedBox(height: 32),
      //         Text(
      //           '&',
      //           style: TextStyle(
      //             fontSize: 28,
      //             color: Colors.blue.shade200,
      //             fontWeight: FontWeight.w600,
      //             height: 1.0,
      //           ),
      //         ),
      //         const SizedBox(height: 32),
      //         SizedBox(
      //           width: 240,
      //           height: 44,
      //           child: ElevatedButton(
      //             style: ElevatedButton.styleFrom(
      //               elevation: 0,
      //               backgroundColor: Colors.white,
      //               foregroundColor: const Color(0xFF2E5AAC),
      //               shape: RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.circular(24),
      //               ),
      //             ),
      //             onPressed: () {
      //               Get.to(() => const LoginScreen2());
      //               //화면 전환, 뒤로가기 버튼으로 돌아롤 수 있음.
      //               // 뒤로가기 없이 화면 전환하려면 -> Get.off(() => Testscreen() )
      //               // 이전 화면 모두 제거하고 새 화면으로 -> Get.offAll(() => Testscreen() )
      //             },
      //             child: const Text(
      //               '비회원 로그인',
      //               style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
