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
                  '2025년 8월 31일 (일)', // <---------api
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
