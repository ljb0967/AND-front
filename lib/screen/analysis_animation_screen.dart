import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'homecontentscreen.dart';

class AnalysisAnimationScreen extends StatefulWidget {
  const AnalysisAnimationScreen({super.key});

  @override
  State<AnalysisAnimationScreen> createState() =>
      _AnalysisAnimationScreenState();
}

class _AnalysisAnimationScreenState extends State<AnalysisAnimationScreen>
    with TickerProviderStateMixin {
  late AnimationController _progressController;
  late AnimationController _textController;
  late Animation<double> _progressAnimation;
  late Animation<double> _textOpacityAnimation;

  double _progressValue = 0.0;
  bool _showText1 = false;
  bool _showText2 = false;
  bool _showText3 = false;
  bool _showDivider = false;

  @override
  void initState() {
    super.initState();

    // 프로그레스바 애니메이션 컨트롤러
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );

    // 텍스트 애니메이션 컨트롤러
    _textController = AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    );

    // 프로그레스바 애니메이션 (0.0에서 1.0까지)
    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeInOut),
    );

    // 텍스트 페이드인 애니메이션
    _textOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeInOut),
    );

    // 애니메이션 시작
    _startAnimation();
  }

  void _startAnimation() async {
    // 프로그레스바 애니메이션 시작
    _progressController.forward();

    // 프로그레스바 값 업데이트
    _progressController.addListener(() {
      if (!mounted) return;
      setState(() {
        _progressValue = _progressAnimation.value;
      });
    });

    // 텍스트 순차적으로 나타나기
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    setState(() => _showText1 = true);

    await Future.delayed(const Duration(milliseconds: 800));
    if (!mounted) return;
    setState(() => _showText2 = true);

    await Future.delayed(const Duration(milliseconds: 1000));
    if (!mounted) return;
    setState(() => _showText3 = true);

    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    setState(() => _showDivider = true);

    // 애니메이션 완료 후 홈 화면으로 이동
    await Future.delayed(const Duration(milliseconds: 2000));
    if (!mounted) return;
    if (mounted) {
      Get.offAll(() => const Homecontentscreen());
    }
  }

  // void _startAnimation() async {
  //   // 진행바 값 반영
  //   _progressController.addListener(() {
  //     if (!mounted) return;
  //     setState(() => _progressValue = _progressAnimation.value);
  //   });

  //   // 1) 진행바 실행(완료까지 대기하는 Future)
  //   final progressDone = _progressController.forward(); // <- 완료 Future

  //   // 2) 텍스트 시퀀스(완료까지 대기하는 Future)
  //   final textsDone = () async {
  //     await Future.delayed(const Duration(milliseconds: 500));
  //     if (!mounted) return;
  //     setState(() => _showText1 = true);

  //     await Future.delayed(const Duration(milliseconds: 800));
  //     if (!mounted) return;
  //     setState(() => _showText2 = true);

  //     await Future.delayed(const Duration(milliseconds: 1000));
  //     if (!mounted) return;
  //     setState(() => _showText3 = true);

  //     await Future.delayed(const Duration(milliseconds: 1200));
  //     if (!mounted) return;
  //     setState(() => _showDivider = true);
  //   }();

  //   // 3) 두 작업이 모두 끝날 때까지 기다림
  //   await Future.wait([progressDone, textsDone]);

  //   // 4) 잠깐 멈췄다가 라우팅 (옵션)
  //   await Future.delayed(const Duration(milliseconds: 800));

  //   if (!mounted) return;
  //   Get.offAll(() => const Homecontentscreen());
  // }

  @override
  void dispose() {
    _progressController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: SafeArea(
        child: Column(
          children: [
            // 상단 상태바 영역 (시스템 상태바를 위한 공간)
            Container(height: 24, color: Colors.transparent),

            // 메인 콘텐츠 영역
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // "END" 텍스트
                      Text(
                        'AND',
                        style: TextStyle(
                          color: const Color(0xFF65A0FF),
                          fontSize: 48,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.5,
                        ),
                      ),

                      const SizedBox(height: 40),

                      // 프로그레스바
                      Container(
                        width: double.infinity,
                        height: 4,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2A2A2A),
                          borderRadius: BorderRadius.circular(2),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: _progressValue,
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFF65A0FF),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      // 첫 번째 텍스트
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 600),
                        opacity: _showText1 ? 1.0 : 0.0,
                        child: Text(
                          '지금까지 알려주신 정보를',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            height: 1.4,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // 두 번째 텍스트 (AND 강조)
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 600),
                        opacity: _showText2 ? 1.0 : 0.0,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'AND',
                                style: TextStyle(
                                  color: const Color(0xFF65A0FF),
                                  fontSize: 18,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w600,
                                  height: 1.4,
                                ),
                              ),
                              TextSpan(
                                text: '가 분석하고 있어요',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w500,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // 세 번째 텍스트 (안내)
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 600),
                        opacity: _showText3 ? 1.0 : 0.0,
                        child: Text(
                          '해당 정보는 설정 화면에서 수정할 수 있어요',
                          style: TextStyle(
                            color: const Color(0xFF9E9E9E),
                            fontSize: 14,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w400,
                            height: 1.4,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      const SizedBox(height: 24),
                      // 구분선
                    ],
                  ),
                ),
              ),
            ),

            // 하단 내비게이션 바 영역
            Container(height: 24, color: Colors.transparent),
          ],
        ),
      ),
    );
  }
}
