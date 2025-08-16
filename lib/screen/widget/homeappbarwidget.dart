import 'package:flutter/material.dart';

class Homeappbarwidget extends StatefulWidget {
  const Homeappbarwidget({super.key});

  @override
  State<Homeappbarwidget> createState() => _HomeappbarwidgetState();
}

class _HomeappbarwidgetState extends State<Homeappbarwidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            height: 350,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('image/Frame 2.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 16.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('image/Frame 1.png', height: 60),
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
          Positioned(
            top: 100,
            left: 16,
            bottom: 10,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '2025년 8월 31일 (일)', // <---------api
                  style: TextStyle(color: Colors.white70, fontSize: 15),
                ),
                SizedBox(height: 8),
                Expanded(
                  child: Text(
                    '앤디야,어서오렴\n오늘은 햇살이 좋은 날이구나', // <---------api
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
                      style: TextStyle(color: Colors.white70, fontSize: 20),
                    ),
                    Text(
                      'AND+31', // <---------api
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
