import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'chatscreen.dart';
import 'dailyquestionscreen.dart';
import 'homecontentscreen.dart';
import 'farewellshopscreen.dart';
import 'package:flutter/cupertino.dart';
import 'diary_write_screen.dart';
import '../state/user_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FarewellDiaryScreen extends StatefulWidget {
  const FarewellDiaryScreen({super.key});

  @override
  State<FarewellDiaryScreen> createState() => _FarewellDiaryScreenState();
}

class _FarewellDiaryScreenState extends State<FarewellDiaryScreen> {
  int _selectedIndex = 3;
  final UserController userController = Get.find();
  final List<Widget> _pages = [
    const ChatScreen(), // 인덱스 0: 대화하기
    const DailyQuestionScreen(), // 인덱스 1: 일일문답
    const Homecontentscreen(), // 인덱스 2: 홈 (기존 CustomScrollView 내용)
    const FarewellDiaryScreen(), // 인덱스 3: 이별일기
    const FarewellShopScreen(), // 인덱스 4: 이별상점
  ];

  DateTime _selectedDate = DateTime.now();
  DateTime _currentMonth = DateTime.now();

  void _selectDate(DateTime date) {
    setState(() {
      _selectedDate = date;
      _isExpanded = false;
    });

    // 선택된 날짜의 답변 데이터를 비동기로 가져오기
    _getAnswerForDateAsync(date).then((answer) {
      if (mounted) {
        setState(() {
          _selectedDateAnswer = answer;
        });
      }
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

  bool _isExpanded = false;

  bool _hasAnswerOnDate(DateTime date) {
    final dateString =
        '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}';

    // _allDiaryData에서 확인 (기본 데이터 + SharedPreferences 데이터)
    bool hasAnswer = _allDiaryData.any(
      (answer) => answer['date'] == dateString,
    );

    // GetX에서 저장된 일기도 확인 (UI 업데이트용)
    try {
      final savedDiary = Get.find<Map<String, dynamic>>(tag: 'savedDiary');
      if (savedDiary['date'] == dateString) {
        hasAnswer = true;
      }
    } catch (e) {
      // 저장된 일기가 없는 경우 무시
    }

    return hasAnswer;
  }

  // 선택된 날짜의 답변 데이터 가져오기 (비동기)
  Future<Map<String, dynamic>?> _getAnswerForDateAsync(DateTime date) async {
    final dateString =
        '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}';
    try {
      final allData = await _getAllDiaryData();
      return allData.firstWhere((answer) => answer['date'] == dateString);
    } catch (e) {
      return null;
    }
  }

  void _deleteAnswer() {
    if (_selectedDateAnswer != null) {
      _showDeleteConfirmDialog();
    }
  }

  // 삭제 확인 다이얼로그 표시
  void _showDeleteConfirmDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2A2D31),
          title: Text(
            '일기 삭제',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Text(
            '정말로 이 일기를 삭제하시겠습니까?',
            style: TextStyle(
              color: const Color(0xFFBDC7DB),
              fontSize: 16,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                '취소',
                style: TextStyle(
                  color: const Color(0xFF7F8694),
                  fontSize: 16,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _performDelete();
              },
              child: Text(
                '삭제',
                style: TextStyle(
                  color: Colors.red,
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

  // 실제 삭제 수행
  Future<void> _performDelete() async {
    if (_selectedDateAnswer == null) return;

    try {
      final prefs = await SharedPreferences.getInstance();
      final savedDiariesJson = prefs.getString('diaries') ?? '[]';
      final List<dynamic> savedDiaries = json.decode(savedDiariesJson);

      // 선택된 날짜의 일기 찾아서 삭제
      final dateToDelete = _selectedDateAnswer!['date'];
      savedDiaries.removeWhere((diary) => diary['date'] == dateToDelete);

      // 업데이트된 일기 목록 저장
      await prefs.setString('diaries', json.encode(savedDiaries));

      // GetX에서도 제거
      if (Get.isRegistered<Map<String, dynamic>>(tag: 'savedDiary')) {
        final savedDiary = Get.find<Map<String, dynamic>>(tag: 'savedDiary');
        if (savedDiary['date'] == dateToDelete) {
          Get.delete<Map<String, dynamic>>(tag: 'savedDiary');
        }
      }

      // UI 업데이트
      setState(() {
        _selectedDateAnswer = null;
        _isExpanded = false;
      });

      // SharedPreferences 데이터 다시 로드
      await _loadSharedPreferencesData();

      // 성공 메시지 표시
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('일기가 삭제되었습니다.'),
          backgroundColor: const Color(0xFF65A0FF),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      print('일기 삭제 오류: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('일기 삭제 중 오류가 발생했습니다.'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  // 일기 수정하기
  void _editDiary() {
    if (_selectedDateAnswer != null) {
      // 수정할 일기 데이터를 GetX에 저장하여 diary_write_screen에서 사용할 수 있도록 함
      Get.put(_selectedDateAnswer!, tag: 'editingDiary');

      // diary_write_screen으로 이동
      Get.to(() => DiaryWriteScreen(), transition: Transition.fade);
    }
  }

  Map<String, dynamic>? _selectedDateAnswer;

  final List<Map<String, dynamic>> _diaryArchiveData = [
    {
      'date': '2025.08.29',
      'weekday': '금',
      'question': '진짜 오랜만에 바다 갔다온 날',
      'answer':
          '창밖을 보니 정말 오랜만에 비가 오고 있었다. 이유는 잘 모르겠지만, 밖으로 나가야만 할 것 같았다. 우산도 쓰지 않은 채 비를 맞으니 그간 쌓여 있던 무언가가 밖으로 터져나오는 것만 같았다. 너무나 보고 싶은 내 동생, 이 고통스러운 마음이 비와 함께 씻겨 내려갔으면 좋겠다고 생각했다.\n\n반쯤 미친 사람처럼 온몸이 젖은 채 집에 들어와 따뜻하게 샤워를 하고, 차 한 잔을 들고 소파에 앉으니 자연스레 깊은 생각에 잠겼다. 오늘 아침에도 평소처럼 앱을 열어 퀘스트를 확인했는데, ‘1시간 이상 바깥 공기 쐬고 오기’가 있었다. 밖에는 비가 많이 내리고 있었기에 평소 같았으면 고민조차 하지 않았을 외출이지만, 그동안 억눌린 감정들과 더 이상 억누르고 살고 싶지 않다는 마음이 합쳐져 나를 계획도 없이 밖으로 나가게 한 것 같다. 일단 하고 싶은 대로 하고 나니 뭔가 후련한 것 같기도 했다. 이렇게 마음 놓고 울어본 것도 처음이지 싶었다.\n\n물론 여전히 사랑하는 내 동생이 너무나 보고 싶지만, 이제는 나 자신도 아껴야겠다는 생각이 든다. 짧은 시간 동안 많은 것을 겪고 또 생각하게 된 하루였다. 오늘은 조금은 다른 기분으로 잠들 수 있을 것 같은 느낌이다.',
    },
  ];

  // 저장된 일기 데이터를 가져오는 메서드
  Future<List<Map<String, dynamic>>> _getAllDiaryData() async {
    final List<Map<String, dynamic>> allData = List.from(_diaryArchiveData);

    try {
      // SharedPreferences에서 저장된 일기 데이터 가져오기
      final prefs = await SharedPreferences.getInstance();
      final savedDiariesJson = prefs.getString('diaries') ?? '[]';
      final List<dynamic> savedDiaries = json.decode(savedDiariesJson);

      // 저장된 일기들을 allData에 추가
      for (final savedDiary in savedDiaries) {
        final existingIndex = allData.indexWhere(
          (diary) => diary['date'] == savedDiary['date'],
        );
        if (existingIndex != -1) {
          allData[existingIndex] = savedDiary;
        } else {
          allData.add(savedDiary);
        }
      }
    } catch (e) {
      print('저장된 일기 불러오기 오류: $e');
    }

    return allData;
  }

  // 동기 버전 (기존 코드와의 호환성을 위해)
  List<Map<String, dynamic>> get _allDiaryData {
    // 기본 데이터와 SharedPreferences에서 로드된 데이터를 합쳐서 반환
    final allData = List<Map<String, dynamic>>.from(_diaryArchiveData);
    allData.addAll(_loadedSharedPreferencesData);
    return allData;
  }

  // SharedPreferences에서 로드된 데이터를 저장할 변수
  List<Map<String, dynamic>> _loadedSharedPreferencesData = [];

  @override
  void initState() {
    super.initState();

    // 기본 일기 데이터를 SharedPreferences에 저장
    _saveDefaultDiaryData();

    // SharedPreferences에서 데이터 로드
    _loadSharedPreferencesData();

    // diaryUpdated RxBool 초기화
    if (!Get.isRegistered<RxBool>(tag: 'diaryUpdated')) {
      Get.put(RxBool(false), tag: 'diaryUpdated');
    }

    // 일기가 업데이트되었을 때 데이터를 다시 로드하는 리스너
    ever(Get.find<RxBool>(tag: 'diaryUpdated'), (bool updated) {
      if (updated) {
        _loadSharedPreferencesData();
        // 신호 초기화
        Get.find<RxBool>(tag: 'diaryUpdated').value = false;
      }
    });

    _selectDate(DateTime.now());
  }

  // 기본 일기 데이터를 SharedPreferences에 저장
  Future<void> _saveDefaultDiaryData() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // 이미 기본 데이터가 저장되어 있는지 확인
      final hasDefaultData = prefs.getBool('hasDefaultData') ?? false;

      if (!hasDefaultData) {
        // _diaryArchiveData의 데이터를 SharedPreferences에 저장
        final existingDiariesJson = prefs.getString('diaries') ?? '[]';
        final List<dynamic> existingDiaries = json.decode(existingDiariesJson);

        // 기본 데이터 추가 (중복 방지)
        for (final defaultDiary in _diaryArchiveData) {
          final existingIndex = existingDiaries.indexWhere(
            (diary) => diary['date'] == defaultDiary['date'],
          );

          if (existingIndex == -1) {
            // 기본 데이터가 없으면 추가
            existingDiaries.add(defaultDiary);
          }
        }

        // 업데이트된 일기 목록 저장
        await prefs.setString('diaries', json.encode(existingDiaries));

        // 기본 데이터 저장 완료 표시
        await prefs.setBool('hasDefaultData', true);

        print('기본 일기 데이터 저장 완료');
      }
    } catch (e) {
      print('기본 일기 데이터 저장 오류: $e');
    }
  }

  // SharedPreferences에서 데이터 로드
  Future<void> _loadSharedPreferencesData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedDiariesJson = prefs.getString('diaries') ?? '[]';
      final List<dynamic> savedDiaries = json.decode(savedDiariesJson);

      setState(() {
        _loadedSharedPreferencesData = List<Map<String, dynamic>>.from(
          savedDiaries,
        );
      });
    } catch (e) {
      print('SharedPreferences 데이터 로드 오류: $e');
    }
  }

  @override
  void dispose() {
    // GetX 리스너 정리
    if (Get.isRegistered<RxBool>(tag: 'diaryUpdated')) {
      Get.delete<RxBool>(tag: 'diaryUpdated');
    }

    // 수정 모드 태그 정리
    if (Get.isRegistered<Map<String, dynamic>>(tag: 'editingDiary')) {
      Get.delete<Map<String, dynamic>>(tag: 'editingDiary');
    }

    // savedDiary 태그 정리
    if (Get.isRegistered<Map<String, dynamic>>(tag: 'savedDiary')) {
      Get.delete<Map<String, dynamic>>(tag: 'savedDiary');
    }

    super.dispose();
  }

  void _onItemTapped(int index) {
    // 현재 화면과 같은 화면을 선택한 경우 navigation하지 않음
    if (index == _selectedIndex) return;

    setState(() {
      _selectedIndex = index; // 선택된 인덱스를 업데이트합니다.
    });

    // 다른 화면으로 이동할 때만 navigation
    if (index != 3) {
      Get.off(_pages[index], transition: Transition.fade);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF111111),
      body: Container(
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
                              '오늘의 이별일기',
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
                                    '${userController.coin.value}',
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
                  '나의 소중한 하루를 다시 써내려가는 이별일기',
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
            SizedBox(height: 12),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                      child: Container(
                        //width: double.infinity,
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
                              children: ['월', '화', '수', '목', '금', '토', '일'].map(
                                (day) {
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
                                },
                              ).toList(),
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
                                          SizedBox(
                                            width: 32,
                                            height: 36, // 날짜(32) + 점(여유 8)
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                // 날짜 원/텍스트
                                                Container(
                                                  width: 32,
                                                  height: 32,
                                                  decoration: BoxDecoration(
                                                    color: isSelected
                                                        ? const Color(
                                                            0xFF65A0FF,
                                                          )
                                                        : isToday
                                                        ? const Color(
                                                            0xFF2A2D31,
                                                          )
                                                        : Colors.transparent,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    '${date.day}',
                                                    style: TextStyle(
                                                      color: isSelected
                                                          ? Colors.white
                                                          : (isCurrentMonth
                                                                ? Colors.white
                                                                : const Color(
                                                                    0xFF7F8694,
                                                                  )),
                                                      fontSize: 14,
                                                      fontFamily: 'Pretendard',
                                                      fontWeight:
                                                          (isSelected ||
                                                              isToday)
                                                          ? FontWeight.w600
                                                          : FontWeight.w500,
                                                      height: 1.40,
                                                      letterSpacing: -0.35,
                                                    ),
                                                  ),
                                                ),

                                                // 파란 점(아래 고정)
                                                if (_hasAnswerOnDate(date))
                                                  const Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(
                                                        bottom: 2,
                                                      ), // 점과 아래쪽 간격
                                                      child: SizedBox(
                                                        width: 4,
                                                        height: 4,
                                                        child: DecoratedBox(
                                                          decoration:
                                                              BoxDecoration(
                                                                color: Color(
                                                                  0xFF65A0FF,
                                                                ),
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
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
                    ),

                    // 선택된 날짜의 답변 상세 내용 표시
                    if (_selectedDateAnswer != null) ...[
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 날짜 헤더
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    12,
                                    0,
                                    0,
                                    0,
                                  ),
                                  child: Text(
                                    '작성된 일기',
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
                              ],
                            ),
                            SizedBox(height: 12),

                            // 일기 제목
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: const Color(0xFF2A2D31),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      _selectedDateAnswer!['title'] ??
                                          _selectedDateAnswer!['question'] ??
                                          '제목 없음',
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
                                        _isExpanded = !_isExpanded;
                                      });
                                    },
                                    child: Icon(
                                      //Icons.keyboard_arrow_down,
                                      _isExpanded
                                          ? Icons.keyboard_arrow_up
                                          : Icons.keyboard_arrow_down,
                                      color: const Color(0xFFB8BFCC),
                                      size: 20.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 12),

                            // 일기 내용
                            if (_isExpanded) ...[
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF2A2D31),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  _selectedDateAnswer!['content'] ??
                                      _selectedDateAnswer!['answer'] ??
                                      '내용 없음',
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
                            SizedBox(height: 38),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                      16,
                                      0,
                                      16,
                                      0,
                                    ),
                                    child: GestureDetector(
                                      // onTap: _isSaveAnswer()
                                      //     ? _showDeleteConfirmDialog
                                      //     : null,
                                      onTap: _deleteAnswer,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 12,
                                        ),
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFF1F2124),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              100,
                                            ),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '일기 삭제하기',
                                            style: TextStyle(
                                              color: const Color(0xFFBDC7DB),
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
                                    padding: const EdgeInsets.fromLTRB(
                                      16,
                                      0,
                                      16,
                                      0,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        _editDiary();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 12,
                                        ),
                                        decoration: ShapeDecoration(
                                          // color: _isSaveAnswer()
                                          //     ? const Color(0xFF65A0FF)
                                          //     : const Color(0xFF1F2124),
                                          color: const Color(0xFF65A0FF),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              100,
                                            ),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '일기 수정하기',
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
                          ],
                        ),
                      ),

                      SizedBox(height: 100),
                    ] else ...[
                      SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 날짜 헤더
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                    12,
                                    0,
                                    0,
                                    0,
                                  ),
                                  child: Text(
                                    '작성된 일기',
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
                              ],
                            ),
                            SizedBox(height: 28),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text(
                                    '작성된 일기가 없어요',
                                    style: TextStyle(
                                      color: const Color(0xFF7F8694),
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
                            SizedBox(height: 38),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                      16,
                                      0,
                                      16,
                                      0,
                                    ),
                                    child: GestureDetector(
                                      // onTap: _isSaveAnswer()
                                      //     ? _showDeleteConfirmDialog
                                      //     : null,
                                      onTap: null,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 12,
                                        ),
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFF1F2124),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              100,
                                            ),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '일기 삭제하기',
                                            style: TextStyle(
                                              color: const Color(0xFF7F8694),
                                              fontSize: 14,
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w600,
                                              height: 1.40,
                                              letterSpacing: -0.35,
                                            ),
                                            // style: !_isSaveAnswer()
                                            //     ? TextStyle(
                                            //         color: const Color(
                                            //           0xFF7F8694,
                                            //         ),
                                            //         fontSize: 14,
                                            //         fontFamily:
                                            //             'Pretendard',
                                            //         fontWeight:
                                            //             FontWeight.w600,
                                            //         height: 1.40,
                                            //         letterSpacing: -0.35,
                                            //       )
                                            //     : TextStyle(
                                            //         color: const Color(
                                            //           0xFFBDC7DB,
                                            //         ),
                                            //         fontSize: 14,
                                            //         fontFamily:
                                            //             'Pretendard',
                                            //         fontWeight:
                                            //             FontWeight.w600,
                                            //         height: 1.40,
                                            //         letterSpacing: -0.35,
                                            //       ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                      16,
                                      0,
                                      16,
                                      0,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(
                                          DiaryWriteScreen(),
                                          transition: Transition.fade,
                                        );
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 12,
                                        ),
                                        decoration: ShapeDecoration(
                                          color: const Color(0xFF65A0FF),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              100,
                                            ),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '일기 작성하기',
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
                            // 질문
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
