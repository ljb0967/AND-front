import 'package:flutter/material.dart';
import '../../state/survey_controller.dart';

class Homeappbarwidget extends StatefulWidget {
  const Homeappbarwidget({super.key});

  @override
  State<Homeappbarwidget> createState() => _HomeappbarwidgetState();
}

class _HomeappbarwidgetState extends State<Homeappbarwidget> {
  String _todayString() {
    final now = DateTime.now();
    const weekDays = ['월', '화', '수', '목', '금', '토', '일'];
    final weekday = weekDays[now.weekday - 1]; // 1(월)~7(일)
    return '${now.year}년 ${now.month}월 ${now.day}일 ($weekday)';
  }

  String _andDaysText() {
    final breakup = SurveyController.to.breakupDate;
    if (breakup == null) return 'AND+0';
    final today = DateTime.now();
    final diff = today
        .difference(DateTime(breakup.year, breakup.month, breakup.day))
        .inDays;
    final days = diff < 0 ? 0 : diff; // 미래 날짜 방지
    return 'AND+$days';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            height: 350,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20.0),
              ),
              image: DecorationImage(
                image: AssetImage('image/Frame 2.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20.0),
              ),
              child: Opacity(
                opacity: 0.6,
                child: Container(color: Colors.black),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
                vertical: 50.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('image/home_image.png', height: 20),
                  Row(
                    children: [
                      Icon(Icons.notifications_none, color: Colors.white),
                      SizedBox(width: 12),
                      Icon(Icons.settings, color: Colors.white),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 16,
            bottom: 15,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _todayString(), // 동적 현재 날짜
                  style: TextStyle(color: Colors.white70, fontSize: 15),
                ),
                SizedBox(height: 8),
                Expanded(
                  child: Text(
                    '앤디 야,어서오렴\n오늘은 햇살이 좋은 날이구나', // <---------api
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '사랑하는 내 할아버지', // <---------api
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                    Text(
                      _andDaysText(), // AND+경과일
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
