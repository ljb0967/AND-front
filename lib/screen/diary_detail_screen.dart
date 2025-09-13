import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test1/state/card_controller.dart';
import 'package:test1/screen/chatscreen.dart';
import 'package:test1/screen/dailyquestionscreen.dart';
import 'package:test1/screen/homecontentscreen.dart';
import 'package:test1/screen/farewelldiaryscreen.dart';
import 'package:test1/screen/farewellshopscreen.dart';
import 'dart:io';

class DiaryDetailScreen extends StatefulWidget {
  final Map<String, dynamic> diaryData;
  final int index;

  const DiaryDetailScreen({
    super.key,
    required this.diaryData,
    required this.index,
  });

  @override
  State<DiaryDetailScreen> createState() => _DiaryDetailScreenState();
}

class _DiaryDetailScreenState extends State<DiaryDetailScreen> {
  int _selectedIndex = 2;
  final CardController cardController = Get.find<CardController>();
  bool _isExpanded = false;

  final List<Widget> _pages = [
    const ChatScreen(), // 인덱스 0: 대화하기
    const DailyQuestionScreen(), // 인덱스 1: 일일문답
    const Homecontentscreen(), // 인덱스 2: 홈 (기존 CustomScrollView 내용)
    const FarewellDiaryScreen(), // 인덱스 3: 이별일기
    const FarewellShopScreen(), // 인덱스 4: 이별상점
  ];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF111111),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              image: widget.diaryData['backgroundImage'].startsWith('image/')
                  ? DecorationImage(
                      image: AssetImage(widget.diaryData['backgroundImage']),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withValues(alpha: 0.5),
                        BlendMode.darken,
                      ),
                    )
                  : DecorationImage(
                      image: FileImage(
                        File(widget.diaryData['backgroundImage']),
                      ),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withValues(alpha: 0.5),
                        BlendMode.darken,
                      ),
                    ),
            ),
            child: Column(
              children: [
                // 상단 앱 바
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(25, 30, 25, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Image.asset('image/arrow-left.png'),
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

                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 30, 25, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                          SizedBox(width: 12),
                          Text(
                            '익명의 작성자',
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
                      Row(
                        children: [
                          Obx(
                            () => GestureDetector(
                              onTap: () {
                                cardController.toggleFavorite(
                                  widget.index,
                                  widget.diaryData,
                                );
                              },
                              child: Icon(
                                cardController.isFavorite(widget.index)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: cardController.isFavorite(widget.index)
                                    ? Colors.red
                                    : Color(0xFFB8BFCC),
                                size: 24.0,
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Obx(
                            () => GestureDetector(
                              onTap: () {
                                cardController.toggleBookmark(
                                  widget.index,
                                  widget.diaryData,
                                );
                              },
                              child: Icon(
                                cardController.isBookmarked(widget.index)
                                    ? Icons.bookmark
                                    : Icons.bookmark_border,
                                color: cardController.isBookmarked(widget.index)
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
                ),

                // 날짜 및 제목
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 30, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.diaryData['date'],
                            style: TextStyle(
                              color: const Color(0xFFBDC7DB),
                              fontSize: 14,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              height: 1.40,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            widget.diaryData['title'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                              height: 1.40,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // 해시태그
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 0, 10),
                  child: Row(
                    children: widget.diaryData['hashtags'].map<Widget>((tag) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 6.0,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF111111),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Text(
                          tag,
                          style: TextStyle(
                            color: const Color(0xFF65A0FF),
                            fontSize: 14,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            height: 1.40,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 16, 20),
                child: Text(
                  widget.diaryData['content'],
                  style: TextStyle(
                    color: const Color(0xFFBDC7DB),
                    fontSize: 14,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w400,
                    height: 1.40,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      //하단 플로팅 액션 버튼
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
}
