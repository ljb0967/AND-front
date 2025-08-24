import 'package:flutter/material.dart';

class FarewellDiaryScreen extends StatefulWidget {
  const FarewellDiaryScreen({super.key});

  @override
  State<FarewellDiaryScreen> createState() => _FarewellDiaryScreenState();
}

class _FarewellDiaryScreenState extends State<FarewellDiaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF111111),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25.0,
                  vertical: 30.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('image/home_image.png', height: 20),
                    Row(
                      children: [
                        Image.asset('image/Bell.png', height: 30),
                        SizedBox(width: 12),
                        Image.asset('image/GearSix.png', height: 30),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
