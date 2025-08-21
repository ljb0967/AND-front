import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'loginScreen2.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: 412,
          height: 917,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: const Color(0xFF111111)),
          child: Stack(
            children: [
              Positioned(
                left: 33.64,
                top: 43.45,
                child: Image.asset('image/home_image.png', height: 20),
                // child: Container(
                //   width: 4.55,
                //   height: 4.55,
                //   decoration: ShapeDecoration(
                //     color: const Color(0xFF65A0FF),
                //     shape: OvalBorder(),
                //   ),
                // ),
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
              Positioned(
                left: 0,
                top: 200,
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
              Positioned(
                left: 206,
                top: 200,
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
              Positioned(
                left: 0,
                top: 254,
                child: Container(
                  width: 412,
                  height: 2,
                  decoration: BoxDecoration(color: const Color(0xFF232529)),
                ),
              ),
              Positioned(
                left: 16,
                top: 702,
                child: Container(
                  width: 126,
                  height: 2,
                  decoration: BoxDecoration(color: const Color(0xFF232529)),
                ),
              ),
              Positioned(
                left: 270,
                top: 702,
                child: Container(
                  width: 126,
                  height: 2,
                  decoration: BoxDecoration(color: const Color(0xFF232529)),
                ),
              ),
              Positioned(
                left: 0,
                top: 254,
                child: Container(
                  width: 206,
                  height: 2,
                  decoration: BoxDecoration(color: Colors.white),
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
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 8,
                    children: [
                      Text(
                        '이메일 주소 입력',
                        style: TextStyle(
                          color: const Color(0xFF8A9099),
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
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    spacing: 8,
                    children: [
                      Text(
                        '비밀번호 입력',
                        style: TextStyle(
                          color: const Color(0xFF8A9099),
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
              Positioned(
                left: 16,
                top: 485,
                child: Container(
                  width: 370, //380
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
                          //화면 전환, 뒤로가기 버튼으로 돌아롤 수 있음.
                          // 뒤로가기 없이 화면 전환하려면 -> Get.off(() => Testscreen() )
                          // 이전 화면 모두 제거하고 새 화면으로 -> Get.offAll(() => Testscreen() )},
                        },
                      ),
                    ],
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
              // Positioned(
              //     left: 0,
              //     top: 0,
              //     child: Container(
              //         width: 412,
              //         height: 44,
              //         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              //         clipBehavior: Clip.antiAlias,
              //         decoration: BoxDecoration(),
              //         child: Column(
              //             mainAxisSize: MainAxisSize.min,
              //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //             crossAxisAlignment: CrossAxisAlignment.center,
              //             spacing: 10,
              //             children: [
              //                 Container(
              //                     width: double.infinity,
              //                     child: Row(
              //                         mainAxisSize: MainAxisSize.min,
              //                         mainAxisAlignment: MainAxisAlignment.end,
              //                         crossAxisAlignment: CrossAxisAlignment.center,
              //                         spacing: 6,
              //                         children: [
              //                             Text(
              //                                 '9:41',
              //                                 style: TextStyle(
              //                                     color: Colors.white.withValues(alpha: 0.80),
              //                                     fontSize: 15,
              //                                     fontFamily: 'One UI Sans APP VF',
              //                                     fontWeight: FontWeight.w700,
              //                                     height: 0.80,
              //                                     letterSpacing: 0.15,
              //                                 ),
              //                             ),
              //                             Expanded(
              //                                 child: Container(
              //                                     height: double.infinity,
              //                                     clipBehavior: Clip.antiAlias,
              //                                     decoration: BoxDecoration(),
              //                                 ),
              //                             ),
              //                             Row(
              //                                 alignment: WrapAlignment.start,
              //                                 runAlignment: WrapAlignment.center,
              //                                 spacing: 4,
              //                                 runSpacing: 4,
              //                                 children: [
              //                                     Container(
              //                                         width: 18,
              //                                         height: 18,
              //                                         clipBehavior: Clip.antiAlias,
              //                                         decoration: BoxDecoration(),
              //                                         child: Stack(),
              //                                     ),
              //                                     Container(
              //                                         width: 18,
              //                                         height: 18,
              //                                         clipBehavior: Clip.antiAlias,
              //                                         decoration: BoxDecoration(),
              //                                         child: Stack(),
              //                                     ),
              //                                     Row(
              //                                         mainAxisSize: MainAxisSize.min,
              //                                         mainAxisAlignment: MainAxisAlignment.start,
              //                                         crossAxisAlignment: CrossAxisAlignment.center,
              //                                         children: [
              //                                         ,
              //                                         ],
              //                                     ),
              //                                 ],
              //                             ),
              //                         ],
              //                     ),
              //                 ),
              //             ],
              //         ),
              //     ),
              // ),
              // Positioned(
              //   left: 0,
              //   top: 893,
              //   child: Container(
              //     width: 412,
              //     padding: const EdgeInsets.symmetric(
              //       horizontal: 134,
              //       vertical: 10,
              //     ),
              //     child: Column(
              //       mainAxisSize: MainAxisSize.min,
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       spacing: 10,
              //       children: [
              //         Container(
              //           width: 144,
              //           height: 4,
              //           decoration: ShapeDecoration(
              //             color: Colors.white.withValues(alpha: 0.60),
              //             shape: RoundedRectangleBorder(
              //               borderRadius: BorderRadius.circular(2),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            ],
          ),
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
