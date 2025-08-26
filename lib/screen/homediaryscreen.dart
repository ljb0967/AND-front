import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'homescreen.dart';
import 'chatscreen.dart';
import 'dailyquestionscreen.dart';
import 'farewelldiaryscreen.dart';
import 'farewellshopscreen.dart';

class Homediaryscreen extends StatefulWidget {
  const Homediaryscreen({super.key});

  @override
  State<Homediaryscreen> createState() => _HomediaryscreenState();
}

class _HomediaryscreenState extends State<Homediaryscreen> {
  final List<String> categoryData = ['작성일 순', '이별상대', '이별대처유형', '이별공감', '스크랩'];
  String? _selectedOption = '작성일 순';
  int _selectedIndex = 2;
  bool _isExpanded = false; // 플로팅 버튼 확장 상태
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
                              padding: const EdgeInsets.fromLTRB(0, 0, 140, 0),
                              child: Container(
                                child: Text(
                                  '홈 화면',
                                  style: TextStyle(
                                    color: Colors.white,
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
                  height: 330.0,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.only(right: 6.0),
                    itemCount: diaryData.length,
                    itemBuilder: (context, index) {
                      return _buildDiaryCard(index);
                    },
                  ),
                ),
              ],
              if (_selectedOption == '이별상대') ...[],
              if (_selectedOption == '이별대처유형') ...[],
              if (_selectedOption == '이별공감') ...[
                Container(
                  height: 330.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Icon(Icons.face, color: const Color(0xFF7F8694)),
                      ),
                      Center(
                        child: Text(
                          '아직 이별 공감한\n이별 일기가 없어요',
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
              if (_selectedOption == '스크랩') ...[
                Container(
                  height: 330.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Icon(Icons.face, color: const Color(0xFF7F8694)),
                      ),
                      Center(
                        child: Text(
                          '아직 이별 공감한\n이별 일기가 없어요',
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
                      onPressed: () {},
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
                      onPressed: () {},
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
        //onTap: _onItemTapped,
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
    final data = diaryData[index % diaryData.length];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        height: 230.0,
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

                      SizedBox(width: 155.0),

                      GestureDetector(
                        onTap: () {
                          // 북마크 토글 기능 (실제로는 상태 관리 필요)
                          setState(() {
                            // 여기서 북마크 상태를 토글할 수 있습니다
                          });
                        },
                        child: Icon(
                          data['isBookmarked']
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Color(0xFFB8BFCC),
                          size: 20.0,
                        ),
                      ),
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
    );
  }
}
