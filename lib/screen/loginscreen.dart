import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'testscreen.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Get.to(() => Testscreen());
            // 화면 전환, 뒤로가기 버튼으로 돌아올 수 있음.
            // 뒤로가기 없이 화면 전환하려면 -> Get.off(() => Testscreen() )
            // 이전 화면 모두 제거하고 새 화면으로 -> Get.offAll(() => Testscreen() )
          },
          child: Text('사전 테스트로 이동'),
        ),
      ),
    );
  }
}
