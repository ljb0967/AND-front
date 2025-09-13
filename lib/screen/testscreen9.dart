import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'analysis_animation_screen.dart';
import '../state/loss_case_controller.dart';
import '../state/user_controller.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Testscreen9 extends StatefulWidget {
  const Testscreen9({super.key});

  @override
  State<Testscreen9> createState() => _Testscreen9State();
}

class _Testscreen9State extends State<Testscreen9> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  File? _selectedImage2;
  File? _selectedImage3;

  // LossCaseController와 UserController 가져오기
  final LossCaseController lossCaseController = Get.find<LossCaseController>();
  final UserController userController = Get.find<UserController>();

  Future<void> _pickImage() async {
    try {
      //print('이미지 선택 시작');

      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      //print('선택된 이미지: ${image?.path}');

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
          //print('이미지가 성공적으로 선택됨: ${_selectedImage?.path}');
        });
      }
    } catch (e) {
      //print('이미지 선택 오류: $e');
      // 사용자에게 오류 메시지 표시
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('이미지 선택 중 오류가 발생했습니다: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _pickImage2() async {
    try {
      //print('이미지 선택 시작');

      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      //print('선택된 이미지: ${image?.path}');

      if (image != null) {
        setState(() {
          _selectedImage2 = File(image.path);
          //print('이미지가 성공적으로 선택됨: ${_selectedImage2?.path}');
        });
      }
    } catch (e) {
      //print('이미지 선택 오류: $e');
      // 사용자에게 오류 메시지 표시
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('이미지 선택 중 오류가 발생했습니다: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _pickImage3() async {
    try {
      //print('이미지 선택 시작');

      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      //print('선택된 이미지: ${image?.path}');

      if (image != null) {
        setState(() {
          _selectedImage3 = File(image.path);
          //print('이미지가 성공적으로 선택됨: ${_selectedImage3?.path}');
        });
      }
    } catch (e) {
      //print('이미지 선택 오류: $e');
      // 사용자에게 오류 메시지 표시
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('이미지 선택 중 오류가 발생했습니다: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // 최종 데이터를 서버로 전송
  Future<void> _submitFinalData() async {
    try {
      // LossCaseController에서 최종 데이터 가져오기
      final requestData = lossCaseController.toJson();

      // API 엔드포인트 호출
      final response = await http.post(
        //Uri.parse('http://10.0.2.2:8080/loss-cases'),
        Uri.parse('https://and-backend.onrender.com/loss-cases'),
        headers: userController.getAuthHeaders(),
        body: json.encode(requestData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = jsonDecode(response.body); // String → Map 변환
        lossCaseController.setLossCaseId(responseData['lossCaseId']);
        //print('Loss Case 생성 성공: ${response.body}');

        // 성공 시 홈 화면으로 이
        Get.offUntil(
          MaterialPageRoute(
            builder: (_) => AnalysisAnimationScreen(),
          ), //로그인 페이지 외에 이전 모든 페이지 스택에서 pop
          (route) => route.settings.name == "/Loginscreen",
        );
      } else {
        //print('Loss Case 생성 실패: ${response.statusCode} - ${response.body}');
        // 실패 시 사용자에게 알림
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('데이터 전송에 실패했습니다: ${response.statusCode}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      //print('데이터 전송 오류: $e');
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('데이터 전송 중 오류가 발생했습니다: $e'),
      //     backgroundColor: Colors.red,
      //   ),
      // );
    }
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
                    '대화 방식 첨부',
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
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: Container(
                width: double.infinity,
                height: 4,
                decoration: ShapeDecoration(
                  color: const Color(0xFF65A0FF),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ),

            // 메인 콘텐츠 영역 (스크롤 가능)
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),

                    // 메인 타이틀
                    Text(
                      '추가로, 이별한 사람과의\n추억이 담긴 사진을 저장할 수 있어요',
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
                      '홈 화면에서 저장한 사진들을 아카이브 형식으로 감상할 수 있어요',
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

                    // 첫 번째 행 이미지들
                    Row(
                      children: [
                        // 첫 번째 이미지
                        Expanded(
                          child: Container(
                            height: 184,
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              image: DecorationImage(
                                image: AssetImage('image/ex_photo.png'),
                                fit: BoxFit.cover,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: 12),

                        // 두 번째 이미지
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              _pickImage();
                            },
                            child: Container(
                              height: 184,
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: const Color(0xFF1F2124),
                                image: _selectedImage != null
                                    ? DecorationImage(
                                        image: FileImage(_selectedImage!),
                                        fit: BoxFit.cover,
                                      )
                                    : null,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              child: _selectedImage == null
                                  ? Center(
                                      child: Icon(
                                        Icons.add_photo_alternate,
                                        color: Colors.white.withValues(
                                          alpha: 0.3,
                                        ),
                                        size: 32,
                                      ),
                                    )
                                  : null,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 12),

                    // 세 번째 이미지 (하단)
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              _pickImage2();
                            },
                            child: Container(
                              //width: double.infinity,
                              height: 184,
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: const Color(0xFF1F2124),
                                image: _selectedImage2 != null
                                    ? DecorationImage(
                                        image: FileImage(_selectedImage2!),
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
                              child: _selectedImage2 == null
                                  ? Center(
                                      child: Icon(
                                        Icons.add_photo_alternate,
                                        color: Colors.white.withValues(
                                          alpha: 0.3,
                                        ),
                                        size: 32,
                                      ),
                                    )
                                  : null,
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              _pickImage3();
                            },
                            child: Container(
                              //width: double.infinity,
                              height: 184,
                              clipBehavior: Clip.antiAlias,
                              decoration: ShapeDecoration(
                                color: const Color(0xFF1F2124),
                                image: _selectedImage3 != null
                                    ? DecorationImage(
                                        image: FileImage(_selectedImage3!),
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
                              child: _selectedImage3 == null
                                  ? Center(
                                      child: Icon(
                                        Icons.add_photo_alternate,
                                        color: Colors.white.withValues(
                                          alpha: 0.3,
                                        ),
                                        size: 32,
                                      ),
                                    )
                                  : null,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),

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
                            lossCaseController.addProfilePhoto(
                              _selectedImage!.path,
                            );
                          }
                          if (_selectedImage2 != null) {
                            lossCaseController.addProfilePhoto(
                              _selectedImage2!.path,
                            );
                          }
                          lossCaseController.analysisTone();
                          _submitFinalData();
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
