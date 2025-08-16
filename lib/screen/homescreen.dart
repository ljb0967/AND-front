import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'widget/homeappbarwidget.dart';
import 'chatscreen.dart';
import 'dailyquestionscreen.dart';
import 'farewelldiaryscreen.dart';
import 'farewellshopscreen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int _selectedIndex = 2;

  final List<Widget> _pages = [
    const ChatScreen(), // 인덱스 0: 대화하기
    const DailyQuestionScreen(), // 인덱스 1: 일일문답
    _HomeScreenContent(), // 인덱스 2: 홈 (기존 CustomScrollView 내용)
    const FarewellDiaryScreen(), // 인덱스 3: 이별일기
    const FarewellShopScreen(), // 인덱스 4: 이별상점
  ];

  static Widget _HomeScreenContent() {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.blue,
          expandedHeight: 320.0,
          pinned: true,
          flexibleSpace: Homeappbarwidget(), // Homeappbarwidget은 기존대로 사용
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Container(
              child: Column(
                children: [Text('바람도 쐴 겸, 이곳은 어때요?'), Text('오늘의 추천 장소 보러가기')],
              ),
              height: 100.0,
            ),
            Container(
              child: Column(
                children: [
                  Text('오늘의 이별 극복 퀘스트'),
                  Text('이별을 혼자서 감당하는 억누르기형을 위한 맞춤 퀘스트'),
                ],
              ),
              height: 100.0,
            ),
            Container(color: Colors.black, height: 200.0),
            Container(color: Colors.blue, height: 200.0),
            Container(color: Colors.yellow, height: 200.0),
            Container(color: Colors.red, height: 200.0),
          ]),
        ),
      ],
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // 선택된 인덱스를 업데이트합니다.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: '대화하기'),
          BottomNavigationBarItem(icon: Icon(Icons.quiz), label: '일일문답'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: '이별일기'),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: '이별상점'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
      ),
    );
  }
}
