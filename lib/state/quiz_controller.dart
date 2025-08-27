import 'dart:math';
import 'package:get/get.dart';

enum AnswerOption { A, B, C, D }

class QuizResult {
  final AnswerOption winner;
  final int score;
  final Map<AnswerOption, int> scores;
  final String styleName;
  QuizResult({
    required this.winner,
    required this.score,
    required this.scores,
    required this.styleName,
  });
}

class QuizController extends GetxController {
  // 문항별 가중치: 1=5, 2=1, 3=2, 4=3
  final Map<int, int> weights = const {1: 5, 2: 1, 3: 2, 4: 3};

  // 각 문항의 선택 (null = 미선택)
  final RxMap<int, AnswerOption?> answers = <int, AnswerOption?>{
    1: null,
    2: null,
    3: null,
    4: null,
  }.obs;

  // 보기 → 유형명 (원하는대로 바꿔도 됨)
  final Map<AnswerOption, String> styleMap = const {
    AnswerOption.A: '억누르기형',
    AnswerOption.B: '회피형',
    AnswerOption.C: '표출형',
    AnswerOption.D: '분석형',
  };

  // 선택 저장
  void select(int qNo, AnswerOption option) {
    answers[qNo] = option;
  }

  // 최종 결정 (4번 화면에서 호출)
  QuizResult decide() {
    final scores = {for (final o in AnswerOption.values) o: 0};
    answers.forEach((q, opt) {
      if (opt != null) scores[opt!] = scores[opt]! + (weights[q] ?? 0);
    });

    final maxScore = scores.values.fold<int>(0, max);
    final top = scores.entries
        .where((e) => e.value == maxScore)
        .map((e) => e.key)
        .toList();
    top.shuffle(); // 동점이면 랜덤
    final winner = top.first;

    return QuizResult(
      winner: winner,
      score: maxScore,
      scores: scores,
      styleName: styleMap[winner] ?? '알 수 없음',
    );
  }
}
