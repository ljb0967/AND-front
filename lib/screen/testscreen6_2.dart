import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'testscreen6_3.dart';
import '../state/loss_case_controller.dart';
import '../state/quiz_controller.dart';

class Testscreen6_2 extends StatefulWidget {
  const Testscreen6_2({super.key});

  @override
  State<Testscreen6_2> createState() => _Testscreen6_2State();
}

class _Testscreen6_2State extends State<Testscreen6_2> {
  String? _selectedOption;

  // LossCaseController 가져오기
  final LossCaseController lossCaseController = Get.find<LossCaseController>();
  final QuizController quiz = Get.find<QuizController>();

  bool get _canProceed {
    final hasValidBreakupSelection = _selectedOption != null;
    return hasValidBreakupSelection;
  }

  @override
  void initState() {
    super.initState();
    // ✅ 이미 저장된 선택 복원
    final saved = quiz.answers[3];
    if (saved != null) {
      _selectedOption = _optionToLabel(saved); // A./B./C./D. 로 변환
    }
  }

  String _optionToLabel(AnswerOption o) {
    switch (o) {
      case AnswerOption.A:
        return 'A.';
      case AnswerOption.B:
        return 'B.';
      case AnswerOption.C:
        return 'C.';
      case AnswerOption.D:
        return 'D.';
    }
  }

  AnswerOption _labelToOption(String label) {
    switch (label) {
      case 'A.':
        return AnswerOption.A;
      case 'B.':
        return AnswerOption.B;
      case 'C.':
        return AnswerOption.C;
      case 'D.':
        return AnswerOption.D;
      default:
        return AnswerOption.A; // fallback
    }
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
                    '테스트 시작 화면',
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
                  // 파란색 = 1
                  Expanded(
                    flex: 17,
                    child: Container(
                      height: 4,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF65A0FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  ),
                  // 검은색 = 10
                  Expanded(
                    flex: 10,
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
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),

                    // 메인 타이틀
                    Text(
                      'Q. 03\n친구가 “힘들지 않아?”라고 물을 때 나는…',
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
                      '4개의 선택지 중 나를 가장 잘 나타내는 선택지 하나를 선택하세요',
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

                    // 선택지 옵션들
                    Container(
                      width: double.infinity,
                      //padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF111111),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildOption('A.', '\“괜찮아\”라며 웃어넘긴다'),
                          const SizedBox(height: 12),
                          _buildOption('B.', '\“그냥 생각 안 하려고 해\”라고 답한다'),
                          const SizedBox(height: 12),
                          _buildOption('C.', '바로 감정을 털어놓는다'),
                          const SizedBox(height: 12),
                          _buildOption('D.', '\“왜 이렇게 된 건지 정리 중이야\”라고 답한다'),
                        ],
                      ),
                    ),

                    SizedBox(height: 60),

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
                                Get.to(
                                  () => Testscreen6_3(),
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

  Widget _buildOption(String text1, String text2) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_selectedOption == text1) {
            _selectedOption = null;
            quiz.answers[3] = null;
          } else {
            _selectedOption = text1;
            quiz.select(3, _labelToOption(text1));
          }
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        decoration: BoxDecoration(
          color: _selectedOption == text1
              ? const Color(0xFF2A2D31)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: _selectedOption == text1
                ? const Color(0xFF65A0FF) //선택하면 배경 테두리 바뀌게 하는 부분
                : Colors.transparent,
            // color: Colors.transparent,
            width: 2,
          ),
        ),
        child: Container(
          height: 68,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: ShapeDecoration(
            color: const Color(0xFF1F2124),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                text1,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                  height: 1.40,
                  letterSpacing: -0.40,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  text2,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                    height: 1.40,
                    letterSpacing: -0.40,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
