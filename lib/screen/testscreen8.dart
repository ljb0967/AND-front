import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'homescreen.dart';
import '../state/survey_controller.dart';
import 'testscreen7.dart';
import 'testscreen9.dart';
import '../state/loss_case_controller.dart';
import 'dart:convert';

class Testscreen8 extends StatefulWidget {
  const Testscreen8({super.key});

  @override
  State<Testscreen8> createState() => _Testscreen8State();
}

class _Testscreen8State extends State<Testscreen8> {
  final TextEditingController _toneController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  // LossCaseController 가져오기
  final LossCaseController lossCaseController = Get.find<LossCaseController>();

  String _convertToBase64(File imageFile) {
    final bytes = imageFile.readAsBytesSync(); // 이미지 바이트 읽기
    return base64Encode(bytes); // Base64 문자열로 변환
  }

  Future<void> _pickImage() async {
    try {
      print('이미지 선택 시작');

      // 사용자에게 갤러리 또는 카메라 선택 옵션 제공
      // final ImageSource? source = await _showImageSourceDialog();
      // if (source == null) {
      //   print('이미지 소스가 선택되지 않음');
      //   return;
      // }

      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
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
        // print('이미지가 선택되지 않음');
        // // 사용자에게 안내 메시지 표시
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(
        //     content: Text('이미지를 선택해주세요'),
        //     backgroundColor: Colors.blue,
        //   ),
        // );
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
      backgroundColor: const Color(0xFF111111),
      body: SafeArea(
        child: Column(
          children: [
            // 상단 헤더 영역
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 28, 12, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
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

            // 프로그레스 바
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  // 파란색 = 1
                  Expanded(
                    flex: 40,
                    child: Container(
                      height: 4,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF65A0FF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  ),
                  // 검은색 = 10
                  Expanded(
                    flex: 10,
                    child: Container(
                      height: 4,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF232529),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 메인 콘텐츠 영역 (스크롤 가능)
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),

                    // 메인 타이틀
                    Text(
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

                    SizedBox(height: 20),

                    // 서브 타이틀
                    Text(
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

                    SizedBox(height: 32),

                    // 텍스트 직접 첨부 섹션
                    Text(
                      '텍스트 직접 첨부',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        height: 1.40,
                      ),
                    ),

                    SizedBox(height: 16),

                    // 텍스트 입력 필드
                    Container(
                      width: double.infinity,
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
                      child: TextField(
                        controller: _toneController,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
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

                    SizedBox(height: 16),

                    // 텍스트 추가 버튼
                    Container(
                      width: double.infinity,
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
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_circle_outline,
                              color: const Color(0xFF7F8694),
                              size: 24,
                            ),
                            SizedBox(width: 10),
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
                    ),

                    SizedBox(height: 32),

                    // 이미지 첨부 섹션
                    Text(
                      '텍스트가 포함된 이미지 첨부',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        height: 1.40,
                      ),
                    ),

                    SizedBox(height: 16),

                    // 안내 메시지
                    Row(
                      children: [
                        Container(
                          width: 14,
                          height: 14,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(),
                          child: Stack(),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
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
                        ),
                      ],
                    ),

                    SizedBox(height: 16),

                    // 이미지 그리드
                    Row(
                      children: [
                        // 첫 번째 예시 이미지
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

                        SizedBox(width: 12),

                        // 두 번째 예시 이미지
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

                        SizedBox(width: 12),

                        // 사용자 이미지 첨부 영역
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              _pickImage();
                            },
                            child: Container(
                              height: 118.67,
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                image: _selectedImage != null
                                    ? DecorationImage(
                                        image: FileImage(_selectedImage!),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 2,
                                    color: const Color(0xFF232529),
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: _selectedImage == null
                                  ? Center(
                                      child: Icon(
                                        Icons.add_photo_alternate,
                                        color: Colors.white.withOpacity(0.3),
                                        size: 32,
                                      ),
                                    )
                                  : null,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 40),

                    // AND 시작하기 버튼
                    SizedBox(
                      width: double.infinity,
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
                          if (_selectedImage != null) {
                            final base64Image = _convertToBase64(
                              _selectedImage!,
                            );
                            lossCaseController.setPhoto(
                              base64Image,
                            ); // Base64 문자열 저장
                          }

                          print('Testscreen8 데이터 저장 완료');
                          lossCaseController.printCurrentData();

                          Get.to(
                            () => const Testscreen9(),
                            transition: Transition.fade,
                          );
                        },
                      ),
                    ),

                    SizedBox(height: 32),
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
