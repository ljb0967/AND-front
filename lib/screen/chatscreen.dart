import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _messageController.addListener(_onTextChanged);

    // 샘플 메시지들 (실제로는 API에서 가져올 데이터)
    _messages.addAll([
      {'text': '사랑하는 우리 아들', 'isUser': false, 'timestamp': '오전 9:41'},
      {'text': '오늘 주말인데 뭐 할기고', 'isUser': false, 'timestamp': '오전 9:41'},
      {'text': '넷플리스 볼려고', 'isUser': true, 'timestamp': '오전 9:42'},
    ]);
  }

  void _onTextChanged() {
    setState(() {
      _isTyping = _messageController.text.isNotEmpty;
    });
  }

  void _sendMessage() async {
    if (_messageController.text.trim().isEmpty) return;

    final userMessage = {
      'text': _messageController.text.trim(),
      'isUser': true,
      'timestamp': _getCurrentTime(),
    };

    setState(() {
      _messages.add(userMessage);
      _messageController.clear();
      _isTyping = false;
    });

    // TODO: OpenAI GPT API 호출하여 이별 상대의 응답 생성
    // await _generateResponse();
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
                vertical: 50.0,
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
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            decoration: BoxDecoration(color: Color(0xFF111111)),
            child: Row(
              children: [
                // 프로필 사진
                CircleAvatar(
                  radius: 20.0,
                  backgroundImage: AssetImage('image/character1.png'),
                ),

                SizedBox(width: 12.0),

                // 연락처 이름
                Expanded(
                  child: Text(
                    '사랑하는 우리 아빠',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w600,
                      height: 1.40,
                    ),
                  ),
                ),

                // 액션 아이콘들
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.search, color: Colors.white, size: 24.0),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.more_vert,
                        color: Colors.white,
                        size: 24.0,
                      ),
                      onPressed: () {},
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
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
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
            padding: EdgeInsets.all(16.0),
            color: Color(0xFF1F2124),
            child: Row(
              children: [
                // 갤러리 아이콘
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF111111),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Icon(Icons.image, color: Colors.white, size: 20.0),
                ),

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
                          color: Color(0xFFB8BFCC),
                          fontSize: 16,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                        ),
                        border: InputBorder.none,
                        isCollapsed: true,
                      ),
                      maxLines: null,
                    ),
                  ),
                ),

                SizedBox(width: 12.0),

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
                  color: Color(0xFFB8BFCC),
                  fontSize: 12,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
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
                backgroundImage: AssetImage('image/character1.png'),
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
                        color: Color(0xFFB8BFCC),
                        fontSize: 12,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
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
                            color: Color(0xFFB8BFCC),
                            fontSize: 12,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
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
