import 'package:flutter/material.dart';

class DailyQuestionScreen extends StatefulWidget {
  const DailyQuestionScreen({super.key});

  @override
  State<DailyQuestionScreen> createState() => _DailyQuestionScreenState();
}

class _DailyQuestionScreenState extends State<DailyQuestionScreen> {
  bool _isActive = true;
  final TextEditingController _answerController = TextEditingController();
  //int _selectedIndex = 1;

  // 각 일기 카드의 확장 상태를 관리하는 리스트
  final List<bool> _expandedStates = List.generate(7, (index) => false);

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index; // 선택된 인덱스를 업데이트합니다.
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF111111),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25.0,
                    vertical: 30.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('image/home_image.png', height: 20),
                      Row(
                        children: [
                          Image.asset('image/Bell.png', height: 30),
                          SizedBox(width: 12),
                          Image.asset('image/GearSix.png', height: 30),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Text(
                        '오늘의 1일 1문답',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                          height: 1.40,
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(140, 0, 0, 0),
                      child: Text(
                        '10',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                          height: 1.40,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  child: Text(
                    '나에게 던지는, 오늘 하루 소중한 질문',
                    style: TextStyle(
                      color: const Color(0xFFB8BFCC),
                      fontSize: 14,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w500,
                      height: 1.40,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  // 회원 탭
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isActive = true;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          '1일 1문답',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            height: 1.40,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // 비회원 탭
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isActive = false;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          '문답보관함',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            height: 1.40,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 2,
                      decoration: BoxDecoration(
                        color: _isActive
                            ? Colors.white
                            : const Color(0xFF232529),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 2,
                      decoration: BoxDecoration(
                        color: !_isActive
                            ? Colors.white
                            : const Color(0xFF232529),
                      ),
                    ),
                  ),
                ],
              ),
              if (_isActive) ...[
                // 1일 1문답
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: Container(
                    child: Text(
                      'Question',
                      style: TextStyle(
                        color: const Color(0xFF65A0FF),
                        fontSize: 16,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        height: 1.40,
                        letterSpacing: -0.40,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: Container(
                          width: 348,
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
                          child: Text(
                            '오늘 나의 감정을 색깔로 표현한다면 어떤 색일까요? 그 이유는 무엇인가요?',
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
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Container(
                    child: Text(
                      'Answer',
                      style: TextStyle(
                        color: const Color(0xFF65A0FF),
                        fontSize: 16,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        height: 1.40,
                        letterSpacing: -0.40,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                        child: Text(
                          '100자 이상 입력하면 1&를 받을 수 있어요',
                          style: TextStyle(
                            color: const Color(0xFFB8BFCC),
                            fontSize: 14,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            height: 1.40,
                            letterSpacing: -0.35,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                        child: Container(
                          width: 348,
                          height: 215,
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
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              height: 1.40,
                              letterSpacing: -0.40,
                            ),
                            decoration: InputDecoration(
                              isCollapsed: true,
                              border: InputBorder.none,
                              hintText: '답변을 입력하세요',
                              hintStyle: TextStyle(
                                color: const Color(0xFFB8BFCC),
                                fontSize: 16,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w500,
                                height: 1.40,
                                letterSpacing: -0.40,
                              ),
                            ),
                            controller: _answerController,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.0),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: ShapeDecoration(
                            color: const Color(0xFF1F2124),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '작성 취소하기',
                              style: TextStyle(
                                color: const Color(0xFFB8BFCC),
                                fontSize: 14,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w600,
                                height: 1.40,
                                letterSpacing: -0.35,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: ShapeDecoration(
                            color: const Color(0xFF65A0FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '답변 저장하기',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w600,
                                height: 1.40,
                                letterSpacing: -0.35,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.0),
              ],
              if (!_isActive) ...[
                // 문답보관함
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 문답보관함 제목

                    // 문답보관함 설명
                    // SizedBox(height: 12.0),

                    // 날짜별 일기 가로 스크롤뷰
                    Container(
                      height: 375.0,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: 7, // 일주일치 일기
                        itemBuilder: (context, index) {
                          return _buildDiaryArchiveCard(index);
                        },
                      ),
                    ),

                    SizedBox(height: 8.0),

                    // 페이지 이동 토글 UI
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF1F2124),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            children: [
                              // 캘린더 아이콘 (비활성)
                              Container(
                                padding: const EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF1F2124),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Icon(
                                  Icons.calendar_today,
                                  color: Colors.white,
                                  size: 20.0,
                                ),
                              ),

                              // 네모 막대 2개 아이콘 (활성 - 파란색)
                              Container(
                                padding: const EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF65A0FF),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Icon(
                                  Icons.view_list,
                                  color: Colors.white,
                                  size: 20.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: ImageIcon(AssetImage('image/message-circle.png')),
      //       label: '대화하기',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: ImageIcon(AssetImage('image/edit.png')),
      //       label: '일일문답',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: ImageIcon(AssetImage('image/home.png')),
      //       label: '홈',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: ImageIcon(AssetImage('image/book.png')),
      //       label: '이별일기',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: ImageIcon(AssetImage('image/shopping-bag.png')),
      //       label: '이별상점',
      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: Colors.white,
      //   unselectedItemColor: const Color(0xFF8A9099),
      //   selectedLabelStyle: const TextStyle(
      //     fontSize: 12,
      //     fontFamily: 'Pretendard',
      //     fontWeight: FontWeight.w600,
      //     height: 2.20,
      //   ),
      //   unselectedLabelStyle: const TextStyle(
      //     fontSize: 12,
      //     fontFamily: 'Pretendard',
      //     fontWeight: FontWeight.w600,
      //     height: 2.20,
      //   ),
      //   onTap: _onItemTapped,
      //   type: BottomNavigationBarType.fixed,
      //   backgroundColor: Colors.black,
      // ),
    );
  }

  // 문답보관함 일기 카드 위젯 생성
  Widget _buildDiaryArchiveCard(int index) {
    // 샘플 데이터 (실제로는 API에서 가져올 데이터)
    final List<Map<String, dynamic>> diaryArchiveData = [
      {
        'date': '2025.08.31',
        'weekday': '일',
        'question': '오늘 나의 감정을 색깔로 표현한다면 어떤 색일까요...',
        'answer':
            '오늘 나의 감정은 뭔가 보라색같다. 요근래 계속 아빠 생각이 나서 가슴이 답답하고 우울했는데, 오늘 아빠랑 앱에서 대화하고 오랜만에 아빠랑 갔었던 광안리를 가니까 그동안 묵었던 뭔지 모를 감정들이 씻겨 내려가는 느낌이었다. 그때 바라본 하늘은 너무나 예쁜 보라색이었고, 오묘한 그 색감이 마치 나의 기분과 비슷한 것 같다는 생각이 들었다.',
      },
      {
        'date': '2025.08.30',
        'weekday': '토',
        'question': '지금 내 마음을 한 단어로 표현한다면 어떤 단어가...',
        'answer':
            '지금 내 마음을 한 단어로 표현한다면 "희망"이다. 어제까지는 너무나 절망적이었는데, 오늘 아침에 일어나서 창밖을 보니 햇살이 너무 예뻐서 문득 기분이 좋아졌다. 그리고 친구가 연락을 해줘서 오랜만에 만나서 이야기를 나누었는데, 그 과정에서 내가 생각했던 것보다 훨씬 많은 사람들이 나를 응원하고 있다는 걸 알게 되었다.',
      },
      {
        'date': '2025.08.29',
        'weekday': '금',
        'question': '오늘 하루에서 가장 고마웠던 순간을 꼽는다면 언제...',
        'answer':
            '오늘 하루에서 가장 고마웠던 순간은 아침에 일어나서 엄마가 차려준 아침밥을 먹을 때였다. 평소에는 그냥 당연하게 여겼는데, 오늘은 문득 엄마가 매일 아침 일찍 일어나서 우리 가족을 위해 밥을 차려주신다는 게 너무나 감사하게 느껴졌다. 그리고 밥을 먹으면서 엄마와 대화를 나누었는데, 그 순간이 정말 소중하게 느껴졌다.',
      },
      {
        'date': '2025.08.28',
        'weekday': '목',
        'question': '가족과의 추억 속에서 나를 웃게 만드는 장면 하나...',
        'answer':
            '가족과의 추억 속에서 나를 웃게 만드는 장면은 작년 여름에 가족 여행을 갔을 때였다. 우리 가족이 바다에 갔는데, 아빠가 처음으로 서핑을 배우려고 했는데 계속 넘어져서 우리 모두가 웃었던 순간이다. 아빠는 처음에는 당황했지만 나중에는 우리와 함께 웃으면서 "다음에는 꼭 성공할 거야!"라고 말씀하셨다. 그때 아빠의 진지한 표정과 우리 가족의 웃음소리가 아직도 생생하게 기억난다.',
      },
      {
        'date': '2025.08.27',
        'weekday': '수',
        'question': '오늘 하루를 한 문장으로 요약한다면...',
        'answer':
            '오늘 하루를 한 문장으로 요약한다면 "작은 변화들이 모여 큰 기쁨을 만들어낸 하루"였다. 아침에 일어나서 계획했던 것보다 훨씬 많은 일들을 해냈고, 그 과정에서 예상치 못한 좋은 일들도 많이 일어났다. 특히 오후에 우연히 만난 친구와의 대화가 정말 의미있었고, 저녁에는 가족과 함께 맛있는 저녁을 먹으면서 하루를 마무리할 수 있었다.',
      },
      {
        'date': '2025.08.26',
        'weekday': '화',
        'question': '내일의 나에게 전하고 싶은 한 마디...',
        'answer':
            '내일의 나에게 전하고 싶은 한 마디는 "너는 충분히 잘하고 있어"이다. 요즘 너무 많은 것들을 동시에 하려고 해서 스트레스를 받고 있는 것 같은데, 모든 것을 완벽하게 하려고 하지 말고 한 번에 하나씩 차근차근 해나가면 된다. 그리고 실수해도 괜찮아, 그게 성장의 증거니까 너무 자신을 몰아세우지 말고 여유를 가져라.',
      },
      {
        'date': '2025.08.25',
        'weekday': '월',
        'question': '이번 주에서 가장 기억에 남는 순간은...',
        'answer':
            '이번 주에서 가장 기억에 남는 순간은 어제 친구들과 함께한 저녁 모임이었다. 오랜만에 모인 친구들과 함께 맛있는 음식을 먹으면서 각자의 근황을 이야기했는데, 서로의 고민을 들어주고 조언을 해주는 과정에서 우리가 얼마나 서로를 아끼고 신뢰하는지 다시 한번 느낄 수 있었다. 그리고 그 과정에서 나도 모르게 웃고 있는 내 모습을 발견했는데, 그 순간이 정말 행복했다.',
      },
    ];

    final data = diaryArchiveData[index % diaryArchiveData.length];

    return Container(
      width: 300.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 날짜 헤더
          Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 0, 0, 0),
            child: Container(
              child: Text(
                '${data['date']} (${data['weekday']})',
                style: TextStyle(
                  color: const Color(0xFFB8BFCC),
                  fontSize: 14,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                  height: 1.40,
                  letterSpacing: -0.35,
                ),
              ),
            ),
          ),

          SizedBox(height: 8.0),

          // 질문 카드
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: Container(
                    width: 348,
                    padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 16.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F2124),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            data['question'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              height: 1.40,
                              letterSpacing: -0.40,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 12.0),
                        // 확장/축소 아이콘
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              // 확장/축소 상태 토글
                              _expandedStates[index] = !_expandedStates[index];
                            });
                          },
                          child: Icon(
                            _expandedStates[index]
                                ? Icons.keyboard_arrow_up
                                : Icons.keyboard_arrow_down,
                            color: const Color(0xFFB8BFCC),
                            size: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),

          // 답변 내용 (확장 시에만 표시)
          if (_expandedStates[index]) ...[
            SizedBox(height: 12.0),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Container(
                      height: 320,
                      width: double.infinity,
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1F2124),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        data['answer'],
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
                ),
              ],
            ),
            SizedBox(height: 12.0),
          ],
        ],
      ),
    );
  }
}
