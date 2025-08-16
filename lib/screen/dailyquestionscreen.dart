import 'package:flutter/material.dart';

class DailyQuestionScreen extends StatelessWidget {
  const DailyQuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('일일문답')),
      body: const Center(
        child: Text('일일문답 페이지 내용', style: TextStyle(color: Colors.white)),
      ),
      backgroundColor: Colors.black,
    );
  }
}
