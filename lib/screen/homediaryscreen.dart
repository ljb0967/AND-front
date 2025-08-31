import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'chatscreen.dart';
import 'dailyquestionscreen.dart';
import 'farewelldiaryscreen.dart';
import 'farewellshopscreen.dart';
import 'homecontentscreen.dart';
import 'diary_detail_screen.dart';
import '../state/card_controller.dart';
import '../state/loss_case_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';

class Homediaryscreen extends StatefulWidget {
  const Homediaryscreen({super.key});

  @override
  State<Homediaryscreen> createState() => _HomediaryscreenState();
}

class _HomediaryscreenState extends State<Homediaryscreen> {
  final List<String> categoryData = ['작성일 순', '이별상대', '이별대처유형', '이별공감', '스크랩'];
  String? _selectedOption = '작성일 순';
  final LossCaseController lossCaseController = Get.find<LossCaseController>();

  int _selectedIndex = 2;
  final CardController cardController = Get.find<CardController>();
  final List<Widget> _pages = [
    const ChatScreen(), // 인덱스 0: 대화하기
    const DailyQuestionScreen(), // 인덱스 1: 일일문답
    const Homecontentscreen(), // 인덱스 2: 홈 (기존 CustomScrollView 내용)
    const FarewellDiaryScreen(), // 인덱스 3: 이별일기
    const FarewellShopScreen(), // 인덱스 4: 이별상점
  ];

  // 동적으로 로드된 일기 데이터
  List<Map<String, dynamic>> _dynamicDiaryData = [];
  bool _isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadHomeDiaries();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 화면이 다시 포커스될 때 데이터 새로고침
    _loadHomeDiaries();
  }

  // SharedPreferences에서 홈 다이어리 데이터 로드
  Future<void> _loadHomeDiaries() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final homeDiariesJson = prefs.getString('homeDiaries') ?? '[]';
      final List<dynamic> homeDiaries = json.decode(homeDiariesJson);

      setState(() {
        _dynamicDiaryData = List<Map<String, dynamic>>.from(homeDiaries);
        _isDataLoaded = true;
      });

      //print('홈 다이어리 데이터 로드 완료: ${_dynamicDiaryData.length}개');
    } catch (e) {
      //print('홈 다이어리 데이터 로드 오류: $e');
      setState(() {
        _isDataLoaded = true;
      });
    }
  }

  // 현재 표시할 일기 데이터 (하드코딩된 데이터 + 동적 데이터)
  List<Map<String, dynamic>> get _allDiaryData {
    final List<Map<String, dynamic>> allData = [];

    // 하드코딩된 기본 데이터 추가
    allData.addAll(diaryData);

    // 동적으로 로드된 데이터 추가 (중복 제거)
    for (final dynamicData in _dynamicDiaryData) {
      final isDuplicate = allData.any(
        (existing) =>
            existing['date'] == dynamicData['date'] &&
            existing['title'] == dynamicData['title'],
      );

      if (!isDuplicate) {
        allData.add(dynamicData);
      }
    }

    // 날짜순으로 정렬 (최신순)
    allData.sort((a, b) {
      final dateA = _parseDate(a['date']);
      final dateB = _parseDate(b['date']);
      return dateB.compareTo(dateA);
    });

    return allData;
  }

  // 날짜 문자열을 DateTime으로 파싱
  DateTime _parseDate(String dateString) {
    try {
      final parts = dateString.split('.');
      if (parts.length == 3) {
        final year = int.parse(parts[0]);
        final month = int.parse(parts[1]);
        final day = int.parse(parts[2]);
        return DateTime(year, month, day);
      }
    } catch (e) {
      print('날짜 파싱 오류: $e');
    }
    return DateTime.now();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // 선택된 인덱스를 업데이트합니다.
    });
    Get.off(_pages[index], transition: Transition.fade);
  }

  @override
  void dispose() {
    // GetX 컨트롤러 정리 (permanent로 등록된 컨트롤러는 자동으로 정리됨)
    // 필요시 추가 정리 로직 구현

    super.dispose();
  }

  bool _isExpanded = false; // 플로팅 버튼 확장 상태
  final List<Map<String, dynamic>> diaryData = [
    {
      'profileImage': 'image/character5.png',
      'userName': '익명의 작성자',
      'subject': 'LOVER',
      'date': '2025.08.27',
      'title': '새로운 취미를 찾았어요',
      'hashtags': ['#연인이별', '#AND+15'],
      'backgroundImage': 'image/diary1.jpg',
      'isBookmarked': false,
      'content':
          '오늘 앱을 켜니까 퀘스트에 \‘함께한 추억이 담긴 기록 살펴보기\'가 있더라구요... 그이가 떠난 후로 한 번도 열어본 적 없었던 사진첩을 이참에 열어봐야겠다 싶어 이곳저곳을 뒤져 찾아냈네요... 그냥 슬프기만 할 줄 알았는데 보다보니 저도 모르게 미소를 짓고 있네요 ㅎㅎ... 참 많이 보고싶네요...',
    },
    {
      'profileImage': 'image/character1.png',
      'userName': '익명의 작성자',
      'subject': 'FAMILY',
      'copeWay': 'SUPPRESS',
      'date': '2025.08.04',
      'title': '그냥, 나가서 온몸으로 비맞은 날',
      'hashtags': ['#가족이별', '#억누르기형'],
      'backgroundImage': 'image/diary2.jpg',
      'isBookmarked': false,
      'content':
          '창밖을 보니 정말 오랜만에 비가 오고 있었다. 이유는 잘 모르겠지만, 밖으로 나가야만 할 것 같았다. 우산도 쓰지 않은 채 비를 맞으니 그간 쌓여 있던 무언가가 밖으로 터져나오는 것만 같았다. 너무나 보고 싶은 내 동생, 이 고통스러운 마음이 비와 함께 씻겨 내려갔으면 좋겠다고 생각했다.\n\n반쯤 미친 사람처럼 온몸이 젖은 채 집에 들어와 따뜻하게 샤워를 하고, 차 한 잔을 들고 소파에 앉으니 자연스레 깊은 생각에 잠겼다. 오늘 아침에도 평소처럼 앱을 열어 퀘스트를 확인했는데, \‘1시간 이상 바깥 공기 쐬고 오기\’가 있었다. 밖에는 비가 많이 내리고 있었기에 평소 같았으면 고민조차 하지 않았을 외출이지만, 그동안 억눌린 감정들과 더 이상 억누르고 살고 싶지 않다는 마음이 합쳐져 나를 계획도 없이 밖으로 나가게 한 것 같다. 일단 하고 싶은 대로 하고 나니 뭔가 후련한 것 같기도 했다. 이렇게 마음 놓고 울어본 것도 처음이지 싶었다.\n\n물론 여전히 사랑하는 내 동생이 너무나 보고 싶지만, 이제는 나 자신도 아껴야겠다는 생각이 든다. 짧은 시간 동안 많은 것을 겪고 또 생각하게 된 하루였다. 오늘은 조금은 다른 기분으로 잠들 수 있을 것 같은 느낌이다.',
    },
    {
      'profileImage': 'image/character2.png',
      'userName': '익명의 작성자',
      'subject': 'FRIEND',
      'copeWay': 'SUPPRESS',
      'date': '2025.08.04',
      'title': '엄마의 머그컵 앞에서 멈춘 하루',
      'hashtags': ['#친구이별', '#억누르기형'],
      'backgroundImage': 'image/diary3.jpg',
      'isBookmarked': true,
      'content':
          '아침에 서둘러 출근 준비를 하다가, 주방 선반에 올려둔 엄마의 머그컵을 발견했다. 별것 아닌 물건인데도 눈길이 오래 머물렀다. 차를 우려 담으려다 결국 멈칫하며 컵을 다시 제자리에 두었다. 그 순간 마음속에서 무언가 울컥 치밀어올랐지만, 그대로 두면 회사에서 하루를 버티기 힘들 것 같아 애써 무표정으로 돌아섰다. 출근길 지하철에서도 평소처럼 이어폰을 꽂고 눈을 감은 채 아무 일도 없는 듯 시간을 흘려보냈다.\n\n오후에 팀 회의 중 점심 메뉴를 정하는데, 동료가 가볍게 \“엄마랑 자주 먹던 건 뭐야?\” 하고 물었다. 갑작스런 질문에 숨이 막히는 것 같았지만, 곧장 다른 메뉴를 추천하며 아무렇지 않은 듯 웃었다. 대화는 이어졌지만, 속으로는 차갑게 얼어붙은 기분이었다. 내가 억지로 감정을 밀어내고 있다는 걸 알면서도, 이렇게 하지 않으면 하루를 버티기 어렵다는 생각에 스스로를 달랬다.\n\n퇴근길에는 괜히 평소보다 두 정거장 일찍 내려 걸었다. 바람이 얼굴을 스치자 문득 엄마가 내게 \“힘들 땐 그냥 숨 크게 쉬어봐\”라고 했던 말씀이 떠올랐다. 조심스레 깊게 들이마시고 내쉬자, 정말 오랜만에 가슴이 조금은 편안해지는 듯했다. 여전히 그리움은 날카롭게 남아 있었지만, 그 순간만큼은 나 자신을 위해 살아가야겠다는 생각이 스쳤다. 작은 숨 한 번이 이렇게 위로가 될 줄은 몰랐다.',
    },
    {
      'profileImage': 'image/character4.png',
      'userName': '익명의 작성자',
      'subject': 'LOVER',
      'copeWay': 'EXPRESS',
      'date': '2025.08.03',
      'title': '울음을 터뜨린 뒤 찾아온 가벼움',
      'hashtags': ['#연인이별', '#표출형'],
      'backgroundImage': 'image/diary4.jpg',
      'isBookmarked': true,
      'content':
          '오늘 아침, 창밖에서 들려오는 새소리가 유난히 낯설게 들렸다. 평소 같으면 아버지께서 먼저 일어나 창문을 열곤 하셨는데, 그 소리가 더 이상 들리지 않는다는 사실이 날 갑자기 울컥하게 만들었다. 괜히 혼잣말로 \“아버지, 보고 싶어요\”를 중얼거리며 눈물이 터져 나왔다. 하루를 시작하기도 전에 눈이 빨개진 채로 거울 앞에 서니, 견디기가 버거웠다.\n\n출근길 지하철 안에서도 마음을 추스르지 못했다. 억눌러보려 했지만, 눈물이 자꾸 흘러내려 결국 얼굴을 가리며 소리 없는 울음을 삼켰다. 주위 사람들이 이상하게 볼까 두려웠지만, 그 순간에는 그냥 멈출 수가 없었다. 감정을 드러내는 게 부끄럽다기보다는, 차라리 이렇게 쏟아내야만 버틸 수 있을 것 같았다.\n\n퇴근 후 집에 돌아와 아버지 사진을 바라보다가, 결국 큰 소리로 울어버렸다. 하지만 다 울고 난 뒤에는 신기하게도 가슴이 조금은 가벼워진 것 같았다. 아버지를 잊을 수는 없겠지만, 이렇게라도 내 감정을 솔직하게 표출하는 게 지금의 나를 살게 하는 방법이라는 걸 오늘 깨달았다.',
    },
  ];

  // void _onItemTapped(int index) {
  //   // setState(() {
  //   //   _selectedIndex = index; // 선택된 인덱스를 업데이트합니다.
  //   // });
  //   Get.back();
  //   //Get.off(() => Homescreen(selectedIndex: _selectedIndex));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF111111),
                  border: Border(
                    bottom: BorderSide(color: const Color(0xFF232529)),
                  ),
                ),
                child: Column(
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
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(),
                                child: IconButton(
                                  icon: Image.asset('image/arrow-left.png'),
                                  onPressed: () {
                                    Get.back();
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 180, 0),
                              child: Container(
                                child: Text(
                                  '홈 화면',
                                  style: TextStyle(
                                    color: const Color(0xFFBDC7DB),
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
                            padding: const EdgeInsets.fromLTRB(26, 0, 0, 0),
                            child: Text(
                              '오늘도, 이별 나누기',
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
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(26, 0, 0, 0),
                            child: Container(
                              child: Text(
                                '나와 유사한 이별을 한, 나와 비슷한 사람들의 이별일기',
                                style: TextStyle(
                                  color: const Color(0xFFBDC7DB),
                                  fontSize: 14,
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

                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: Container(
                        height: 30.0,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(right: 6.0),
                          itemCount: categoryData.length,
                          itemBuilder: (context, index) {
                            return _buildCategoryCard(index);
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),

              SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                      child: Container(
                        width: 348,
                        height: 70,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 0,
                          vertical: 12,
                        ),
                        decoration: ShapeDecoration(
                          color: const Color(0xFF1F2124),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                      20,
                                      0,
                                      0,
                                      0,
                                    ),
                                    child: Text(
                                      '지금 나의 이별을 나누고 1&을 받아가세요',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w600,
                                        height: 1.40,
                                        letterSpacing: -0.40,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                      20,
                                      0,
                                      0,
                                      0,
                                    ),
                                    child: Container(
                                      child: Text(
                                        '나의 이별 일기 보러가기',
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
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              if (_selectedOption == '작성일 순') ...[
                Container(
                  height: 360.0,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.only(right: 6.0),
                    itemCount: _allDiaryData.length,
                    itemBuilder: (context, index) {
                      return _buildDiaryCard(index);
                    },
                  ),
                ),
              ],
              if (_selectedOption == '이별상대') ...[
                Container(
                  height: 330.0,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.only(right: 6.0),
                    itemCount: _allDiaryData.length,
                    itemBuilder: (context, index) {
                      if (_allDiaryData[index]['_subject'] ==
                          lossCaseController.subject.value) {
                        return _buildDiaryCard(index);
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ],
              if (_selectedOption == '이별대처유형') ...[
                Container(
                  height: 330.0,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.only(right: 6.0),
                    itemCount: _allDiaryData.length,
                    itemBuilder: (context, index) {
                      if (_allDiaryData[index]['_copeWay'] ==
                          lossCaseController.copeWay.value) {
                        return _buildDiaryCard(index);
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ],
              if (_selectedOption == '이별공감') ...[
                if (cardController.favoriteCount == 0) ...[
                  Container(
                    height: 330.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Icon(
                            Icons.face,
                            color: const Color(0xFF7F8694),
                          ),
                        ),
                        Center(
                          child: Text(
                            '아직 이별공감한\n이별 일기가 없어요',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFF7F8694),
                              fontSize: 16,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              height: 1.40,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                Container(
                  height: 330.0,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.only(right: 6.0),
                    itemCount: _allDiaryData.length,
                    itemBuilder: (context, index) {
                      if (cardController.isFavorite(index)) {
                        return _buildDiaryCard(index);
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ],
              if (_selectedOption == '스크랩') ...[
                if (cardController.bookmarkedCount == 0) ...[
                  Container(
                    height: 330.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Icon(
                            Icons.face,
                            color: const Color(0xFF7F8694),
                          ),
                        ),
                        Center(
                          child: Text(
                            '아직 스크랩한\n이별 일기가 없어요',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: const Color(0xFF7F8694),
                              fontSize: 16,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              height: 1.40,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                Container(
                  height: 330.0,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.only(right: 6.0),
                    itemCount: _allDiaryData.length,
                    itemBuilder: (context, index) {
                      if (cardController.isBookmarked(index)) {
                        return _buildDiaryCard(index);
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              ],
            ],
          ),
        ),
      ),

      floatingActionButton: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: EdgeInsets.only(
          left: _isExpanded ? 20 : 0,
          right: _isExpanded ? 00 : 0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              backgroundColor: const Color(0xFF111111),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              onPressed: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Icon(Icons.add, color: const Color(0xFFFFFFFF), size: 30),
            ),
            if (_isExpanded) ...[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2D31),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Row(
                  children: [
                    TextButton(
                      child: Text(
                        '일기쓰기',
                        style: TextStyle(
                          color: const Color(0xFFFFFFFF),
                          fontSize: 12,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                          height: 1.40,
                        ),
                      ),
                      onPressed: () {
                        Get.off(
                          FarewellDiaryScreen(),
                          transition: Transition.fade,
                        );
                      },
                    ),
                    SizedBox(width: 12),
                    TextButton(
                      child: Text(
                        '일기등록',
                        style: TextStyle(
                          color: const Color(0xFFFFFFFF),
                          fontSize: 12,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                          height: 1.40,
                        ),
                      ),
                      onPressed: () {
                        Get.off(
                          FarewellDiaryScreen(),
                          transition: Transition.fade,
                        );
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(width: 12),
            ],
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

  Widget _buildCategoryCard(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_selectedOption == categoryData[index]) {
            _selectedOption = null;
          } else {
            _selectedOption = categoryData[index];
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          decoration: BoxDecoration(
            color: _selectedOption == categoryData[index]
                ? const Color(0xFF2A2D31)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: _selectedOption == categoryData[index]
                  ? const Color(0xFF65A0FF) //선택하면 배경 테두리 바뀌게 하는 부분
                  : Colors.transparent,
              // color: Colors.transparent,
              width: 2,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 8,
            children: [
              Text(
                categoryData[index],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                  height: 1.40,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDiaryCard(int index) {
    final data = _allDiaryData[index % _allDiaryData.length];

    return GestureDetector(
      onTap: () {
        Get.to(
          () => DiaryDetailScreen(diaryData: data, index: index),
          transition: Transition.fade,
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          height: 280.0,
          //margin: EdgeInsets.only(right: 8.0),
          child: Stack(
            children: [
              // 배경 이미지
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  image: DecorationImage(
                    image: data['backgroundImage'].startsWith('image/')
                        ? AssetImage(data['backgroundImage'])
                        : FileImage(File(data['backgroundImage']))
                              as ImageProvider,
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withValues(alpha: 0.5), // 수치 높일수록 더 어두워짐
                      BlendMode.multiply, // 또는 BlendMode.darken
                    ),
                  ),
                ),
              ),

              // 그라데이션 오버레이 (텍스트 가독성을 위해)
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.7),
                    ],
                  ),
                ),
              ),

              // 카드 내용
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 상단: 프로필과 북마크
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // 프로필 정보
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 16.0,
                              //backgroundImage: AssetImage(data['profileImage']),
                              child: Icon(
                                Icons.person,
                                color: const Color(0xFF7F8694),
                                size: 25,
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              data['userName'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w600,
                                height: 1.40,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(width: 135.0),

                        Row(
                          children: [
                            Obx(
                              () => GestureDetector(
                                onTap: () {
                                  // CardController를 사용하여 북마크 상태 토글 (카드 데이터와 함께)
                                  cardController.toggleFavorite(index, data);
                                },
                                child: Icon(
                                  cardController.isFavorite(index)
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: cardController.isFavorite(index)
                                      ? Colors.red
                                      : Color(0xFFB8BFCC),
                                  size: 24.0,
                                ),
                              ),
                            ),
                            SizedBox(width: 20.0),

                            // 북마크 아이콘
                            Obx(
                              () => GestureDetector(
                                onTap: () {
                                  // CardController를 사용하여 북마크 상태 토글 (카드 데이터와 함께)
                                  cardController.toggleBookmark(index, data);
                                },
                                child: Icon(
                                  cardController.isBookmarked(index)
                                      ? Icons.bookmark
                                      : Icons.bookmark_border,
                                  color: cardController.isBookmarked(index)
                                      ? Colors.amber
                                      : Color(0xFFB8BFCC),
                                  size: 24.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    Spacer(),

                    // 중앙: 날짜
                    Text(
                      data['date'],
                      style: TextStyle(
                        color: const Color(0xFFBDC7DB),
                        fontSize: 14,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                        height: 1.40,
                      ),
                    ),

                    SizedBox(height: 8.0),

                    // 하단: 일기 제목
                    Text(
                      data['title'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        height: 1.40,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    SizedBox(height: 12.0),

                    // 해시태그
                    Wrap(
                      spacing: 6.0,
                      runSpacing: 4.0,
                      children: data['hashtags'].map<Widget>((tag) {
                        return Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 4.0,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFF111111),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Text(
                            tag,
                            style: TextStyle(
                              color: const Color(0xFF65A0FF),
                              fontSize: 12,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              height: 1.40,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 12.0),

                    Text(
                      data['content'],
                      style: TextStyle(
                        color: const Color(0xFFBDC7DB),
                        fontSize: 14,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        height: 1.40,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
