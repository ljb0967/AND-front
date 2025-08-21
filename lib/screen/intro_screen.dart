import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'loginscreen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with SingleTickerProviderStateMixin {
  late Timer _caretTimer;

  String _firstLetter = 'E';
  bool _caretVisible = false;
  Color _textColor = const Color(0xFF3A3A3A); // 회색 시작

  double _textOpacity = 1.0;
  double _logoOpacity = 0.0;

  @override
  void initState() {
    super.initState();

    // 커서 깜박임
    _caretTimer = Timer.periodic(const Duration(milliseconds: 600), (t) {
      if (!mounted) return;
      setState(() => _caretVisible = !_caretVisible);
    });

    // 타임라인 애니메이션 시퀀스
    _runSequence();
  }

  Future<void> _runSequence() async {
    // 1) END 표시 잠시 정지 (커서가 E와 N 사이에 깜박임)
    await Future.delayed(const Duration(milliseconds: 1800));

    // 2) E 지우기 (잠깐 공백)
    if (!mounted) return;
    setState(() {
      _firstLetter = '';
      _caretVisible = false; // 커서 숨기기
    });
    await Future.delayed(const Duration(milliseconds: 800));

    // 3) A 입력 + 파란색 전환
    if (!mounted) return;
    setState(() {
      _firstLetter = 'A';
      _textColor = const Color(0xFF65A0FF);
      // 커서는 계속 숨김 상태 유지
    });
    await Future.delayed(const Duration(milliseconds: 1200));

    // 4) 텍스트 페이드아웃, 로고 페이드인
    if (!mounted) return;
    setState(() {
      _textOpacity = 0.0;
      _logoOpacity = 1.0;
    });
    await Future.delayed(const Duration(milliseconds: 1800));

    // 5) 로그인 화면으로 전환
    if (!mounted) return;
    Get.off(() => const Loginscreen(), transition: Transition.fade);
  }

  @override
  void dispose() {
    _caretTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111111),
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
                    alignment: Alignment.center,
                    children: [
                      // 중앙 텍스트 "END" -> "AND" 애니메이션
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 1200),
                        opacity: _textOpacity,
                        child: _buildAnimatedText(),
                      ),

                      // 로고 페이드 인
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 1200),
                        opacity: _logoOpacity,
                        child: Center(
                          child: SizedBox(
                            width: 320,
                            height: 320,
                            child: Image.asset('image/home_image.png'),
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

  Widget _buildAnimatedText() {
    // 커서 스타일 - E와 N 사이에 위치
    final Widget caret = AnimatedOpacity(
      duration: const Duration(milliseconds: 600),
      opacity: _caretVisible ? 1.0 : 0.0,
      child: Container(
        width: 2,
        height: 28,
        color: _textColor.withOpacity(0.85),
      ),
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '${_firstLetter}',
          style: TextStyle(
            color: _textColor,
            fontSize: 28,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.4,
            fontFamily: 'Pretendard',
          ),
        ),
        // 커서가 E와 N 사이에 위치
        caret,
        Text(
          'ND',
          style: TextStyle(
            color: _textColor,
            fontSize: 28,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.4,
            fontFamily: 'Pretendard',
          ),
        ),
      ],
    );
  }
}
