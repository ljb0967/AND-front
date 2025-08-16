import 'package:flutter/material.dart';

class FarewellShopScreen extends StatelessWidget {
  const FarewellShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('이별상점')),
      body: const Center(
        child: Text('이별상점 페이지 내용', style: TextStyle(color: Colors.white)),
      ),
      backgroundColor: Colors.black,
    );
  }
}
