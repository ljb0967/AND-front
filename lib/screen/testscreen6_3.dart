import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'testscreen7.dart';
import '../state/loss_case_controller.dart';
import '../state/quiz_controller.dart';

class Testscreen6_3 extends StatefulWidget {
  const Testscreen6_3({super.key});

  @override
  State<Testscreen6_3> createState() => _Testscreen6_3State();
}

class _Testscreen6_3State extends State<Testscreen6_3> {
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
    final saved = quiz.answers[4];
    if (saved != null) {
      _selectedOption = _optionToLabel(saved); // A./B./C./D. 로 변환
    }
  }

  // AnswerOption <-> 'A.' 변환
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
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: Row(
                children: [
                  Container(
                    width: 325.71,
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
                      'Q. 04\n이별 후 밤에 잠이 오지 않을 때 나는…',
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
                          _buildOption(
                            'A.',
                            '억지로 마음을 다잡고 \‘괜찮아질 거야\’ 하며 꾹 참고 버틴다',
                          ),
                          const SizedBox(height: 12),
                          _buildOption('B.', '유튜브, 넷플릭스 등 아무거나 보면서 그냥 잊으려 한다'),
                          const SizedBox(height: 12),
                          _buildOption('C.', '울거나 음악 틀어놓고 감정을 다 쏟아낸다'),
                          const SizedBox(height: 12),
                          _buildOption(
                            'D.',
                            '노트나 메모장에 이별 과정을 하나하나 정리하며 원인\n을 분석한다',
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 110),

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
                                // 선택된 옵션을 LossCaseController에 저장 (필요한 경우)

                                final quiz = Get.find<QuizController>();
                                final result = quiz.decide();

                                if (result.styleName == '억누르기형') {
                                  lossCaseController.setCopeWay('SUPPRESS');
                                } else if (result.styleName == '회피형') {
                                  lossCaseController.setCopeWay('REJECT');
                                } else if (result.styleName == '표출형') {
                                  lossCaseController.setCopeWay('SUPPRESS');
                                } else if (result.styleName == '분석형') {
                                  lossCaseController.setCopeWay('SUPPRESS');
                                }

                                print('Testscreen6 데이터 저장 완료');
                                lossCaseController.printCurrentData();

                                Get.to(
                                  () => Testscreen7(
                                    selectedOption: result.styleName,
                                  ),
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
            quiz.answers[4] = null;
          } else {
            _selectedOption = text1;
            quiz.select(4, _labelToOption(text1));
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
          width: 380,
          height: 68,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          decoration: ShapeDecoration(
            color: const Color(0xFF1F2124),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 8,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 12,
                children: [
                  SizedBox(
                    width: 16,
                    child: Text(
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
                  ),
                  Text(
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
