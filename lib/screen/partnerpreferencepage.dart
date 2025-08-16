import 'package:flutter/material.dart';
import 'routesearchpage.dart';

class PartnerPreferencePage extends StatefulWidget {
  const PartnerPreferencePage({super.key});

  @override
  State<PartnerPreferencePage> createState() => _PartnerPreferencePageState();
}

class _PartnerPreferencePageState extends State<PartnerPreferencePage> {
  final List<String> options = [
    '이직 준비',
    '커리어 방향 설정',
    '업계 동향 파악',
    '창업 및 투자 조언',
    '해외 커리어 탐색',
    '공고 문의',
  ];

  // 2, 3번째 항목만 선택된 상태로 초기화
  late List<bool> selected;

  @override
  void initState() {
    super.initState();
    selected = [false, false, false, false, false, false];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 0, // 상단 여백만 남기고 AppBar 숨김
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text(
                '희망하는 파트너 성향',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 4),
              const Text(
                '자신의 정보를 정확하게 작성해 주세요',
                style: TextStyle(color: Color(0xFFB0B0B0), fontSize: 12),
              ),
              const SizedBox(height: 36),
              Expanded(
                child: ListView.separated(
                  itemCount: options.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, idx) {
                    return InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        setState(() {
                          selected[idx] = !selected[idx];
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.favorite,
                              color: selected[idx]
                                  ? Color(0xFF4CAF50) // 초록색
                                  : Color(0xFFB0B0B0), // 회색
                            ),
                            const SizedBox(width: 12),
                            Text(
                              options[idx],
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RouteSearchPage(),
                      ),
                    );
                  },
                  child: const Text(
                    '완료',
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
