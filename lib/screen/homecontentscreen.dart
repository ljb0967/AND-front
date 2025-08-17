import 'package:flutter/material.dart';
import 'widget/homeappbarwidget.dart';

class Homecontentscreen extends StatefulWidget {
  const Homecontentscreen({super.key});

  @override
  State<Homecontentscreen> createState() => _HomecontentscreenState();
}

class _HomecontentscreenState extends State<Homecontentscreen> {
  @override
  final List<bool> _checklistStates = [
    true, // "힘이 되는 사람과 30분 이상 대화하기" (기본적으로 체크됨)
    false, // "1시간 이상 바깥 공기 쐬고 오기"
    false, // "함께한 추억이 담긴 기록 살펴보기"
  ];

  Widget _buildChecklistItem(int index, String text) {
    return InkWell(
      // 텍스트 영역을 탭 가능하게 만듭니다.
      onTap: () {
        setState(() {
          _checklistStates[index] = !_checklistStates[index]; // 상태 토글
        });
      },
      child: Row(
        children: [
          Icon(
            _checklistStates[index]
                ? Icons.check_box
                : Icons.check_box_outline_blank,
            color: _checklistStates[index] ? Colors.blue : Colors.grey,
            size: 24.0,
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14.0,
                // decoration: isChecked
                //     ? TextDecoration.lineThrough
                //     : null, // 체크되면 취소선
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    final int completedCount = _checklistStates.where((state) => state).length;
    final double progress = _checklistStates.isEmpty
        ? 0.0
        : completedCount / _checklistStates.length;

    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.black,
            expandedHeight: 250.0,
            // pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Homeappbarwidget(),
            ), // Homeappbarwidget은 기존대로 사용
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  width: double.infinity, // 부모 너비 전체 사용
                  height: 80.0, // 높이 136px (제공된 레이아웃 정보)
                  padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F2124), // 배경색 #1F2124
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ), // 반경 10px (모서리 둥글게)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '바람도 쐴 겸, 이곳은 어때요?',
                        style: TextStyle(color: Colors.white, fontSize: 14.0),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        '오늘의 추천 장소 보러가기',
                        style: TextStyle(color: Colors.white70, fontSize: 12.0),
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                top: 324.0 + 80.0 + 20.0, // 적절한 위치로 조정
                left: 16.0,
                right: 16.0,
                child: Container(
                  padding: const EdgeInsets.all(20.0), // 내부 패딩
                  color: Colors.black,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        '오늘의 이별 극복 퀘스트',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        '이별을 혼자서 감당하는 억누르기형을 위한 맞춤 퀘스트',
                        style: TextStyle(color: Colors.white70, fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  16.0,
                  20.0,
                  16.0,
                  20.0,
                ), // 상단/하단 여백 20px 추가
                child: Container(
                  width: double.infinity, // 부모 너비 전체 사용
                  height: 140.0, // 높이 136px (제공된 레이아웃 정보)
                  padding: const EdgeInsets.all(16.0), // 내부 패딩 16px
                  decoration: BoxDecoration(
                    color: const Color(0xFF1F2124), // 배경색 #1F2124
                    borderRadius: BorderRadius.circular(10.0), // 반경 10px
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildChecklistItem(0, '힘이 되는 사람과 30분 이상 대화하기'),
                      const SizedBox(height: 8.0),
                      _buildChecklistItem(1, '1시간 이상 바깥 공기 쐬고 오기'),
                      const SizedBox(height: 8.0),
                      _buildChecklistItem(2, '함께한 추억이 담긴 기록 살펴보기'),
                      const Spacer(), // 남은 공간을 채워 프로그레스 바를 아래로 밀어냄
                      // 프로그레스 바
                      Row(
                        children: [
                          Expanded(
                            child: LinearProgressIndicator(
                              value: progress, // 33.3% 진행률
                              backgroundColor: Colors.grey[700],
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.blue,
                              ), // 진행바 색상
                              minHeight: 4.0, // 진행바 높이
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            '${(progress * 100).toStringAsFixed(1)}%',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 324.0 + 80.0 + 20.0 + 140.0, // 적절한 위치로 조정
                left: 16.0,
                right: 16.0,
                child: Container(
                  padding: const EdgeInsets.all(20.0), // 내부 패딩
                  color: Colors.black,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        '오늘도, 이별 나누기',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        '나와 유사한 이별을 한, 나와 비슷한 사람들의 이별일기',
                        style: TextStyle(color: Colors.white70, fontSize: 14.0),
                      ),
                    ],
                  ),
                ),
              ),
              Container(color: Colors.white, height: 200.0),
            ]),
          ),
        ],
      ),
    );
  }
}
