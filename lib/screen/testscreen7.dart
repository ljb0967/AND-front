import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../state/loss_case_controller.dart';
import 'testscreen8.dart';

class Testscreen7 extends StatefulWidget {
  final String? selectedOption;
  const Testscreen7({super.key, required this.selectedOption});

  @override
  State<Testscreen7> createState() => _Testscreen7State();
}

class _Testscreen7State extends State<Testscreen7> {
  final TextEditingController _controller = TextEditingController();

  // LossCaseController 가져오기
  final LossCaseController lossCaseController = Get.find<LossCaseController>();

  @override
  void dispose() {
    _controller.dispose();
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
                        Get.back();
                      },
                    ),
                  ),
                  Text(
                    '이전 문항',
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
                    flex: 27,
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

            if (widget.selectedOption == '억누르기형') ...[
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),

                      // 메인 타이틀
                      Text(
                        '소중한 당신은\n[억누르기형] 인 것 같아요',
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
                        '이별대처유형 테스트 결과는 맞춤 퀘스트 제공에 사용돼요',
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

                      // 결과 표시 컨테이너
                      Container(
                        width: double.infinity,
                        height: 360,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF1F2124),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // "내가 참아야지..." 텍스트
                            SizedBox(height: 12),
                            Container(
                              width: 163,
                              height: 46,
                              decoration: BoxDecoration(
                                color: const Color(0xFF3D4147),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: Text(
                                  '내가 참아야지...',
                                  textAlign: TextAlign.center,
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
                            ),

                            SizedBox(height: 2),

                            Stack(
                              children: [
                                Container(
                                  width: 360,
                                  height: 300,
                                  child: Image.asset('image/cloud2.png'),
                                ),
                                Positioned(
                                  top: 20,
                                  left: 110,
                                  child: Container(
                                    width: 140,
                                    height: 140,
                                    child: Image.asset('image/character1.png'),
                                  ),
                                ),

                                SizedBox(height: 32),

                                // 결과 설명
                                Positioned(
                                  top: 180,
                                  left: 100,
                                  child: Column(
                                    children: [
                                      Text(
                                        '[억누르기형]',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: const Color(0xFF65A0FF),
                                          fontSize: 20,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w600,
                                          height: 1.40,
                                          letterSpacing: -0.50,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        '이별을 혼자서 감당하려고 해요',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: const Color(0xFF7F8694),
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
                              ],
                            ),
                            // 캐릭터 이미지
                          ],
                        ),
                      ),

                      SizedBox(height: 30),

                      // 다음으로 넘어가기 버튼
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF65A0FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            '다음으로 넘어가기',
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
                            // 데이터 저장 (필요한 경우)
                            // print('Testscreen7 데이터 저장 완료');
                            // lossCaseController.printCurrentData();

                            Get.to(
                              () => const Testscreen8(),
                              transition: Transition.fade,
                            );
                          },
                        ),
                      ),

                      SizedBox(height: 20),

                      // 테스트 다시 응시하기 버튼
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1F2124),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            '테스트 다시 응시하기',
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
                            Get.back();
                            Get.back();
                          },
                        ),
                      ),

                      SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],

            if (widget.selectedOption == '표출형') ...[
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),

                      // 메인 타이틀
                      Text(
                        '소중한 당신은\n[표출형] 인 것 같아요',
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
                        '이별대처유형 테스트 결과는 맞춤 퀘스트 제공에 사용돼요',
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

                      // 결과 표시 컨테이너
                      Container(
                        width: double.infinity,
                        height: 360,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF1F2124),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // "내가 참아야지..." 텍스트
                            Container(
                              width: 163,
                              height: 46,
                              decoration: BoxDecoration(
                                color: const Color(0xFF3D4147),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: Text(
                                  '나 지금 슬프다고!!',
                                  textAlign: TextAlign.center,
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
                            ),

                            SizedBox(height: 2),

                            // 캐릭터 이미지
                            Stack(
                              children: [
                                Container(
                                  width: 360,
                                  height: 300,
                                  child: Image.asset('image/cloud2.png'),
                                ),
                                Positioned(
                                  top: 20,
                                  left: 110,
                                  child: Container(
                                    width: 140,
                                    height: 140,
                                    child: Image.asset(
                                      'image/character1-3.png',
                                    ),
                                  ),
                                ),

                                SizedBox(height: 32),

                                // 결과 설명
                                Positioned(
                                  top: 180,
                                  left: 80,
                                  child: Column(
                                    children: [
                                      Text(
                                        '[표출형]',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: const Color(0xFF65A0FF),
                                          fontSize: 20,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w600,
                                          height: 1.40,
                                          letterSpacing: -0.50,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        '감정을 적극적으로 표현하고 드러내요',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: const Color(0xFF7F8694),
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
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 30),

                      // 다음으로 넘어가기 버튼
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF65A0FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            '다음으로 넘어가기',
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
                              () => const Testscreen8(),
                              transition: Transition.fade,
                            );
                          },
                        ),
                      ),

                      SizedBox(height: 20),

                      // 테스트 다시 응시하기 버튼
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1F2124),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            '테스트 다시 응시하기',
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
                            Get.back();
                            Get.back();
                          },
                        ),
                      ),

                      SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],

            if (widget.selectedOption == '회피형') ...[
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),

                      // 메인 타이틀
                      Text(
                        '소중한 당신은\n[회피형] 인 것 같아요',
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
                        '이별대처유형 테스트 결과는 맞춤 퀘스트 제공에 사용돼요',
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

                      // 결과 표시 컨테이너
                      Container(
                        width: double.infinity,
                        height: 360,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF1F2124),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // "내가 참아야지..." 텍스트
                            Container(
                              width: 163,
                              height: 46,
                              decoration: BoxDecoration(
                                color: const Color(0xFF3D4147),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: Text(
                                  '그냥 생각하기 싫어',
                                  textAlign: TextAlign.center,
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
                            ),

                            SizedBox(height: 2),

                            // 캐릭터 이미지
                            Stack(
                              children: [
                                Container(
                                  width: 360,
                                  height: 300,
                                  child: Image.asset('image/cloud2.png'),
                                ),
                                Positioned(
                                  top: 20,
                                  left: 110,
                                  child: Container(
                                    width: 140,
                                    height: 140,
                                    child: Image.asset(
                                      'image/character1-2.png',
                                    ),
                                  ),
                                ),

                                SizedBox(height: 32),

                                // 결과 설명
                                Positioned(
                                  top: 180,
                                  left: 80,
                                  child: Column(
                                    children: [
                                      Text(
                                        '[회피형]',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: const Color(0xFF65A0FF),
                                          fontSize: 20,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w600,
                                          height: 1.40,
                                          letterSpacing: -0.50,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        '이별과 감정 외적인 것에 집중하려해요',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: const Color(0xFF7F8694),
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
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 30),

                      // 다음으로 넘어가기 버튼
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF65A0FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            '다음으로 넘어가기',
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
                              () => const Testscreen8(),
                              transition: Transition.fade,
                            );
                          },
                        ),
                      ),

                      SizedBox(height: 20),

                      // 테스트 다시 응시하기 버튼
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1F2124),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            '테스트 다시 응시하기',
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
                            Get.back();
                            Get.back();
                          },
                        ),
                      ),

                      SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],

            if (widget.selectedOption == '분석형') ...[
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),

                      // 메인 타이틀
                      Text(
                        '소중한 당신은\n[분석형] 인 것 같아요',
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
                        '이별대처유형 테스트 결과는 맞춤 퀘스트 제공에 사용돼요',
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

                      // 결과 표시 컨테이너
                      Container(
                        width: double.infinity,
                        height: 360,
                        decoration: ShapeDecoration(
                          color: const Color(0xFF1F2124),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // "내가 참아야지..." 텍스트
                            Container(
                              width: 163,
                              height: 46,
                              decoration: BoxDecoration(
                                color: const Color(0xFF3D4147),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Center(
                                child: Text(
                                  '그건 왜 그런거지?',
                                  textAlign: TextAlign.center,
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
                            ),

                            SizedBox(height: 2),

                            // 캐릭터 이미지
                            Stack(
                              children: [
                                Container(
                                  width: 360,
                                  height: 300,
                                  child: Image.asset('image/cloud2.png'),
                                ),
                                Positioned(
                                  top: 20,
                                  left: 110,
                                  child: Container(
                                    width: 140,
                                    height: 140,
                                    child: Image.asset(
                                      'image/character1-1.png',
                                    ),
                                  ),
                                ),

                                SizedBox(height: 32),

                                // 결과 설명
                                Positioned(
                                  top: 180,
                                  left: 80,
                                  child: Column(
                                    children: [
                                      Text(
                                        '[분석형]',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: const Color(0xFF65A0FF),
                                          fontSize: 20,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w600,
                                          height: 1.40,
                                          letterSpacing: -0.50,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      Text(
                                        '이별과 감정의 원인을 이해하려해요',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: const Color(0xFF7F8694),
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
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 30),

                      // 다음으로 넘어가기 버튼
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF65A0FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            '다음으로 넘어가기',
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
                              () => const Testscreen8(),
                              transition: Transition.fade,
                            );
                          },
                        ),
                      ),

                      SizedBox(height: 20),

                      // 테스트 다시 응시하기 버튼
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1F2124),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            '테스트 다시 응시하기',
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
                            Get.back();
                            Get.back();
                          },
                        ),
                      ),

                      SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],

            // 메인 콘텐츠 영역 (스크롤 가능)
          ],
        ),
      ),
    );
  }
}
