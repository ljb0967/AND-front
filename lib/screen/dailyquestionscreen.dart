import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'chatscreen.dart';
import 'homecontentscreen.dart';
import 'farewelldiaryscreen.dart';
import 'farewellshopscreen.dart';
import 'package:flutter/cupertino.dart';

class DailyQuestionScreen extends StatefulWidget {
  const DailyQuestionScreen({super.key});

  @override
  State<DailyQuestionScreen> createState() => _DailyQuestionScreenState();
}

class _DailyQuestionScreenState extends State<DailyQuestionScreen> {
  int _selectedIndex = 1;
  int coin = 10;
  final List<Widget> _pages = [
    const ChatScreen(), // 인덱스 0: 대화하기
    const DailyQuestionScreen(), // 인덱스 1: 일일문답
    const Homecontentscreen(), // 인덱스 2: 홈 (기존 CustomScrollView 내용)
    const FarewellDiaryScreen(), // 인덱스 3: 이별일기
    const FarewellShopScreen(), // 인덱스 4: 이별상점
  ];

  DateTime _selectedDate = DateTime.now();
  DateTime _currentMonth = DateTime.now();

  String get _formattedSelectedDate {
    final weekdays = ['월', '화', '수', '목', '금', '토', '일'];
    final weekday = weekdays[_selectedDate.weekday - 1];
    return '${_selectedDate.year}년 ${_selectedDate.month}월 ${_selectedDate.day}일 $weekday요일';
  }

  void _selectDate(DateTime date) {
    setState(() {
      _selectedDate = date;
      // 선택된 날짜의 답변 데이터 가져오기
      _selectedDateAnswer = _getAnswerForDate(date);
    });
  }

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
    });
  }

  void _showYearMonthPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return _YearMonthPicker(
          currentYear: _currentMonth.year,
          currentMonth: _currentMonth.month,
          onYearMonthSelected: (int year, int month) {
            setState(() {
              // 현재 월을 선택된 연도와 월로 업데이트
              _currentMonth = DateTime(year, month);

              // 선택된 날짜가 새로운 월에 없으면 1일로 설정
              if (_selectedDate.month != month || _selectedDate.year != year) {
                _selectedDate = DateTime(year, month, 1);
              }
            });
            Navigator.pop(context);
          },
        );
      },
    );
  }

  List<DateTime> _getDaysInMonth() {
    final firstDayOfMonth = DateTime(
      _currentMonth.year,
      _currentMonth.month,
      1,
    );
    final lastDayOfMonth = DateTime(
      _currentMonth.year,
      _currentMonth.month + 1,
      0,
    );

    // 이전 달의 마지막 날들
    final firstWeekday = firstDayOfMonth.weekday;
    final daysFromPreviousMonth = firstWeekday - 1;
    final previousMonth = DateTime(
      _currentMonth.year,
      _currentMonth.month - 1,
      0,
    );

    List<DateTime> days = [];

    // 이전 달의 날들 추가
    for (int i = daysFromPreviousMonth - 1; i >= 0; i--) {
      days.add(previousMonth.subtract(Duration(days: i)));
    }

    // 현재 달의 날들 추가
    for (int i = 1; i <= lastDayOfMonth.day; i++) {
      days.add(DateTime(_currentMonth.year, _currentMonth.month, i));
    }

    // 다음 달의 첫날들 추가 (6주 표시를 위해)
    final remainingDays = 42 - days.length;
    for (int i = 1; i <= remainingDays; i++) {
      days.add(DateTime(_currentMonth.year, _currentMonth.month + 1, i));
    }

    return days;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // 선택된 인덱스를 업데이트합니다.
    });
    if (index == 1) return;
    Get.off(_pages[index], transition: Transition.fade);
  }

  bool _isActive = true;
  bool _isActive2 = true;
  final TextEditingController _answerController = TextEditingController();
  int _characterCount = 0; // 글자수 카운터 추가
  //int _selectedIndex = 1;

  // 각 일기 카드의 확장 상태를 관리하는 리스트
  final List<bool> _expandedStates = List.generate(7, (index) => false);

  @override
  void initState() {
    super.initState();
    // 글자수 카운터 리스너 추가
    _answerController.addListener(_updateCharacterCount);
  }

  @override
  void dispose() {
    _answerController.removeListener(_updateCharacterCount);
    _answerController.dispose();
    super.dispose();
  }

  // 글자수 업데이트 함수
  void _updateCharacterCount() {
    setState(() {
      _characterCount = _answerController.text.length;
    });
  }

  // 답변 삭제 확인 다이얼로그 표시
  void _showDeleteConfirmDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2A2A2A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text(
            '답변 삭제하기',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Text(
            '지금 취소하면 답변 내용은 저장되지 않아요',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
              child: Text(
                '취소',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
                _deleteAnswer(); // 답변 삭제 실행
              },
              child: Text(
                '확인',
                style: TextStyle(
                  color: const Color(0xFF65A0FF),
                  fontSize: 16,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // 답변 삭제 실행
  void _deleteAnswer() {
    setState(() {
      _answerController.clear();
      _characterCount = 0;
    });
  }

  // 답변 저장하기 기능
  void _saveAnswer() {
    if (_answerController.text.trim().isEmpty) {
      // 답변이 비어있으면 저장하지 않음
      return;
    }

    // 현재 날짜 정보 가져오기
    final now = DateTime.now();
    final dateString =
        '${now.year}.${now.month.toString().padLeft(2, '0')}.${now.day.toString().padLeft(2, '0')}';
    final weekdays = ['월', '화', '수', '목', '금', '토', '일'];
    final weekdayString = weekdays[now.weekday - 1];

    // 새로운 답변 데이터 생성
    final newAnswer = {
      'date': dateString,
      'weekday': weekdayString,
      'question': '오늘 나의 감정을 색깔로 표현한다면 어떤 색일까요? 그 이유는 무엇인가요?',
      'answer': _answerController.text.trim(),
    };

    // 문답보관함에 추가 (새로운 답변을 맨 위에 추가)
    setState(() {
      _diaryArchiveData.insert(0, newAnswer);
      // 최대 7개까지만 유지
      if (_diaryArchiveData.length > 20) {
        _diaryArchiveData.removeLast();
      }
      if (_characterCount >= 300) {
        coin += 1;
      }
    });

    // 답변 입력 필드 초기화
    _answerController.clear();
    _characterCount = 0;

    // 성공 알림창 표시
    _showSaveSuccessNotification();
  }

  // 해당 날짜에 답변이 있는지 확인하는 함수
  bool _hasAnswerOnDate(DateTime date) {
    final dateString =
        '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}';
    return _diaryArchiveData.any((answer) => answer['date'] == dateString);
  }

  // 선택된 날짜의 답변 데이터 가져오기
  Map<String, dynamic>? _getAnswerForDate(DateTime date) {
    final dateString =
        '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}';
    try {
      return _diaryArchiveData.firstWhere(
        (answer) => answer['date'] == dateString,
      );
    } catch (e) {
      return null;
    }
  }

  // 저장 성공 알림창 표시
  void _showSaveSuccessNotification() {
    // 오버레이 위젯으로 알림창 표시
    OverlayEntry? overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 400,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF1F2124),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '답변이 저장되었어요',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    color: const Color(0xFF65A0FF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    // 오버레이에 알림창 추가
    Overlay.of(context).insert(overlayEntry);

    // 200ms 후에 알림창 제거
    Future.delayed(const Duration(milliseconds: 1200), () {
      overlayEntry?.remove();
    });
  }

  // 선택된 날짜의 답변 상세 내용을 표시할 상태
  Map<String, dynamic>? _selectedDateAnswer;

  // 문답보관함 데이터 리스트 (상태로 관리)
  final List<Map<String, dynamic>> _diaryArchiveData = [
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

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(18, 0, 24, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '오늘의 1일 1문답',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w600,
                                  height: 1.40,
                                ),
                              ),
                              Container(
                                decoration: ShapeDecoration(
                                  color: const Color(0xFF1F2124),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 22,
                                      height: 22,
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFF65A0FF),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            100,
                                          ),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        spacing: 8,
                                        children: [
                                          SizedBox(
                                            width: 22,
                                            child: Text(
                                              '&',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: const Color(0xFF111111),
                                                fontSize: 14,
                                                fontFamily: 'Pretendard',
                                                fontWeight: FontWeight.w600,
                                                height: 1.40,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      '$coin',
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
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  child: Text(
                    '지금 이 순간, 나에게 집중해보는 일일문답',
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
                        padding: const EdgeInsets.fromLTRB(16, 4, 26, 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Text(
                                '300자 이상 입력하면 1&를 받을 수 있어요',
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

                            Container(
                              child: Text(
                                '$_characterCount/1000',
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
                        child: GestureDetector(
                          onTap: _showDeleteConfirmDialog,
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
                                '답변 삭제하기',
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
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: GestureDetector(
                          onTap: _saveAnswer,
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
                    ),
                  ],
                ),
                SizedBox(height: 24.0),
              ],
              if (!_isActive && _isActive2) ...[
                // 문답보관함
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 문답보관함 제목

                    // 문답보관함 설명
                    SizedBox(height: 12.0),

                    // 날짜별 일기 가로 스크롤뷰
                    Container(
                      height: 475.0,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: 7, // 일주일치 일기
                        itemBuilder: (context, index) {
                          return _buildDiaryArchiveCard(index);
                        },
                      ),
                    ),
                  ],
                ),
              ],
              if (!_isActive && !_isActive2) ...[
                Column(
                  children: [
                    SizedBox(height: 12.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: _previousMonth,
                          icon: Icon(
                            Icons.chevron_left,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              '${_currentMonth.year}.${_currentMonth.month.toString().padLeft(2, '0')}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: _showYearMonthPicker,
                              child: Icon(
                                Icons.calendar_today,
                                color: const Color(0xFFFFFFFF),
                                size: 16,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: _nextMonth,
                          icon: Icon(
                            Icons.chevron_right,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.0),

                    // 달력 컨테이너
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: ShapeDecoration(
                        color: const Color(0xFF1F2124),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Color(0x0A000000),
                            blurRadius: 12,
                            offset: Offset(0, 0),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),

                          // 요일 헤더
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: ['월', '화', '수', '목', '금', '토', '일'].map((
                              day,
                            ) {
                              return Container(
                                width: 32,
                                height: 32,
                                child: Center(
                                  child: Text(
                                    day,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w500,
                                      height: 1.40,
                                      letterSpacing: -0.30,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                          const SizedBox(height: 8),

                          // 달력 그리드
                          ...List.generate(5, (weekIndex) {
                            final weekDays = _getDaysInMonth()
                                .skip(weekIndex * 7)
                                .take(7)
                                .toList();
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: weekDays.map((date) {
                                  final isCurrentMonth =
                                      date.month == _currentMonth.month;
                                  final isSelected =
                                      date.year == _selectedDate.year &&
                                      date.month == _selectedDate.month &&
                                      date.day == _selectedDate.day;
                                  final isToday =
                                      date.year == DateTime.now().year &&
                                      date.month == DateTime.now().month &&
                                      date.day == DateTime.now().day;

                                  return GestureDetector(
                                    onTap: () => _selectDate(date),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 32,
                                          height: 32,
                                          decoration: BoxDecoration(
                                            color: isSelected
                                                ? const Color(0xFF65A0FF)
                                                : isToday
                                                ? const Color(0xFF2A2D31)
                                                : Colors.transparent,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                            child: Text(
                                              '${date.day}',
                                              style: TextStyle(
                                                color: isSelected
                                                    ? Colors.white
                                                    : isCurrentMonth
                                                    ? Colors.white
                                                    : const Color(0xFF7F8694),
                                                fontSize: 14,
                                                fontFamily: 'Pretendard',
                                                fontWeight:
                                                    isSelected || isToday
                                                    ? FontWeight.w600
                                                    : FontWeight.w500,
                                                height: 1.40,
                                                letterSpacing: -0.35,
                                              ),
                                            ),
                                          ),
                                        ),
                                        // 파란색 점 표시 (해당 날짜에 답변이 있는 경우)
                                        if (_hasAnswerOnDate(date)) ...[
                                          SizedBox(height: 4),
                                          Container(
                                            width: 4,
                                            height: 4,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF65A0FF),
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),

                    // 선택된 날짜의 답변 상세 내용 표시
                    if (_selectedDateAnswer != null) ...[
                      SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: ShapeDecoration(
                          color: const Color(0xFF1F2124),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 날짜 헤더
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${_selectedDateAnswer!['date']} (${_selectedDateAnswer!['weekday']})',
                                  style: TextStyle(
                                    color: const Color(0xFFB8BFCC),
                                    fontSize: 14,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w500,
                                    height: 1.40,
                                    letterSpacing: -0.35,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedDateAnswer = null;
                                    });
                                  },
                                  child: Icon(
                                    Icons.close,
                                    color: const Color(0xFFB8BFCC),
                                    size: 20,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),

                            // 질문
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color(0xFF2A2D31),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                _selectedDateAnswer!['question'],
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
                            SizedBox(height: 12),

                            // 답변
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color(0xFF2A2D31),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                _selectedDateAnswer!['answer'],
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
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ],
          ),
        ),
      ),

      floatingActionButton: !_isActive
          ? Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: FloatingActionButton.extended(
                backgroundColor: const Color(0xFF111111),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
                label: Row(
                  //mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFF1F2124),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          children: [
                            // 캘린더 아이콘 (비활성)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isActive2 = true;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                  color: _isActive2
                                      ? const Color(0xFF65A0FF)
                                      : const Color(0xFF1F2124),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Icon(
                                  Icons.view_list,
                                  color: Colors.white,
                                  size: 20.0,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isActive2 = false;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                  color: _isActive2
                                      ? const Color(0xFF1F2124)
                                      : const Color(0xFF65A0FF),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Icon(
                                  Icons.calendar_today,
                                  color: Colors.white,
                                  size: 20.0,
                                ),
                              ),
                            ),
                            // 네모 막대 2개 아이콘 (활성 - 파란색)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                onPressed: () {},
              ),
            )
          : null,

      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('image/message-circle.png')),
            label: '대화하기',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('image/edit.png')),
            label: '일일문답',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('image/home.png')),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('image/book.png')),
            label: '이별일기',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('image/shopping-bag.png')),
            label: '이별상점',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color(0xFF8A9099),
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w600,
          height: 2.20,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w600,
          height: 2.20,
        ),
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
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
    final data = _diaryArchiveData[index % _diaryArchiveData.length];

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

class _YearMonthPicker extends StatefulWidget {
  final int currentYear;
  final int currentMonth;
  final Function(int year, int month) onYearMonthSelected;

  const _YearMonthPicker({
    required this.currentYear,
    required this.currentMonth,
    required this.onYearMonthSelected,
  });

  @override
  State<_YearMonthPicker> createState() => _YearMonthPickerState();
}

class _YearMonthPickerState extends State<_YearMonthPicker> {
  late FixedExtentScrollController _yearController;
  late FixedExtentScrollController _monthController;
  late int _selectedYear;
  late int _selectedMonth;

  @override
  void initState() {
    super.initState();
    _selectedYear = widget.currentYear;
    _selectedMonth = widget.currentMonth;
    _yearController = FixedExtentScrollController(
      initialItem: _selectedYear - 1900,
    );
    _monthController = FixedExtentScrollController(
      initialItem: _selectedMonth - 1,
    );
  }

  @override
  void dispose() {
    _yearController.dispose();
    _monthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF2A2D31),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // 드래그 핸들
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 20),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFF7F8694),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // 연도와 월 선택 영역
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              children: [
                // 연도 선택
                Expanded(
                  child: Column(
                    children: [
                      // 위쪽 화살표
                      Icon(
                        Icons.keyboard_arrow_up,
                        color: const Color(0xFF7F8694),
                        size: 24,
                      ),

                      // 연도 리스트
                      Container(
                        height: 120,
                        child: CupertinoPicker(
                          scrollController: _yearController,
                          itemExtent: 40,
                          onSelectedItemChanged: (index) {
                            setState(() {
                              _selectedYear = 1900 + index;
                            });
                          },
                          children: List.generate(200, (index) {
                            final year = 1900 + index;
                            final isSelected = year == _selectedYear;
                            return Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFF1F2124)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '$year',
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : const Color(0xFF7F8694),
                                    fontSize: 18,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),

                      // 아래쪽 화살표
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: const Color(0xFF7F8694),
                        size: 24,
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 40),

                // 월 선택
                Expanded(
                  child: Column(
                    children: [
                      // 위쪽 화살표
                      Icon(
                        Icons.keyboard_arrow_up,
                        color: const Color(0xFF7F8694),
                        size: 24,
                      ),

                      // 월 리스트
                      Container(
                        height: 120,
                        child: CupertinoPicker(
                          scrollController: _monthController,
                          itemExtent: 40,
                          onSelectedItemChanged: (index) {
                            setState(() {
                              _selectedMonth = index + 1;
                            });
                          },
                          children: List.generate(12, (index) {
                            final month = index + 1;
                            final isSelected = month == _selectedMonth;
                            return Center(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0xFF1F2124)
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  '${month.toString().padLeft(2, '0')}',
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : const Color(0xFF7F8694),
                                    fontSize: 18,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),

                      // 아래쪽 화살표
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: const Color(0xFF7F8694),
                        size: 24,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          // 확인 버튼 추가
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF65A0FF),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  // 사용자가 선택한 연도와 월로 콜백 호출
                  widget.onYearMonthSelected(_selectedYear, _selectedMonth);
                },
                child: Text(
                  '확인',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w600,
                    height: 1.40,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
