import 'package:flutter/material.dart';
import 'package:test1/screen/intro_screen.dart';
import 'package:get/get.dart';
import 'package:test1/state/user_controller.dart';
import 'package:test1/state/loss_case_controller.dart';

void main() {
  // UserController와 LossCaseController 초기화
  Get.put(UserController());
  Get.put(LossCaseController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AND',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: 'Pretendard',
        useMaterial3: true,
      ),
      home: const IntroScreen(),
    );
  }
}
