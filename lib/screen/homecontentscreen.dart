import 'package:flutter/material.dart';
import 'homeappbarwidget.dart';
import 'package:get/get.dart';
import 'homediaryscreen.dart';
import '../state/loss_case_controller.dart';
import '../state/user_controller.dart';
import '../state/card_controller.dart';
import 'chatscreen.dart';
import 'dailyquestionscreen.dart';
import 'farewelldiaryscreen.dart';
import 'farewellshopscreen.dart';
import 'diary_detail_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class Homecontentscreen extends StatefulWidget {
  const Homecontentscreen({super.key});

  @override
  State<Homecontentscreen> createState() => _HomecontentscreenState();
}

class _HomecontentscreenState extends State<Homecontentscreen> {
  int _selectedIndex = 2;
  final UserController userController = Get.find<UserController>();
  final LossCaseController lossCaseController = Get.find<LossCaseController>();
  final CardController cardController = Get.find<CardController>();

  // 동적으로 로드된 사용자 등록 일기 데이터
  List<Map<String, dynamic>> _dynamicDiaryData = [];
  bool _isDataLoaded = false;

  final List<Map<String, dynamic>> diaryData = [
    {
      'profileImage': 'image/character1.png',
      'userName': '익명의 작성자',
      'subject': 'FAMILY',
      'date': '2025.08.04',
      'title': '그냥, 나가서 온몸으로 비맞은 날',
      'hashtags': ['#가족이별', '#억누르기형'],
      'backgroundImage': 'image/diary1.jpg',
      'isBookmarked': false,
      'content':
          '창밖을 보니 정말 오랜만에 비가 오고 있었다. 이유는 잘 모르겠지만, 밖으로 나가야만 할 것 같았다. 우산도 쓰지 않은 채 비를 맞으니 그간 쌓여 있던 무언가가 밖으로 터져나오는 것만 같았다. 너무나 보고 싶은 내 동생, 이 고통스러운 마음이 비와 함께 씻겨 내려갔으면 좋겠다고 생각했다.\n\n반쯤 미친 사람처럼 온몸이 젖은 채 집에 들어와 따뜻하게 샤워를 하고, 차 한 잔을 들고 소파에 앉으니 자연스레 깊은 생각에 잠겼다. 오늘 아침에도 평소처럼 앱을 열어 퀘스트를 확인했는데, \‘1시간 이상 바깥 공기 쐬고 오기\’가 있었다. 밖에는 비가 많이 내리고 있었기에 평소 같았으면 고민조차 하지 않았을 외출이지만, 그동안 억눌린 감정들과 더 이상 억누르고 살고 싶지 않다는 마음이 합쳐져 나를 계획도 없이 밖으로 나가게 한 것 같다. 일단 하고 싶은 대로 하고 나니 뭔가 후련한 것 같기도 했다. 이렇게 마음 놓고 울어본 것도 처음이지 싶었다.\n\n물론 여전히 사랑하는 내 동생이 너무나 보고 싶지만, 이제는 나 자신도 아껴야겠다는 생각이 든다. 짧은 시간 동안 많은 것을 겪고 또 생각하게 된 하루였다. 오늘은 조금은 다른 기분으로 잠들 수 있을 것 같은 느낌이다.',
    },
    {
      'profileImage': 'image/character2.png',
      'userName': '익명의 작성자',
      'subject': 'FAMILY',
      'date': '2025.08.04',
      'title': '엄마의 머그컵 앞에서 멈춘 하루',
      'hashtags': ['#가족이별', '#억누르기형'],
      'backgroundImage': 'image/diary2.jpg',
      'isBookmarked': true,
      'content':
          '아침에 서둘러 출근 준비를 하다가, 주방 선반에 올려둔 엄마의 머그컵을 발견했다. 별것 아닌 물건인데도 눈길이 오래 머물렀다. 차를 우려 담으려다 결국 멈칫하며 컵을 다시 제자리에 두었다. 그 순간 마음속에서 무언가 울컥 치밀어올랐지만, 그대로 두면 회사에서 하루를 버티기 힘들 것 같아 애써 무표정으로 돌아섰다. 출근길 지하철에서도 평소처럼 이어폰을 꽂고 눈을 감은 채 아무 일도 없는 듯 시간을 흘려보냈다.\n\n오후에 팀 회의 중 점심 메뉴를 정하는데, 동료가 가볍게 \“엄마랑 자주 먹던 건 뭐야?\” 하고 물었다. 갑작스런 질문에 숨이 막히는 것 같았지만, 곧장 다른 메뉴를 추천하며 아무렇지 않은 듯 웃었다. 대화는 이어졌지만, 속으로는 차갑게 얼어붙은 기분이었다. 내가 억지로 감정을 밀어내고 있다는 걸 알면서도, 이렇게 하지 않으면 하루를 버티기 어렵다는 생각에 스스로를 달랬다.\n\n퇴근길에는 괜히 평소보다 두 정거장 일찍 내려 걸었다. 바람이 얼굴을 스치자 문득 엄마가 내게 \“힘들 땐 그냥 숨 크게 쉬어봐\”라고 했던 말씀이 떠올랐다. 조심스레 깊게 들이마시고 내쉬자, 정말 오랜만에 가슴이 조금은 편안해지는 듯했다. 여전히 그리움은 날카롭게 남아 있었지만, 그 순간만큼은 나 자신을 위해 살아가야겠다는 생각이 스쳤다. 작은 숨 한 번이 이렇게 위로가 될 줄은 몰랐다.',
    },
    {
      'profileImage': 'image/character4.png',
      'userName': '익명의 작성자',
      'subject': 'FAMILY',
      'date': '2025.08.03',
      'title': '울음을 터뜨린 뒤 찾아온 가벼움',
      'hashtags': ['#가족이별', '#표출형'],
      'backgroundImage': 'image/diary3.jpg',
      'isBookmarked': true,
      'content':
          '오늘 아침, 창밖에서 들려오는 새소리가 유난히 낯설게 들렸다. 평소 같으면 아버지께서 먼저 일어나 창문을 열곤 하셨는데, 그 소리가 더 이상 들리지 않는다는 사실이 날 갑자기 울컥하게 만들었다. 괜히 혼잣말로 \“아버지, 보고 싶어요\”를 중얼거리며 눈물이 터져 나왔다. 하루를 시작하기도 전에 눈이 빨개진 채로 거울 앞에 서니, 견디기가 버거웠다.\n\n출근길 지하철 안에서도 마음을 추스르지 못했다. 억눌러보려 했지만, 눈물이 자꾸 흘러내려 결국 얼굴을 가리며 소리 없는 울음을 삼켰다. 주위 사람들이 이상하게 볼까 두려웠지만, 그 순간에는 그냥 멈출 수가 없었다. 감정을 드러내는 게 부끄럽다기보다는, 차라리 이렇게 쏟아내야만 버틸 수 있을 것 같았다.\n\n퇴근 후 집에 돌아와 아버지 사진을 바라보다가, 결국 큰 소리로 울어버렸다. 하지만 다 울고 난 뒤에는 신기하게도 가슴이 조금은 가벼워진 것 같았다. 아버지를 잊을 수는 없겠지만, 이렇게라도 내 감정을 솔직하게 표출하는 게 지금의 나를 살게 하는 방법이라는 걸 오늘 깨달았다.',
    },
    {
      'profileImage': 'image/character5.png',
      'userName': '새로운시작',
      'subject': 'FAMILY',
      'date': '2025.08.27',
      'title': '새로운 취미를 찾았어요',
      'hashtags': ['#가족이별', '#AND+15'],
      'backgroundImage': 'image/diary4.jpg',
      'isBookmarked': false,
      'content':
          '오늘 앱을 켜니까 퀘스트에 \‘함께한 추억이 담긴 기록 살펴보기\'가 있더라구요... 그이가 떠난 후로 한 번도 열어본 적 없었던 사진첩을 이참에 열어봐야겠다 싶어 이곳저곳을 뒤져 찾아냈네요... 그냥 슬프기만 할 줄 알았는데 보다보니 저도 모르게 미소를 짓고 있네요 ㅎㅎ... 참 많이 보고싶네요...',
    },
  ];

  final List<Widget> _pages = [
    const ChatScreen(), // 인덱스 0: 대화하기
    const DailyQuestionScreen(), // 인덱스 1: 일일문답
    const Homecontentscreen(), // 인덱스 2: 홈 (기존 CustomScrollView 내용)
    const FarewellDiaryScreen(), // 인덱스 3: 이별일기
    const FarewellShopScreen(), // 인덱스 4: 이별상점
  ];

  @override
  void dispose() {
    // GetX 컨트롤러 정리 (permanent로 등록된 컨트롤러는 자동으로 정리됨)
    // 필요시 추가 정리 로직 구현

    super.dispose();
  }

  // SharedPreferences에서 사용자 등록 일기 데이터 로드
  Future<void> _loadUserDiaries() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final homeDiariesJson = prefs.getString('homeDiaries') ?? '[]';
      final List<dynamic> homeDiaries = json.decode(homeDiariesJson);

      setState(() {
        _dynamicDiaryData = List<Map<String, dynamic>>.from(homeDiaries);
        _isDataLoaded = true;
      });

      //print('사용자 일기 데이터 로드 완료: ${_dynamicDiaryData.length}개');
    } catch (e) {
      //print('사용자 일기 데이터 로드 오류: $e');
      setState(() {
        _isDataLoaded = true;
      });
    }
  }

  // 현재 표시할 일기 데이터 (하드코딩된 데이터 + 사용자 등록 데이터)
  List<Map<String, dynamic>> get _allDiaryData {
    final List<Map<String, dynamic>> allData = [];

    // 하드코딩된 기본 데이터 추가
    allData.addAll(diaryData);

    // 사용자가 등록한 데이터 추가 (중복 제거)
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

  Future<void> _getquest() async {
    if (userController.quest1.value != '') {
      return;
    }

    final id = lossCaseController.lossCaseId.value;
    //final uri = Uri.parse('http://10.0.2.2:8080/quests');
    final uri = Uri.parse('https://and-backend.onrender.com/quests');

    final body = {
      'lossCaseId': id,
      'subject': lossCaseController.subject.value,
      'copeWay': lossCaseController.copeWay.value,
    };

    final response = await http.post(
      uri,
      headers: userController.getAuthHeaders(),
      body: json.encode(body),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      //print('quest 데이터 불러오기 성공: ${response.body}');
      userController.setquest1(data[0]['text'].toString());
      userController.setquest2(data[1]['text'].toString());
      userController.setquest3(data[2]['text'].toString());

      setState(() {}); // UI 갱신
    }
  }

  //// quest patch 연결 함수

  void _onItemTapped(int index) {
    // 현재 화면과 같은 화면을 선택한 경우 navigation하지 않음
    if (index == _selectedIndex) return;

    setState(() {
      _selectedIndex = index; // 선택된 인덱스를 업데이트합니다.
    });

    // 다른 화면으로 이동할 때만 navigation
    if (index != 2) {
      Get.off(_pages[index], transition: Transition.fade);
    }
  }

  String copeWay = Get.find<LossCaseController>().copeWay.value;
  String CopeWay2 = '';
  String text = '';

  void _getCopeWay2(String copeWay) {
    if (copeWay == "SUPPRESS") {
      CopeWay2 = "억누르기";
      text = "이별을 혼자서 감당하는";
    } else if (copeWay == "EXPRESS") {
      CopeWay2 = "표출";
      text = "감정을 적극적으로 표현하는";
    } else if (copeWay == "AVOID") {
      CopeWay2 = "회피";
      text = "감정 외적인 것에 집중하는";
    } else if (copeWay == "ANALYZE") {
      CopeWay2 = "분석";
      text = "이별의 원인을 이해하려하는";
    }
  }

  bool _visible1 = false;
  bool _visible2 = false;

  @override
  final List<bool> _checklistStates = [false, false, false];

  Widget _buildChecklistItem(int index, String text) {
    _checklistStates[index] = userController.questComplete[index].value;
    return InkWell(
      // 텍스트 영역을 탭 가능하게 만듭니다.
      onTap: () {
        setState(() {
          _checklistStates[index] = !_checklistStates[index];
          userController.setquestComplete(
            index,
            _checklistStates[index],
          ); // 상태 토글
        });
      },
      child: Row(
        children: [
          Icon(
            _checklistStates[index]
                ? Icons.check_box
                : Icons.check_box_outline_blank,
            color: _checklistStates[index]
                ? Color(0xFF66A1FF)
                : Color(0xFFB8BFCC),
            size: 24.0,
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Pretendard',
                fontWeight: FontWeight.w500,
                height: 1.40,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _loadUserDiaries();
    _getquest();
    _getCopeWay2(copeWay);

    // 시간차로 순차적으로 위젯 보이기
    Future.delayed(const Duration(milliseconds: 600), () {
      setState(() => _visible1 = true);
    });
    Future.delayed(const Duration(milliseconds: 1200), () {
      setState(() => _visible2 = true);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 화면이 다시 포커스될 때 데이터 새로고침
    _loadUserDiaries();
  }

  Widget build(BuildContext context) {
    final int completedCount = _checklistStates.where((state) => state).length;
    final double progress = _checklistStates.isEmpty
        ? 0.0
        : completedCount / _checklistStates.length;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 250.0,
        flexibleSpace: FlexibleSpaceBar(background: Homeappbarwidget()),
      ),
      body: CustomScrollView(
        slivers: [
          // SliverAppBar(
          //   backgroundColor: Colors.black,
          //   expandedHeight: 250.0,
          //   // pinned: true,
          //   flexibleSpace: FlexibleSpaceBar(
          //     background: Homeappbarwidget(),
          //   ), // Homeappbarwidget은 기존대로 사용
          // ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 20.0),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Container(
                        // 부모 너비 전체 사용
                        height: 80.0, // 높이 136px (제공된 레이아웃 정보)
                        padding: const EdgeInsets.fromLTRB(
                          16.0,
                          12.0,
                          16.0,
                          12.0,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1F2124), // 배경색 #1F2124
                          borderRadius: BorderRadius.circular(
                            10.0,
                          ), // 반경 10px (모서리 둥글게)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '바람도 쐴 겸, 이곳은 어때요?',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w600,
                                height: 1.40,
                                letterSpacing: -0.40,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              '오늘의 추천 장소 보러가기',
                              style: TextStyle(
                                color: const Color(0xFFB8BFCC),
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
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 2.0),

              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: Container(
                        padding: const EdgeInsets.all(16.0), // 내부 패딩
                        color: Colors.black,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '오늘의 이별 극복 퀘스트',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w600,
                                    height: 1.40,
                                  ),
                                ),
                                if (copeWay == "SUPPRESS")
                                  Image.asset(
                                    'image/character1.png',
                                    height: 25,
                                  ),
                                if (copeWay == "ANALYZE")
                                  Image.asset(
                                    'image/character1-1.png',
                                    height: 25,
                                  ),
                                if (copeWay == "EXPRESS")
                                  Image.asset(
                                    'image/character1-3.png',
                                    height: 25,
                                  ),
                                if (copeWay == "AVOID")
                                  Image.asset(
                                    'image/character1-2.png',
                                    height: 25,
                                  ),
                              ],
                            ),
                            SizedBox(height: 8.0),

                            Text(
                              '${text} ${CopeWay2}형을 위한 맞춤 퀘스트', //<---- API
                              style: TextStyle(
                                color: const Color(0xFFB8BFCC),
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
                  ),
                ],
              ),

              AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: _visible1 ? 1.0 : 0.0,
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(
                          12.0,
                          10.0,
                          12.0,
                          10.0,
                        ), // 상단/하단 여백 20px 추가
                        child: Container(
                          //width: double.infinity, // 부모 너비 전체 사용
                          height: 140.0, // 높이 136px (제공된 레이아웃 정보)
                          padding: const EdgeInsets.all(16.0), // 내부 패딩 16px
                          decoration: BoxDecoration(
                            color: const Color(0xFF1F2124), // 배경색 #1F2124
                            borderRadius: BorderRadius.circular(
                              10.0,
                            ), // 반경 10px
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start, // api
                            children: [
                              _buildChecklistItem(
                                0,
                                userController.quest1.value,
                              ),
                              const SizedBox(height: 8.0),
                              _buildChecklistItem(
                                1,
                                userController.quest2.value,
                              ),
                              const SizedBox(height: 8.0),
                              _buildChecklistItem(
                                2,
                                userController.quest3.value,
                              ),
                              const Spacer(), // 남은 공간을 채워 프로그레스 바를 아래로 밀어냄
                              // 프로그레스 바
                              AnimatedOpacity(
                                duration: const Duration(milliseconds: 500),
                                opacity: _visible2 ? 1.0 : 0.0,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: LinearProgressIndicator(
                                        value: progress, // 33.3% 진행률
                                        backgroundColor: Colors.grey[700],
                                        valueColor:
                                            const AlwaysStoppedAnimation<Color>(
                                              Color(0xFF65A0FF),
                                            ), // 진행바 색상
                                        minHeight: 4.0, // 진행바 높이
                                      ),
                                    ),
                                    const SizedBox(width: 8.0),
                                    Text(
                                      '${(progress * 100).toStringAsFixed(1)}%',
                                      style: TextStyle(
                                        color: const Color(0xFF65A0FF),
                                        fontSize: 12,
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
                    ),
                  ],
                ), // 첫 번째 위젯
              ),

              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(26, 0, 8, 0),
                      child: Container(
                        //padding: const EdgeInsets.all(16.0), // 내부 패딩
                        color: Colors.black,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '오늘도, 이별 나누기',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w600,
                                    height: 1.40,
                                  ),
                                ),
                                Container(
                                  child: TextButton(
                                    onPressed: () {
                                      Get.to(
                                        () => const Homediaryscreen(),
                                        transition: Transition.fade,
                                      );
                                    }, // ---> 일기 공유 커뮤니티로
                                    style: ButtonStyle(
                                      backgroundColor:
                                          WidgetStateProperty.all<Color>(
                                            const Color(0xFF1F2124),
                                          ),
                                    ),
                                    child: Text(
                                      '더보기',
                                      //textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w500,
                                        height: 1.40,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 2.0),
                            Text(
                              '나와 유사한 이별을 한, 나와 비슷한 사람들의 이별일기',
                              style: TextStyle(
                                color: const Color(0xFFB8BFCC),
                                fontSize: 14,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w500,
                                height: 1.40,
                              ),
                            ),
                            SizedBox(height: 20.0),

                            // 일기 카드 가로 스크롤뷰
                            Container(
                              height: 200.0,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.only(right: 6.0),
                                itemCount: _allDiaryData.length, // 일기 카드 개수
                                itemBuilder: (context, index) {
                                  return _buildDiaryCard(index);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              //Container(color: Colors.white, height: 200.0),
            ]),
          ),
        ],
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

  // 일기 카드 위젯 생성
  Widget _buildDiaryCard(int index) {
    // 샘플 데이터 (실제로는 API에서 가져올 데이터)

    final data = _allDiaryData[index % _allDiaryData.length];

    return GestureDetector(
      onTap: () {
        Get.to(
          () => DiaryDetailScreen(diaryData: data, index: index),
          transition: Transition.fade,
        );
      },
      child: Container(
        width: 270.0,
        margin: EdgeInsets.only(right: 8.0),
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

                  Spacer(),

                  // 중앙: 날짜
                  Text(
                    data['date'],
                    style: TextStyle(
                      color: const Color(0xFFB8BFCC),
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
                  // SizedBox(height: 12.0),

                  // Text(
                  //   data['content'],
                  //   style: TextStyle(
                  //     color: const Color(0xFFB8BFCC),
                  //     fontSize: 12,
                  //     fontFamily: 'Pretendard',
                  //     fontWeight: FontWeight.w500,
                  //     height: 1.40,
                  //   ),
                  //   maxLines: 2,
                  //   overflow: TextOverflow.ellipsis,
                  //                 ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
