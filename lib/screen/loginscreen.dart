import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'loginScreen2.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF5FF),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              Text(
                '&',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.blue.shade200,
                  fontWeight: FontWeight.w600,
                  height: 1.0,
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: 240,
                height: 44,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF2E5AAC),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  onPressed: () {
                    Get.to(() => const LoginScreen2());
                    //화면 전환, 뒤로가기 버튼으로 돌아롤 수 있음.
                    // 뒤로가기 없이 화면 전환하려면 -> Get.off(() => Testscreen() )
                    // 이전 화면 모두 제거하고 새 화면으로 -> Get.offAll(() => Testscreen() )
                  },
                  child: const Text(
                    '비회원 로그인',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
