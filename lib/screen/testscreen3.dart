import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'testscreen4.dart';
import 'testscreen2.dart';

class Testscreen3 extends StatefulWidget {
  const Testscreen3({super.key});

  @override
  State<Testscreen3> createState() => _Testscreen3State();
}

class _Testscreen3State extends State<Testscreen3> {
  // String? _selected; // 기간 선택 값
  String? _selectedTime;

  bool get _canProceed {
    final hasValidBreakupSelection = _selectedTime != null;
    return hasValidBreakupSelection;
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
                    '이별 사유 선택',
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
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Row(
                children: [
                  Container(
                    width: 217.14,
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
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),

                    // 메인 타이틀
                    Text(
                      '이별한 사람과\n얼마나 오래 함께하셨나요?',
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

                    SizedBox(height: 32),

                    // 이별 상대와 함께한 기간 라벨
                    Text(
                      '이별 상대와 함께한 기간',
                      style: TextStyle(
                        color: const Color(0xFFBDC7DB),
                        fontSize: 14,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                        height: 1.40,
                      ),
                    ),

                    SizedBox(height: 16),

                    // 기간 선택 옵션들
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF111111),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTimeOption('1~6개월'),
                          const SizedBox(height: 10),
                          _buildTimeOption('6개월~1년'),
                          const SizedBox(height: 10),
                          _buildTimeOption('1~2년'),
                          const SizedBox(height: 10),
                          _buildTimeOption('2~5년'),
                          const SizedBox(height: 10),
                          _buildTimeOption('5~10년'),
                          const SizedBox(height: 10),
                          _buildTimeOption('10년 이상'),
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
                                Get.to(
                                  () => const Testscreen4(),
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

  Widget _buildTimeOption(String text) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_selectedTime == text) {
            _selectedTime = null;
          } else {
            _selectedTime = text;
          }
        });
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
        decoration: BoxDecoration(
          color: _selectedTime == text
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
                color: _selectedTime == text
                    ? const Color(0xFF111111)
                    : Colors.transparent,
                border: Border.all(
                  color: _selectedTime == text
                      ? const Color(0xFF65A0FF)
                      : const Color(0xFFBDC7DB),
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: _selectedTime == text
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

// class _RadioLine extends StatelessWidget {
//   final String title;
//   final String? groupValue;
//   final ValueChanged<String?> onChanged;
//   const _RadioLine({
//     required this.title,
//     required this.groupValue,
//     required this.onChanged,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Radio<String>(
//           value: title,
//           groupValue: groupValue,
//           onChanged: onChanged,
//           visualDensity: VisualDensity.compact,
//           fillColor: MaterialStateProperty.all(const Color(0xFFDCE6FA)),
//         ),
//         const SizedBox(width: 8),
//         Text(
//           title,
//           style: const TextStyle(
//             color: Color(0xFF2E5AAC),
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ],
//     );
//   }
// }
