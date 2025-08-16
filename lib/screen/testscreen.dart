import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'homescreen.dart';

class Testscreen extends StatefulWidget {
  const Testscreen({super.key});

  @override
  State<Testscreen> createState() => _TestscreenState();
}

class _TestscreenState extends State<Testscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('사전 테스트')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.to(() => Homescreen());
          },
          child: Text('홈화면 으로'),
        ),
      ),
    );
  }
}
