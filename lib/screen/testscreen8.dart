import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'homescreen.dart';
import '../state/survey_controller.dart';
import 'testscreen7.dart';
import 'testscreen9.dart';

class Testscreen8 extends StatefulWidget {
  const Testscreen8({super.key});

  @override
  State<Testscreen8> createState() => _Testscreen8State();
}

class _Testscreen8State extends State<Testscreen8> {
  final TextEditingController _toneController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  Future<void> _pickImage() async {
    try {
      print('이미지 선택 시작');

      // 사용자에게 갤러리 또는 카메라 선택 옵션 제공
      final ImageSource? source = await _showImageSourceDialog();
      if (source == null) {
        print('이미지 소스가 선택되지 않음');
        return;
      }

      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      print('선택된 이미지: ${image?.path}');

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
          print('이미지가 성공적으로 선택됨: ${_selectedImage?.path}');
        });
      } else {
        print('이미지가 선택되지 않음');
        // 사용자에게 안내 메시지 표시
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('이미지를 선택해주세요'),
            backgroundColor: Colors.blue,
          ),
        );
      }
    } catch (e) {
      print('이미지 선택 오류: $e');
      // 사용자에게 오류 메시지 표시
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('이미지 선택 중 오류가 발생했습니다: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<ImageSource?> _showImageSourceDialog() async {
    return await showDialog<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('이미지 선택'),
          content: const Text('이미지를 어디서 가져오시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(ImageSource.gallery),
              child: const Text('갤러리'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(ImageSource.camera),
              child: const Text('카메라'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(null),
              child: const Text('취소'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _toneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double screenWidth = constraints.maxWidth;
            const double designWidth = 412.0;
            const double designHeight = 917.0;
            final double scale = screenWidth / designWidth;
            final double scaledHeight = designHeight * scale;

            final Widget scaledContent = FittedBox(
              alignment: Alignment.topLeft,
              fit: BoxFit.fitWidth,
              child: SizedBox(
                width: designWidth,
                height: designHeight,
                child: Container(
                  width: 412,
                  height: 917,
                  clipBehavior: Clip.none,
                  decoration: BoxDecoration(color: const Color(0xFF111111)),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        left: 32,
                        top: 132,
                        child: Text(
                          '이제 마지막이에요\n이별 상대의 대화 방식은 어땠나요?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            height: 1.40,
                            letterSpacing: -0.50,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 32,
                        top: 196,
                        child: Text(
                          '이별 상대의 대화방식을 참고하여 다시 대화할 수 있게 해드릴게요',
                          style: TextStyle(
                            color: const Color(0xFFBDC7DB),
                            fontSize: 14,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            height: 1.40,
                            letterSpacing: -0.35,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        top: 96,
                        child: Container(
                          width: 380,
                          height: 4,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF232529),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        top: 96,
                        child: Container(
                          width: 380,
                          height: 4,
                          decoration: ShapeDecoration(
                            color: const Color(0xFF65A0FF),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 12,
                        top: 28,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // spacing: 1,
                          children: [
                            Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(),
                              child: IconButton(
                                icon: Image.asset('image/arrow-left.png'),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                            ),
                            Text(
                              '테스트 결과 확인',
                              style: TextStyle(
                                color: const Color(0xFFBDC7DB),
                                fontSize: 14,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w500,
                                height: 1.40,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 20,
                        top: 723,
                        child: Container(
                          width: 370,
                          height: 48,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF65A0FF),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'AND 시작하기',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w600,
                                height: 1.40,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            onPressed: () {
                              Get.to(
                                () => const Testscreen9(),
                                transition: Transition.fade,
                              );
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        top: 362,
                        child: Container(
                          width: 380,
                          height: 68,
                          clipBehavior: Clip.antiAlias,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 2,
                                color: const Color(0xFF232529),
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 111,
                                top: 22,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  spacing: 10,
                                  children: [
                                    Container(
                                      width: 24,
                                      height: 24,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(),
                                      child: Stack(),
                                    ),
                                    Icon(
                                      Icons.add_circle_outline,
                                      color: const Color(0xFF7F8694),
                                      size: 24,
                                    ),
                                    Text(
                                      '텍스트 추가',
                                      style: TextStyle(
                                        color: const Color(0xFF7F8694),
                                        fontSize: 14,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w500,
                                        height: 1.40,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        top: 535,
                        child: Container(
                          width: 380,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            spacing: 12,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 118.67,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('image/ex_image1.png'),
                                      fit: BoxFit.cover,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: 118.67,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: ShapeDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('image/ex_image2.png'),
                                      fit: BoxFit.fill,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    _pickImage();
                                  },
                                  child: Container(
                                    height: 118.67,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: ShapeDecoration(
                                      image: DecorationImage(
                                        image: _selectedImage != null
                                            ? FileImage(_selectedImage!)
                                            : const AssetImage(
                                                    'image/image.png', //image.png 두개 겹침.
                                                  )
                                                  as ImageProvider,
                                        // fit: BoxFit.cover,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 2,
                                          color: const Color(0xFF232529),
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Stack(
                                      children: [
                                        if (_selectedImage == null)
                                          Positioned(
                                            left: 47.67,
                                            top: 47,
                                            child: Container(
                                              width: 24,
                                              height: 24,
                                              clipBehavior: Clip.antiAlias,
                                              decoration: BoxDecoration(),
                                              child: Stack(),
                                            ),
                                          ),

                                        Container(
                                          color: Colors.transparent,
                                          child: Center(
                                            child: _selectedImage == null
                                                ? Icon(
                                                    Icons.add_photo_alternate,
                                                    color: Colors.white
                                                        .withOpacity(0.3),
                                                    size: 32,
                                                  )
                                                : null,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 16,
                        top: 292,
                        child: Container(
                          width: 380,
                          height: 68,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: ShapeDecoration(
                            color: const Color(0xFF1F2124),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: SizedBox(
                            width: 348,
                            child: TextField(
                              controller: _toneController,
                              style: const TextStyle(
                                color: const Color(0xFF8A9099),
                                fontSize: 16,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w500,
                                height: 1.40,
                              ),
                              decoration: InputDecoration(
                                isCollapsed: true,
                                border: InputBorder.none,
                                hintText: '텍스트를 입력하세요 (복사/붙여넣기 가능)',
                                hintStyle: TextStyle(
                                  color: const Color(0xFF8A9099),
                                  fontSize: 16,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w500,
                                  height: 1.40,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 32,
                        top: 248,
                        child: Text(
                          '텍스트 직접 첨부',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            height: 1.40,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 32,
                        top: 462,
                        child: Text(
                          '텍스트가 포함된 이미지 첨부',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                            height: 1.40,
                          ),
                        ),
                      ),
                      Positioned(
                        left: 12,
                        top: 488,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 8,
                          children: [
                            Container(
                              width: 14,
                              height: 14,
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(),
                              child: Stack(),
                            ),
                            Text(
                              '① 정확한 텍스트 인식을 위해 메신저 화면 캡쳐를 권장드려요',
                              style: TextStyle(
                                color: const Color(0xFFBDC7DB),
                                fontSize: 14,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w500,
                                height: 1.40,
                                letterSpacing: -0.35,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );

            if (scaledHeight > constraints.maxHeight) {
              return SingleChildScrollView(
                child: SizedBox(
                  width: screenWidth,
                  height: scaledHeight,
                  child: scaledContent,
                ),
              );
            } else {
              return SizedBox(
                width: screenWidth,
                height: scaledHeight,
                child: scaledContent,
              );
            }
          },
        ),
      ),
    );
  }
}
