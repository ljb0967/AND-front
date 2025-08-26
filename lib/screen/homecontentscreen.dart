import 'package:flutter/material.dart';
import 'widget/homeappbarwidget.dart';
import 'package:get/get.dart';
import 'homediaryscreen.dart';

class Homecontentscreen extends StatefulWidget {
  const Homecontentscreen({super.key});

  @override
  State<Homecontentscreen> createState() => _HomecontentscreenState();
}

class _HomecontentscreenState extends State<Homecontentscreen> {
  @override
  final List<bool> _checklistStates = [
    false, // "힘이 되는 사람과 30분 이상 대화하기" (기본적으로 체크됨)
    false, // "1시간 이상 바깥 공기 쐬고 오기"
    false, // "함께한 추억이 담긴 기록 살펴보기"
  ];

  Widget _buildChecklistItem(int index, String text) {
    return InkWell(
      // 텍스트 영역을 탭 가능하게 만듭니다.
      onTap: () {
        setState(() {
          _checklistStates[index] = !_checklistStates[index]; // 상태 토글
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
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                                SizedBox(width: 115.0),
                                Image.asset('image/character1.png', height: 25),
                              ],
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              '이별을 혼자서 감당하는 억누르기형을 위한 맞춤 퀘스트', //<---- API
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

              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                        8.0,
                        10.0,
                        8.0,
                        10.0,
                      ), // 상단/하단 여백 20px 추가
                      child: Container(
                        //width: double.infinity, // 부모 너비 전체 사용
                        height: 140.0, // 높이 136px (제공된 레이아웃 정보)
                        padding: const EdgeInsets.all(16.0), // 내부 패딩 16px
                        decoration: BoxDecoration(
                          color: const Color(0xFF1F2124), // 배경색 #1F2124
                          borderRadius: BorderRadius.circular(10.0), // 반경 10px
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildChecklistItem(0, '힘이 되는 사람과 30분 이상 대화하기'),
                            const SizedBox(height: 8.0),
                            _buildChecklistItem(1, '1시간 이상 바깥 공기 쐬고 오기'),
                            const SizedBox(height: 8.0),
                            _buildChecklistItem(2, '함께한 추억이 담긴 기록 살펴보기'),
                            const Spacer(), // 남은 공간을 채워 프로그레스 바를 아래로 밀어냄
                            // 프로그레스 바
                            Row(
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
                          ],
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
                      padding: const EdgeInsets.symmetric(horizontal: 6.0),
                      child: Container(
                        padding: const EdgeInsets.all(16.0), // 내부 패딩
                        color: Colors.black,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
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
                                SizedBox(width: 110.0),
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
                                itemCount: 5, // 일기 카드 개수
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
    );
  }

  // 일기 카드 위젯 생성
  Widget _buildDiaryCard(int index) {
    // 샘플 데이터 (실제로는 API에서 가져올 데이터)
    final List<Map<String, dynamic>> diaryData = [
      {
        'profileImage': 'image/character1.png',
        'userName': '김디앤',
        'date': '2025.08.30',
        'title': '그냥, 나가서 온몸으로 비맞은 날',
        'hashtags': ['#가족이별', '#억누르기형', '#AND+11'],
        'backgroundImage': 'image/ex_photo.png',
        'isBookmarked': false,
        'content':
            '오늘 앱을 켜니까 퀘스트에 \‘함께한 추억이 담긴 기록 살펴보기\'가 있더라구요... 그이가 떠난 후로 한 번도 열어본 적 없었던 사진첩을 이참에 열어봐야겠다 싶어 이곳저곳을 뒤져 찾아냈네요... 그냥 슬프기만 할 줄 알았는데 보다보니 저도 모르게 미소를 짓고 있네요 ㅎㅎ... 참 많이 보고싶네요...',
      },
      {
        'profileImage': 'image/character2.png',
        'userName': '김디',
        'date': '2025.08.30',
        'title': '일단 냅다 소리',
        'hashtags': ['#반려동물이별'],
        'backgroundImage': 'image/ex_image1.png',
        'isBookmarked': true,
        'content':
            '오늘 앱을 켜니까 퀘스트에 \‘함께한 추억이 담긴 기록 살펴보기\'가 있더라구요... 그이가 떠난 후로 한 번도 열어본 적 없었던 사진첩을 이참에 열어봐야겠다 싶어 이곳저곳을 뒤져 찾아냈네요... 그냥 슬프기만 할 줄 알았는데 보다보니 저도 모르게 미소를 짓고 있네요 ㅎㅎ... 참 많이 보고싶네요...',
      },
      {
        'profileImage': 'image/character3.png',
        'userName': '이별러',
        'date': '2025.08.29',
        'title': '오늘은 조용히 있었어요',
        'hashtags': ['#연인이별', '#AND+5'],
        'backgroundImage': 'image/ex_image2.png',
        'isBookmarked': false,
        'content':
            '오늘 앱을 켜니까 퀘스트에 \‘함께한 추억이 담긴 기록 살펴보기\'가 있더라구요... 그이가 떠난 후로 한 번도 열어본 적 없었던 사진첩을 이참에 열어봐야겠다 싶어 이곳저곳을 뒤져 찾아냈네요... 그냥 슬프기만 할 줄 알았는데 보다보니 저도 모르게 미소를 짓고 있네요 ㅎㅎ... 참 많이 보고싶네요...',
      },
      {
        'profileImage': 'image/character4.png',
        'userName': '힐링중',
        'date': '2025.08.28',
        'title': '친구와 함께한 시간',
        'hashtags': ['#친구이별', '#억누르기형'],
        'backgroundImage': 'image/ex_photo.png',
        'isBookmarked': true,
        'content':
            '오늘 앱을 켜니까 퀘스트에 \‘함께한 추억이 담긴 기록 살펴보기\'가 있더라구요... 그이가 떠난 후로 한 번도 열어본 적 없었던 사진첩을 이참에 열어봐야겠다 싶어 이곳저곳을 뒤져 찾아냈네요... 그냥 슬프기만 할 줄 알았는데 보다보니 저도 모르게 미소를 짓고 있네요 ㅎㅎ... 참 많이 보고싶네요...',
      },
      {
        'profileImage': 'image/character5.png',
        'userName': '새로운시작',
        'date': '2025.08.27',
        'title': '새로운 취미를 찾았어요',
        'hashtags': ['#가족이별', '#AND+15'],
        'backgroundImage': 'image/ex_image1.png',
        'isBookmarked': false,
        'content':
            '오늘 앱을 켜니까 퀘스트에 \‘함께한 추억이 담긴 기록 살펴보기\'가 있더라구요... 그이가 떠난 후로 한 번도 열어본 적 없었던 사진첩을 이참에 열어봐야겠다 싶어 이곳저곳을 뒤져 찾아냈네요... 그냥 슬프기만 할 줄 알았는데 보다보니 저도 모르게 미소를 짓고 있네요 ㅎㅎ... 참 많이 보고싶네요...',
      },
    ];

    final data = diaryData[index % diaryData.length];

    return Container(
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
                image: AssetImage(data['backgroundImage']),
                fit: BoxFit.cover,
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
                colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
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
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 프로필 정보
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 16.0,
                          backgroundImage: AssetImage(data['profileImage']),
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

                    SizedBox(width: 105.0),

                    //좋아요 아이콘
                    // GestureDetector(
                    //   onTap: () {
                    //     // 북마크 토글 기능 (실제로는 상태 관리 필요)
                    //     setState(() {
                    //       // 여기서 북마크 상태를 토글할 수 있습니다
                    //     });
                    //   },
                    //   child: Icon(
                    //     data['isBookmarked']
                    //         ? Icons.favorite
                    //         : Icons.favorite_border,
                    //     color: Color(0xFFB8BFCC),
                    //     size: 20.0,
                    //   ),
                    // ),
                    SizedBox(width: 20.0),

                    // 북마크 아이콘
                    GestureDetector(
                      onTap: () {
                        // 북마크 토글 기능 (실제로는 상태 관리 필요)
                        setState(() {
                          // 여기서 북마크 상태를 토글할 수 있습니다
                        });
                      },
                      child: Icon(
                        data['isBookmarked']
                            ? Icons.bookmark
                            : Icons.bookmark_border,
                        color: Color(0xFFB8BFCC),
                        size: 20.0,
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
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
