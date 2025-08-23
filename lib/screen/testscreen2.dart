import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test1/screen/testscreen.dart';
import 'testscreen3.dart';
import '../state/survey_controller.dart';

class Testscreen2 extends StatefulWidget {
  final String? selectedCategory;
  const Testscreen2({Key? key, required this.selectedCategory})
    : super(key: key);

  @override
  State<Testscreen2> createState() => _Testscreen2State();
}

class _Testscreen2State extends State<Testscreen2> {
  // String? _selected; // '가족', '연인', '반려동물', '친구'
  String? _selectedReason;

  bool get _canProceed {
    final hasValidBreakupSelection = _selectedReason != null;
    return hasValidBreakupSelection;
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
                        top: 132,
                        child: Text(
                          '이별한 사람과\n어떻게 이별하게 되었나요?',
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
                        top: 196,
                        child: Text(
                          'AND와의 여정을 위해 소중한 당신의 이야기를 들려주세요',
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
                        left: 16,
                        top: 96,
                        child: Container(
                          width: 380,
                          height: 4,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF232529),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        top: 96,
                        child: Container(
                          width: 162.86,
                          height: 4,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF65A0FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
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
                                  Get.back();
                                },
                              ),
                            ),
                            Text(
                              '이별 상대 선택',
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
                        left: 20,
                        top: 723,
                        child: Container(
                          width: 370,
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
                                      () => const Testscreen3(),
                                      transition: Transition.fade,
                                    );
                                  }
                                // : null,
                                : () {
                                    Get.to(
                                      () => const Testscreen3(), // 디버깅을 위한 임시
                                      transition: Transition.fade,
                                    );
                                  },
                          ),
                        ),
                      ),
                      if (widget.selectedCategory == '가족') ...[
                        Positioned(
                          left: 16,
                          top: 270,
                          child: Container(
                            width: 380,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF111111),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          _buildReasonOption('사망 (자연사)'),
                                          const SizedBox(height: 10),
                                          _buildReasonOption(
                                            '사망 (사고사, 급작스러운 상실)',
                                          ),
                                          const SizedBox(height: 10),
                                          _buildReasonOption('관계 단절'),
                                          const SizedBox(height: 10),
                                          _buildReasonOption('이혼 / 가족 구조 해체'),
                                          const SizedBox(height: 10),
                                          _buildReasonOption(
                                            '장기적 거리감 (연락두절, 이민, 실종 등)',
                                          ),
                                          const SizedBox(height: 10),
                                          _buildReasonOption(
                                            '정확히 모르겠어요 / 복합적이에요',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ] else if (widget.selectedCategory == '연인') ...[
                        Positioned(
                          left: 16,
                          top: 270,
                          child: Container(
                            width: 380,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF111111),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          _buildReasonOption('상대의 마음이 식었어요'),
                                          const SizedBox(height: 10),
                                          _buildReasonOption('내가 마음이 떠났어요'),
                                          const SizedBox(height: 10),
                                          _buildReasonOption('성격, 가치관 차이'),
                                          const SizedBox(height: 10),
                                          _buildReasonOption('바람이나 배신'),
                                          const SizedBox(height: 10),
                                          _buildReasonOption('상황/환경 문제'),
                                          const SizedBox(height: 10),
                                          _buildReasonOption(
                                            '정확히 모르겠어요 / 복합적이에요',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ] else if (widget.selectedCategory == '친구') ...[
                        Positioned(
                          left: 16,
                          top: 270,
                          child: Container(
                            width: 380,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF111111),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          _buildReasonOption('큰 싸움으로 인한 연락 두절'),
                                          const SizedBox(height: 10),
                                          _buildReasonOption('갑작스러운 차단 / 멀어짐'),
                                          const SizedBox(height: 10),
                                          _buildReasonOption('자연스러운 멀어짐'),
                                          const SizedBox(height: 10),
                                          _buildReasonOption('친구에게 상처를 받음'),
                                          const SizedBox(height: 10),
                                          _buildReasonOption(
                                            '정확히 모르겠어요 / 복합적이에요',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ] else ...[
                        Positioned(
                          left: 16,
                          top: 270,
                          child: Container(
                            width: 380,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF111111),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          _buildReasonOption('자연사(노화)'),
                                          const SizedBox(height: 10),
                                          _buildReasonOption(
                                            '질병/사고로 인한 갑작스러운 죽음',
                                          ),
                                          const SizedBox(height: 10),
                                          _buildReasonOption('안락사 결정'),
                                          const SizedBox(height: 10),
                                          _buildReasonOption('실종'),
                                          const SizedBox(height: 10),
                                          _buildReasonOption(
                                            '정확히 모르겠어요 / 복합적이에요',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],

                      Positioned(
                        left: 32,
                        top: 248,
                        child: Text(
                          '이별 사유 선택',
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

  Widget _buildReasonOption(String text) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_selectedReason == text) {
            _selectedReason = null;
          } else {
            _selectedReason = text;
          }
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
        decoration: BoxDecoration(
          color: _selectedReason == text
              ? const Color(0xFF2A2D31)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            // color: _selectedFamilyMember == text
            //     ? const Color(0xFF65A0FF)                    //선택하면 배경 테두리 바뀌게 하는 부분
            //     : Colors.transparent,
            color: Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: _selectedReason == text
                    ? const Color(0xFF111111)
                    : Colors.transparent,
                border: Border.all(
                  color: _selectedReason == text
                      ? const Color(0xFF65A0FF)
                      : const Color(0xFFBDC7DB),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: _selectedReason == text
                  ? Center(
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF66A1FF),
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
