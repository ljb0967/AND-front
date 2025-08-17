import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'widget/homeappbarwidget.dart';
import 'chatscreen.dart';
import 'dailyquestionscreen.dart';
import 'farewelldiaryscreen.dart';
import 'farewellshopscreen.dart';
import 'homecontentscreen.dart';

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
    const Homecontentscreen(), // 인덱스 2: 홈 (기존 CustomScrollView 내용)
    const FarewellDiaryScreen(), // 인덱스 3: 이별일기
    const FarewellShopScreen(), // 인덱스 4: 이별상점
  ];

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
