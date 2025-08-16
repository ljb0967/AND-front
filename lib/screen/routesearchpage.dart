import 'package:flutter/material.dart';

class RouteSearchPage extends StatefulWidget {
  const RouteSearchPage({super.key});

  @override
  State<RouteSearchPage> createState() => _RouteSearchPageState();
}

class _RouteSearchPageState extends State<RouteSearchPage> {
  // 게시글 데이터 모델
  final List<Post> allPosts = [
    Post(
      title: '멘토 - 서비스기획',
      type: '멘토',
      category: '서비스기획',
      content: '서비스 기획 멘토링 해드립니다.',
    ),
    Post(title: '멘티 - 개발', type: '멘티', category: '개발', content: '개발 멘토를 찾습니다.'),
    Post(
      title: '멘토 - 데이터/AI/ML',
      type: '멘토',
      category: '데이터/AI/ML',
      content: 'AI/ML 관련 멘토링 가능',
    ),
    Post(
      title: '멘티 - 마케팅/광고',
      type: '멘티',
      category: '마케팅/광고',
      content: '마케팅 분야 멘토 구해요',
    ),
    Post(
      title: '멘토 - 개발',
      type: '멘토',
      category: '개발',
      content: 'Flutter 개발 멘토링',
    ),
    Post(
      title: '멘티 - 서비스기획',
      type: '멘티',
      category: '서비스기획',
      content: '서비스 기획 배우고 싶어요',
    ),
    Post(title: '멘토 - 전체', type: '멘토', category: '전체', content: '다방면 멘토링 가능'),
    Post(
      title: '멘티 - 데이터/AI/ML',
      type: '멘티',
      category: '데이터/AI/ML',
      content: 'AI/ML 멘토 구합니다',
    ),
  ];

  final List<String> tabTypes = ['전체', '멘토', '멘티'];
  final List<String> categories = ['전체', '서비스기획', '개발', '데이터/AI/ML', '마케팅/광고'];

  int selectedTab = 0; // 0: 전체, 1: 멘토, 2: 멘티
  int selectedCategory = 0; // 0: 전체, ...

  List<Post> get filteredPosts {
    List<Post> filtered = allPosts;
    if (selectedTab != 0) {
      filtered = filtered
          .where((p) => p.type == tabTypes[selectedTab])
          .toList();
    }
    if (selectedCategory != 0) {
      filtered = filtered
          .where((p) => p.category == categories[selectedCategory])
          .toList();
    }
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCF8FF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '경로 검색',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '이동하실 경로를 검색해 주세요',
                          style: TextStyle(
                            color: Color(0xFFB0B0B0),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications_none),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        TextField(
                          decoration: InputDecoration(
                            hintText: '출발지',
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          decoration: InputDecoration(
                            hintText: '도착지',
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  SizedBox(
                    height: 72,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF7367F0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {},
                      child: const Text(
                        '검색',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: List.generate(
                  tabTypes.length,
                  (idx) => GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTab = idx;
                      });
                    },
                    child: _TabButton(
                      text: tabTypes[idx],
                      selected: selectedTab == idx,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    categories.length,
                    (idx) => GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = idx;
                        });
                      },
                      child: _CategoryChip(
                        text: categories[idx],
                        selected: selectedCategory == idx,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: filteredPosts.isEmpty
                    ? const Center(
                        child: Text(
                          '게시글이 없습니다.',
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    : ListView.separated(
                        itemCount: filteredPosts.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, idx) {
                          final post = filteredPosts[idx];
                          return Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.03),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: post.type == '멘토'
                                            ? Color(0xFF7367F0)
                                            : Color(0xFFB9B6F3),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        post.type,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF2F2F2),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        post.category,
                                        style: const TextStyle(
                                          color: Colors.black87,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  post.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  post.content,
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF7367F0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    '게시글 등록',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class Post {
  final String title;
  final String type; // 전체/멘토/멘티
  final String category; // 전체/서비스기획/개발/...
  final String content;
  Post({
    required this.title,
    required this.type,
    required this.category,
    required this.content,
  });
}

class _TabButton extends StatelessWidget {
  final String text;
  final bool selected;
  const _TabButton({required this.text, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFB9B6F3) : const Color(0xFFEDEBFB),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: selected ? Colors.white : const Color(0xFF7367F0),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String text;
  final bool selected;
  const _CategoryChip({required this.text, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? Colors.black : Colors.white,
          border: Border.all(color: const Color(0xFFB0B0B0)),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: selected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
