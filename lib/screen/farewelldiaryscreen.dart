import 'package:flutter/material.dart';

class FarewellDiaryScreen extends StatelessWidget {
  const FarewellDiaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('이별일기')),
      body: const Center(
        child: Text('이별일기 페이지 내용', style: TextStyle(color: Colors.white)),
      ),
      backgroundColor: Colors.black,
    );
  }
}
