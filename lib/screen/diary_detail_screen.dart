import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test1/screen/homediaryscreen.dart';

class DiaryDetailScreen extends StatefulWidget {
  final Map<String, dynamic> diaryData;

  const DiaryDetailScreen({super.key, required this.diaryData});

  @override
  State<DiaryDetailScreen> createState() => _DiaryDetailScreenState();
}

class _DiaryDetailScreenState extends State<DiaryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF111111),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(widget.diaryData['backgroundImage']),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.3),
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

            // 작성자 정보 및 액션 아이콘
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
                          border: Border.all(
                            color: const Color(0xFF7F8694),
                            width: 2,
                          ),
                        ),
                        child: Icon(
                          Icons.person,
                          color: const Color(0xFF7F8694),
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
                      Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: 16),
                      Icon(
                        Icons.bookmark_border,
                        color: Colors.white,
                        size: 24,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // 날짜 및 제목
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 30, 25, 0),
              child: Column(
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
                  SizedBox(height: 12),
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
            ),

            // 해시태그
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 20, 25, 0),
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
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

            // 일기 본문
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(25, 30, 25, 30),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: SingleChildScrollView(
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
            ),
          ],
        ),
      ),
      // 하단 플로팅 액션 버튼
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: FloatingActionButton(
          backgroundColor: Colors.black.withOpacity(0.7),
          child: Icon(Icons.add, color: Colors.white, size: 24),
          onPressed: () {
            // 추가 기능 구현
          },
        ),
      ),
    );
  }
}
