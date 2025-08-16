import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('대화하기')),
      body: const Center(
        child: Text('대화하기 페이지 내용', style: TextStyle(color: Colors.white)),
      ),
      backgroundColor: Colors.black,
    );
  }
}
