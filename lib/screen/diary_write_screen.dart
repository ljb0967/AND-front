import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'chatscreen.dart';
import 'dailyquestionscreen.dart';
import 'homecontentscreen.dart';
import 'farewelldiaryscreen.dart';
import 'farewellshopscreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../state/user_controller.dart';
import '../state/loss_case_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class DiaryWriteScreen extends StatefulWidget {
  const DiaryWriteScreen({super.key});

  @override
  State<DiaryWriteScreen> createState() => _DiaryWriteScreenState();
}

class _DiaryWriteScreenState extends State<DiaryWriteScreen> {
  final TextEditingController _answerController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final UserController userController = Get.find();
  final LossCaseController lossCaseController = Get.find();
  final ImagePicker _picker = ImagePicker();
  File? _image;
  int _characterCount = 0;

  int _selectedIndex = 3;
  int coin = 10;
  final List<Widget> _pages = [
    const ChatScreen(), // 인덱스 0: 대화하기
    const DailyQuestionScreen(), // 인덱스 1: 일일문답
    const Homecontentscreen(), // 인덱스 2: 홈 (기존 CustomScrollView 내용)
    const FarewellDiaryScreen(), // 인덱스 3: 이별일기
    const FarewellShopScreen(), // 인덱스 4: 이별상점
  ];

  @override
  void initState() {
    super.initState();
    // 글자수 카운터 리스너 추가
    _answerController.addListener(_updateCharacterCount);
    _titleController.text = '제목을 입력하세요';
    // 수정 모드인지 확인하고 기존 데이터 로드
    _loadExistingDiaryData();
  }

  // 기존 일기 데이터 로드 (수정 모드)
  void _loadExistingDiaryData() {
    try {
      if (Get.isRegistered<Map<String, dynamic>>(tag: 'editingDiary')) {
        final editingDiary = Get.find<Map<String, dynamic>>(
          tag: 'editingDiary',
        );

        // 제목과 내용을 컨트롤러에 설정
        _titleController.text = editingDiary['title'] ?? '';
        _answerController.text = editingDiary['content'] ?? '';

        // 글자수 업데이트
        _updateCharacterCount();

        print('수정 모드: 기존 일기 데이터 로드됨');
      }
    } catch (e) {
      print('기존 일기 데이터 로드 오류: $e');
    }
  }

  @override
  void dispose() {
    _answerController.removeListener(_updateCharacterCount);
    _answerController.dispose();

    // 수정 모드 태그 정리
    if (Get.isRegistered<Map<String, dynamic>>(tag: 'editingDiary')) {
      Get.delete<Map<String, dynamic>>(tag: 'editingDiary');
    }

    super.dispose();
  }

  // 오늘도, 이별 나누기 등록 확인 다이얼로그
  void _showRegistrationConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2A2D31),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            '이별 나누기 등록',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          content: Text(
            '정말로 이별 나누기를 등록하시겠습니까?',
            style: TextStyle(
              color: const Color(0xFFBDC7DB),
              fontSize: 16,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      margin: const EdgeInsets.only(right: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF8A9099),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          '취소',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      _registerDiaryToHome();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      margin: const EdgeInsets.only(left: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF65A0FF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          '확인',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _showSaveSuccessNotification(String message) {
    // 오버레이 위젯으로 알림창 표시
    OverlayEntry? overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 400,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF1F2124),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    message,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Icon(Icons.check, color: const Color(0xFF65A0FF), size: 20),
              ],
            ),
          ),
        ),
      ),
    );

    // 오버레이에 알림창 추가
    Overlay.of(context).insert(overlayEntry);

    // 200ms 후에 알림창 제거
    Future.delayed(const Duration(milliseconds: 1200), () {
      overlayEntry?.remove();
    });
  }

  // 홈 다이어리 화면에 일기 등록
  Future<void> _registerDiaryToHome() async {
    try {
      final title = _titleController.text.trim();
      final content = _answerController.text.trim();

      if (title.isEmpty || content.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('제목과 내용을 모두 입력해주세요.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      final currentDate = DateTime.now();
      final dateString =
          '${currentDate.year}.${currentDate.month.toString().padLeft(2, '0')}.${currentDate.day.toString().padLeft(2, '0')}';

      // 사용자 이름 가져오기 (UserController에서)
      final userName = userController.userName.value.isNotEmpty
          ? userController.userName.value
          : '익명의 작성자';

      String _subject = lossCaseController.subject.value;
      String _copeWay = lossCaseController.copeWay.value;
      String subject = '';
      String copeWay = '';

      if (_subject == 'FAMILY') {
        subject = '가족';
      } else if (_subject == 'LOVER') {
        subject = '연인';
      } else if (_subject == 'FREIND') {
        subject = '친구';
      } else if (_subject == 'PET') {
        subject = '반려동물';
      }

      if (_copeWay == 'SUPPRESS') {
        copeWay = '억누르기';
      } else if (_copeWay == 'EXPRESS') {
        copeWay = '표출';
      } else if (_copeWay == 'AVOID') {
        copeWay = '회피';
      } else if (_copeWay == 'ANALYZE') {
        copeWay = '분석';
      }

      // 배경 사진 경로
      final backgroundImage = _image?.path ?? 'image/background.jpg';

      // 일기 데이터 구성
      final diaryData = {
        'profileImage': 'image/character1.png', // 기본 프로필 이미지
        'userName': userName,
        'subject': subject,
        '_subject': _subject,
        'copeWay': copeWay,
        '_copeWay': _copeWay,
        'date': dateString,
        'title': title,
        'hashtags': ['#${subject}이별', '#${copeWay}형'],
        'backgroundImage': backgroundImage,
        'isBookmarked': false,
        'content': content,
      };

      // SharedPreferences에 저장
      await _saveDiaryToHome(diaryData);

      // 성공 메시지 표시
      _showSaveSuccessNotification('일기가 등록되었어요');

      // 이전 화면으로 돌아가기
      Get.back();
    } catch (e) {
      print('일기 등록 오류: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('일기 등록 중 오류가 발생했습니다.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // 홈 다이어리 화면용 데이터 저장
  Future<void> _saveDiaryToHome(Map<String, dynamic> diaryData) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // 기존 홈 다이어리 데이터 가져오기
      final existingHomeDiariesJson = prefs.getString('homeDiaries') ?? '[]';
      final List<dynamic> existingHomeDiaries = json.decode(
        existingHomeDiariesJson,
      );

      // 같은 날짜에 이미 일기가 있으면 덮어쓰기
      final existingIndex = existingHomeDiaries.indexWhere(
        (diary) => diary['date'] == diaryData['date'],
      );

      if (existingIndex != -1) {
        existingHomeDiaries[existingIndex] = diaryData;
      } else {
        existingHomeDiaries.add(diaryData);
      }

      // 업데이트된 홈 다이어리 데이터 저장
      await prefs.setString('homeDiaries', json.encode(existingHomeDiaries));

      print('홈 다이어리 등록 완료: ${diaryData['title']}');
    } catch (e) {
      print('홈 다이어리 저장 오류: $e');
      throw e;
    }
  }

  Future<void> _submitDiary() async {
    final title = _titleController.text.trim();
    final answer = _answerController.text.trim();
    final lossCaseId = lossCaseController.lossCaseId.value;
    final body = {'lossCaseId': lossCaseId, 'text': answer};
    //final uri = Uri.parse('http://10.0.2.2:8080/diaries');
    final uri = Uri.parse('https://and-backend.onrender.com/diaries');
    final response = await http.post(
      uri,
      headers: userController.getAuthHeaders(),
      body: json.encode(body),
    );
    if (response.statusCode == 200) {
      print('일기 저장 성공: ${response.body}');
    } else {
      print('일기 저장 실패: ${response.body}');
    }

    // 제목과 내용이 비어있는지 확인
    if (title.isEmpty || answer.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('제목과 내용을 모두 입력해주세요.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      final lossCaseId = lossCaseController.lossCaseId.value;
      final currentDate = DateTime.now();
      final dateString =
          '${currentDate.year}.${currentDate.month.toString().padLeft(2, '0')}.${currentDate.day.toString().padLeft(2, '0')}';

      // 일기 데이터 구성
      final diaryData = {
        'title': title,
        'content': answer,
        'date': dateString,
        'lossCaseId': lossCaseId,
        'imagePath': _image?.path,
      };

      // 로컬 저장소에 일기 저장 (SharedPreferences 또는 다른 로컬 저장소 사용)
      await _saveDiaryLocally(diaryData);

      // 성공 메시지 표시
      _showSaveSuccessNotification('일기를 저장했습니다');

      // 이전 화면으로 돌아가기
      Get.off(Homecontentscreen(), transition: Transition.fade);
    } catch (e) {
      print('일기 저장 오류: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('일기 저장 중 오류가 발생했습니다.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _saveDiaryLocally(Map<String, dynamic> diaryData) async {
    try {
      // SharedPreferences를 사용하여 일기 데이터 저장
      final prefs = await SharedPreferences.getInstance();

      // 기존 일기 목록 가져오기
      final existingDiariesJson = prefs.getString('diaries') ?? '[]';
      final List<dynamic> existingDiaries = json.decode(existingDiariesJson);

      // 같은 날짜에 이미 일기가 있으면 덮어쓰기
      final existingIndex = existingDiaries.indexWhere(
        (diary) => diary['date'] == diaryData['date'],
      );
      if (existingIndex != -1) {
        existingDiaries[existingIndex] = diaryData;
      } else {
        existingDiaries.add(diaryData);
      }

      // 업데이트된 일기 목록 저장
      await prefs.setString('diaries', json.encode(existingDiaries));

      // GetX에도 저장 (UI 업데이트용)
      Get.put(diaryData, tag: 'savedDiary');

      // farewelldiaryscreen.dart의 데이터 업데이트를 위한 신호 전송
      if (Get.isRegistered<RxBool>(tag: 'diaryUpdated')) {
        Get.find<RxBool>(tag: 'diaryUpdated').value = true;
      } else {
        Get.put(RxBool(true), tag: 'diaryUpdated');
      }

      // 수정 모드였다면 editingDiary 태그 제거
      if (Get.isRegistered<Map<String, dynamic>>(tag: 'editingDiary')) {
        Get.delete<Map<String, dynamic>>(tag: 'editingDiary');
      }

      print('일기 저장 완료: ${diaryData['title']}');
    } catch (e) {
      print('로컬 저장 오류: $e');
      throw e;
    }
  }

  void _showImageSourceDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 드래그 핸들
              SizedBox(height: 12),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 6),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2D31),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        _pickImage(ImageSource.gallery);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2A2D31),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            '앨범에서 사진 선택하기',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                              height: 1.40,
                              letterSpacing: -0.40,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        setState(() {
                          _image = null;
                        });
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2A2D31),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            'AND 기본 사진 선택하기',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                              height: 1.40,
                              letterSpacing: -0.40,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // 사진 촬영하기
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        _pickImage(ImageSource.camera);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2A2D31),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            '사진 촬영하기',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                              height: 1.40,
                              letterSpacing: -0.40,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // 앨범에서 사진 선택하기
              const SizedBox(height: 20),

              // 취소하기 버튼
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF65A0FF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      '취소하기',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w600,
                        height: 1.40,
                        letterSpacing: -0.40,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          _image = File(image.path);
        });
      }
    } catch (e) {
      print('이미지 선택 오류: $e');
    }
  }

  void _updateCharacterCount() {
    setState(() {
      _characterCount = _answerController.text.length;
    });
  }

  void _onItemTapped(int index) {
    // 현재 화면과 같은 화면을 선택한 경우 navigation하지 않음
    if (index == _selectedIndex) return;

    setState(() {
      _selectedIndex = index; // 선택된 인덱스를 업데이트합니다.
    });

    // 다른 화면으로 이동할 때만 navigation
    if (index != 3) {
      Get.off(_pages[index], transition: Transition.fade);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111111),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              image: _image != null
                  ? DecorationImage(
                      image: FileImage(_image!),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withValues(alpha: 0.5),
                        BlendMode.multiply,
                      ),
                    )
                  : DecorationImage(
                      image: AssetImage('image/background.jpg'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withValues(alpha: 0.5), // 수치 높일수록 더 어두워짐
                        BlendMode.multiply, // 또는 BlendMode.darken
                      ),
                    ),
            ),
            child: Column(
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
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(),
                            child: IconButton(
                              icon: Image.asset('image/arrow-left.png'),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 130, 0),
                          child: Container(
                            child: Text(
                              '오늘의 이별일기',
                              style: TextStyle(
                                color: const Color(0xFFBDC7DB),
                                fontSize: 14,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w500,
                                height: 1.40,
                              ),
                            ),
                          ),
                        ),

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
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 24, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          _showRegistrationConfirmation();
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 130, 0),
                          child: Container(
                            width: 150,
                            height: 30,
                            padding: const EdgeInsets.symmetric(horizontal: 0),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1F2124),
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Center(
                              child: Text(
                                '오늘도, 이별 나누기 등록',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w500,
                                  height: 1.40,
                                  letterSpacing: -0.35,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Icon(
                        Icons.star_border,
                        color: const Color(0xFFBDC7DB),
                        size: 30,
                      ),
                      SizedBox(width: 12),
                      GestureDetector(
                        onTap: () {
                          _showImageSourceDialog();
                        },
                        child: Icon(
                          Icons.image_outlined,
                          color: const Color(0xFFBDC7DB),
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.fromLTRB(28, 0, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          '${DateTime.now().year}.${DateTime.now().month}.${DateTime.now().day}',
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
                ),
                SizedBox(height: 2),
                Padding(
                  padding: const EdgeInsets.fromLTRB(28, 0, 0, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          child: TextField(
                            controller: _titleController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: '제목을 입력하세요',
                              hintStyle: TextStyle(
                                color: const Color(0xFF7F8694),
                                fontSize: 20,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w600,
                                height: 1.40,
                                letterSpacing: -0.50,
                              ),
                            ),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w600,
                              height: 1.40,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 22),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                          child: Container(
                            width: 348,
                            height: 355,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: ShapeDecoration(
                              color: const Color(0xFF111111),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: TextField(
                              keyboardType: TextInputType.multiline,
                              maxLines: null,
                              style: TextStyle(
                                color: const Color(0xFFBDC7DB),
                                fontSize: 14,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w500,
                                height: 1.40,
                                letterSpacing: -0.35,
                              ),
                              decoration: InputDecoration(
                                isCollapsed: true,
                                border: InputBorder.none,
                                hintText: '일기를 작성하세요',
                                hintStyle: TextStyle(
                                  color: const Color(0xFF7F8694),
                                  fontSize: 16,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w500,
                                  height: 1.40,
                                  letterSpacing: -0.40,
                                ),
                              ),
                              controller: _answerController,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 12, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          child: Text(
                            '$_characterCount/2000',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              height: 1.40,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 18),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: GestureDetector(
                            // onTap: _isSaveAnswer()
                            //     ? _showDeleteConfirmDialog
                            //     : null,
                            onTap: Get.back,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              decoration: ShapeDecoration(
                                color: const Color(0xFF1F2124),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  '일기 삭제하기',
                                  style: TextStyle(
                                    color: const Color(0xFF7F8694),
                                    fontSize: 14,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w600,
                                    height: 1.40,
                                    letterSpacing: -0.35,
                                  ),
                                  // style: !_isSaveAnswer()
                                  //     ? TextStyle(
                                  //         color: const Color(
                                  //           0xFF7F8694,
                                  //         ),
                                  //         fontSize: 14,
                                  //         fontFamily:
                                  //             'Pretendard',
                                  //         fontWeight:
                                  //             FontWeight.w600,
                                  //         height: 1.40,
                                  //         letterSpacing: -0.35,
                                  //       )
                                  //     : TextStyle(
                                  //         color: const Color(
                                  //           0xFFBDC7DB,
                                  //         ),
                                  //         fontSize: 14,
                                  //         fontFamily:
                                  //             'Pretendard',
                                  //         fontWeight:
                                  //             FontWeight.w600,
                                  //         height: 1.40,
                                  //         letterSpacing: -0.35,
                                  //       ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: GestureDetector(
                            onTap: () {
                              _submitDiary();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              decoration: ShapeDecoration(
                                color: const Color(0xFF65A0FF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  '일기 저장하기',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w600,
                                    height: 1.40,
                                    letterSpacing: -0.35,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('image/message-circle.png')),
            label: '대화하기',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('image/edit.png')),
            label: '일일문답',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('image/home.png')),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('image/book.png')),
            label: '이별일기',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('image/shopping-bag.png')),
            label: '이별상점',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color(0xFF8A9099),
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w600,
          height: 2.20,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w600,
          height: 2.20,
        ),
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
      ),
    );
  }
}
