import 'package:flutter/material.dart';
import '../../state/survey_controller.dart';
import '../state/loss_case_controller.dart';
import 'package:get/get.dart';

class Homeappbarwidget extends StatefulWidget {
  const Homeappbarwidget({super.key});

  @override
  State<Homeappbarwidget> createState() => _HomeappbarwidgetState();
}

class _HomeappbarwidgetState extends State<Homeappbarwidget> {
  final LossCaseController lossCaseController = Get.find<LossCaseController>();

  DateTime _selectedDate = Get.find<LossCaseController>().lossDate.value;

  String _todayString() {
    final now = DateTime.now();
    const weekDays = ['월', '화', '수', '목', '금', '토', '일'];
    final weekday = weekDays[now.weekday - 1]; // 1(월)~7(일)
    return '${now.year}년 ${now.month}월 ${now.day}일 ($weekday)';
  }

  int get _elapsedDays {
    if (DateTime.now().difference(_selectedDate).inDays < 0) {
      return 0;
    }
    return DateTime.now().difference(_selectedDate).inDays;
  }

  bool _visible1 = false;
  bool _visible2 = false;

  @override
  void initState() {
    super.initState();

    // 시간차로 순차적으로 위젯 보이기
    Future.delayed(const Duration(milliseconds: 600), () {
      setState(() => _visible1 = true);
    });
    Future.delayed(const Duration(milliseconds: 1200), () {
      setState(() => _visible2 = true);
    });
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
                image: AssetImage('image/ex_photo.png'),
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
                  style: TextStyle(
                    color: const Color(0xFFB8BFCC),
                    fontSize: 14,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500,
                    height: 1.40,
                    letterSpacing: -0.35,
                  ),
                ),
                SizedBox(height: 8),

                AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: _visible1 ? 1.0 : 0.0,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${Get.find<LossCaseController>().name.value} 아, 어서오렴\n오늘은 햇살이 좋은 날이구나', // <---------api
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            height: 1.40,
                            letterSpacing: -0.50,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${Get.find<LossCaseController>().subject.value}', // <---------api
                      style: TextStyle(
                        color: const Color(0xFFB8BFCC),
                        fontSize: 16,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                        height: 1.40,
                        letterSpacing: -0.40,
                      ),
                    ),
                    AnimatedOpacity(
                      duration: const Duration(milliseconds: 500),
                      opacity: _visible2 ? 1.0 : 0.0,
                      child: Text(
                        ('AND+$_elapsedDays'), // AND+경과일
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: const Color(0xFF65A0FF),
                          fontSize: 20,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                          height: 1.40,
                          letterSpacing: -0.50,
                        ),
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
