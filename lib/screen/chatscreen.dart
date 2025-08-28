import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dailyquestionscreen.dart';
import 'homecontentscreen.dart';
import 'farewelldiaryscreen.dart';
import 'farewellshopscreen.dart';
import 'chatprofilescreen.dart';
import 'package:http/http.dart' as http;
import '../state/user_controller.dart';
import '../state/loss_case_controller.dart';
import '../state/chat_controller.dart';
import 'dart:convert';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int _selectedIndex = 0;
  final LossCaseController lossCaseController = Get.find<LossCaseController>();
  final UserController userController = Get.find<UserController>();
  final ChatController chatController = Get.find<ChatController>();
  final List<Widget> _pages = [
    const ChatScreen(), // 인덱스 0: 대화하기
    const DailyQuestionScreen(), // 인덱스 1: 일일문답
    const Homecontentscreen(), // 인덱스 2: 홈 (기존 CustomScrollView 내용)
    const FarewellDiaryScreen(), // 인덱스 3: 이별일기
    const FarewellShopScreen(), // 인덱스 4: 이별상점
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // 선택된 인덱스를 업데이트합니다.
    });
    if (index == 0) return;
    Get.off(_pages[index], transition: Transition.fade);
  }

  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  bool _isTyping = false;

  Future<void> _getchatroomid() async {
    final id = lossCaseController.lossCaseId.value;
    final requestData = {"lossCaseId": id};

    final uri = Uri.parse(
      'http://10.0.2.2:8080/chat/rooms',
    ).replace(queryParameters: {'lossCaseId': id.toString()});

    final response = await http.post(
      uri,
      headers: userController.getAuthHeaders(),
      body: json.encode(requestData),
    );
    print('Chat Room 생성 요청: ${requestData}');

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      final chatRoomId =
          responseData['chatRoomId'] ?? responseData['body']?['chatRoomId'];
      if (chatRoomId != null) chatController.setChatRoomId(chatRoomId);
      debugPrint('Chat Room 생성 성공: ${response.body}');
    } else {
      debugPrint('Chat Room 생성 실패 [${response.statusCode}]: ${response.body}');
    }
  }

  Future<void> _getchatmessages() async {
    final roomId = chatController.chatRoomId.value;

    final uri = Uri.parse('http://10.0.2.2:8080/chat/rooms/$roomId/messages');

    final response = await http.get(
      uri,
      headers: userController.getAuthHeaders(),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = jsonDecode(response.body);
      // 불러온 채팅 내용 버블에 반영해야함. {id = 0} , {id = 1} , {id = 2} ... _messages.add() 함수 사용 예정,
      print('Chat Message 데이터 불러오기 성공: ${response.body}');
      for (var message in responseData) {
        if (message['sender'] == 'User') {
          final userMessage = {
            'text': message['text'],
            'isUser': true,
            'timestamp': _formatTimestamp(message['createdAt']),
          };
          setState(() {
            _messages.add(userMessage);
          });
        } else {
          final opponentMessage = {
            'text': message['text'],
            'isUser': false,
            'timestamp': _formatTimestamp(message['createdAt']),
          };
          setState(() {
            _messages.add(opponentMessage);
          });
        }
      }
    } else {
      print('Chat Message 데이터 불러오기 실패: ${response.body}');
    }
  }

  Future<void> _updatemessage(String sender, String text) async {
    chatController.setSender(sender);
    chatController.setText(text);
    chatController.setCreatedAt(DateTime.now());
    chatController.setUpdatedAt(DateTime.now());

    final requestData = chatController.toJson();
    final chatRoomId = chatController.chatRoomId.value;

    final response = await http.post(
      Uri.parse('http://10.0.2.2:8080/chat/rooms/${chatRoomId}/messages'),
      headers: userController.getAuthHeaders(),
      body: json.encode(requestData),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      //서버에서 메시지별 id를 반환하는데 우선은 필요없어서 따로 저장안함.
      print('메시지 저장 성공: ${response.body}');
    } else {
      print('메시지 저장 실패: ${response.body}');
    }
  }

  @override
  void initState() {
    super.initState();
    _bootstrap();
    _messageController.addListener(_onTextChanged);

    // 샘플 메시지들 (실제로는 API에서 가져올 데이터)
    _messages.addAll([
      {'text': '사랑하는 우리 아들', 'isUser': false, 'timestamp': '오전 9:41'},
      {'text': '오늘 주말인데 뭐 할기고', 'isUser': false, 'timestamp': '오전 9:41'},
      {'text': '넷플리스 볼려고', 'isUser': true, 'timestamp': '오전 9:42'},
    ]);
  }

  Future<void> _bootstrap() async {
    if (chatController.chatRoomId.value == 0) {
      await _getchatroomid();
      await _getchatmessages();
    } else {
      await _getchatmessages();
    }
  }

  void _onTextChanged() {
    setState(() {
      _isTyping = _messageController.text.isNotEmpty;
    });
  }

  void _sendMessage() async {
    final input = _messageController.text.trim();
    if (_messageController.text.trim().isEmpty) return;

    final userMessage = {
      'text': _messageController.text.trim(),
      'isUser': true,
      'timestamp': _getCurrentTime(),
    };

    setState(() {
      _messages.add(userMessage);
      _isTyping = true;
      _updatemessage('User', _messageController.text.trim());
      _messageController.clear();
    });

    // TODO: OpenAI GPT API 호출하여 이별 상대의 응답 생성 후 _updatemessage 함수 호출에서 Post
    String prompt =
        '''You are a chatbot that takes on the role of the user's ex-partner 
    and comforts the user's feelings through conversation. You must respond in Korean. 
    Send replies that are not too long, like messages on KakaoTalk or Instagram DM.''';

    String model = 'gpt-5';
    String apiKey = '';

    var response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model': model,
        'messages': [
          {'role': 'system', 'content': prompt},
          {'role': 'user', 'content': input},
        ],
        'max_completion_tokens': 1000,
      }),
    );

    if (response.statusCode == 200) {
      print('OpenAI GPT API 호출 성공: ${response.body}');
      var data = jsonDecode(response.body);
      Map<String, dynamic> message = {
        'text': data['choices'][0]['message']['content'],
        'isUser': false,
        'timestamp': _getCurrentTime(),
      };
      setState(() {
        _messages.add(message);
        _isTyping = true;
        _updatemessage('Opponent', data['choices'][0]['message']['content']);
      });
    } else {
      print('OpenAI GPT API 호출 실패: ${response.body}');
    }

    // else {
    //   setState(() {
    //     _generatedText = "Error: ${response.reasonPhrase}";
    //   });
    // }

    // await _generateResponse();

    // setState(() {
    //   _messages.add(userMessage);
    //   _messageController.clear();
    //   _isTyping = false;
    //   _updatemessage('User', _messageController.text.trim());
    // });
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    final hour = now.hour;
    final minute = now.minute;

    if (hour < 12) {
      return '오전 ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    } else {
      return '오후 ${(hour - 12).toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    }
  }

  String _formatTimestamp(String timestamp) {
    final messageTime = DateTime.parse(timestamp);
    final hour = messageTime.hour;
    final minute = messageTime.minute;
    if (hour < 12) {
      return '오전 ${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    } else {
      return '오후 ${(hour - 12).toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF111111),
      body: Column(
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
          // 채팅 헤더 (사랑하는 우리 아빠)
          Container(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 12),
            decoration: BoxDecoration(color: Color(0xFF111111)),
            child: Row(
              children: [
                // 프로필 사진
                CircleAvatar(
                  radius: 20.0,
                  child: Icon(Icons.person, color: Colors.grey, size: 20.0),
                ),

                SizedBox(width: 12.0),

                // 연락처 이름
                Expanded(
                  child: Text(
                    '사랑하는 우리 아빠',
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

                // 액션 아이콘들
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.white,
                        size: 24.0,
                      ),
                      onPressed: () {
                        Get.to(() => Chatprofilescreen());
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 채팅 메시지 영역
          Expanded(
            child: Container(
              color: Color(0xFF111111),
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  final showTimestamp =
                      index == 0 ||
                      (index > 0 &&
                          _messages[index - 1]['timestamp'] !=
                              message['timestamp']);

                  return Column(
                    children: [
                      // 메시지 버블
                      _buildMessageBubble(message, index, showTimestamp),

                      SizedBox(height: 8.0),
                    ],
                  );
                },
              ),
            ),
          ),

          // 메시지 입력 영역
          Container(
            padding: EdgeInsets.all(4.0),
            color: Color(0xFF1F2124),
            child: Row(
              children: [
                // 갤러리 아이콘
                SizedBox(width: 12.0),

                // 메시지 입력 필드
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 12.0,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFF111111),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: TextField(
                      controller: _messageController,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintText: '메시지를 입력하세요',
                        hintStyle: TextStyle(
                          color: const Color(0xFF7F8694),
                          fontSize: 16,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                          height: 1.40,
                          letterSpacing: -0.40,
                        ),
                        border: InputBorder.none,
                        isCollapsed: true,
                      ),
                      maxLines: null,
                    ),
                  ),
                ),

                SizedBox(width: 12.0),

                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF111111),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Icon(Icons.image, color: Colors.white, size: 20.0),
                ),

                // 전송 버튼 (메시지 입력 시에만 표시)
                if (_isTyping)
                  GestureDetector(
                    onTap: _sendMessage,
                    child: Container(
                      padding: EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Color(0xFF65A0FF),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Icon(Icons.send, color: Colors.white, size: 20.0),
                    ),
                  ),
              ],
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

  Widget _buildMessageBubble(
    Map<String, dynamic> message,
    int index,
    bool showTimestamp,
  ) {
    final isUser = message['isUser'] as bool;

    if (isUser) {
      // 사용자 메시지 (오른쪽, 파란색)
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // 시각 표시 (왼쪽)
          if (showTimestamp)
            Padding(
              padding: EdgeInsets.only(right: 8.0, bottom: 4.0),
              child: Text(
                message['timestamp'],
                style: TextStyle(
                  color: const Color(0xFFBDC7DB),
                  fontSize: 12,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                  height: 1.40,
                  letterSpacing: -0.30,
                ),
              ),
            ),

          // 메시지 버블
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              decoration: BoxDecoration(
                color: Color(0xFF65A0FF),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Text(
                message['text'],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                  height: 1.40,
                  letterSpacing: -0.40,
                ),
              ),
            ),
          ),
        ],
      );
    } else {
      // 상대방 메시지 (왼쪽, 회색)
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 프로필 사진 (첫 번째 메시지에만 표시)
          if (index == 0 ||
              (index > 0 && _messages[index - 1]['isUser'] == true))
            Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: CircleAvatar(
                radius: 16.0,
                child: Icon(Icons.person, color: Colors.grey, size: 20.0),
              ),
            )
          else
            SizedBox(width: 40.0), // 프로필 사진 공간만 차지
          // 메시지 영역 (이름 + 말풍선)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 상대 이름 (프로필 사진 오른쪽 말풍선 위에)
                if (index == 0 ||
                    (index > 0 && _messages[index - 1]['isUser'] == true))
                  Padding(
                    padding: EdgeInsets.only(left: 8.0, bottom: 4.0),
                    child: Text(
                      '사랑하는 우리 아빠',
                      style: TextStyle(
                        color: const Color(0xFFBDC7DB),
                        fontSize: 14,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                        height: 1.40,
                        letterSpacing: -0.35,
                      ),
                    ),
                  )
                else
                  SizedBox(height: 16.0), // 이름 공간만 차지
                // 메시지 버블
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // 메시지 말풍선
                    Flexible(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 12.0,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFF1F2124),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Text(
                          message['text'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            height: 1.40,
                            letterSpacing: -0.40,
                          ),
                        ),
                      ),
                    ),

                    // 시각 표시 (오른쪽)
                    if (showTimestamp)
                      Padding(
                        padding: EdgeInsets.only(left: 8.0, bottom: 4.0),
                        child: Text(
                          message['timestamp'],
                          style: TextStyle(
                            color: const Color(0xFFBDC7DB),
                            fontSize: 12,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            height: 1.40,
                            letterSpacing: -0.30,
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    }
  }
}
