import 'package:get/get.dart';

class CardController extends GetxController {
  // 북마크된 카드 ID들을 저장하는 Set
  final RxSet<int> _bookmarkedCardIds = <int>{}.obs;
  final RxSet<int> _favoriteCardIds = <int>{}.obs;

  // 북마크된 카드 데이터를 저장하는 List
  final RxList<Map<String, dynamic>> _bookmarkedCards =
      <Map<String, dynamic>>[].obs;
  final RxList<Map<String, dynamic>> _favoriteCards =
      <Map<String, dynamic>>[].obs;
  // 북마크 상태 확인
  bool isBookmarked(int cardIndex) {
    return _bookmarkedCardIds.contains(cardIndex);
  }

  bool isFavorite(int cardIndex) {
    return _favoriteCardIds.contains(cardIndex);
  }

  // 북마크 토글 (카드 데이터와 함께)
  void toggleBookmark(int cardIndex, Map<String, dynamic> cardData) {
    try {
      if (_bookmarkedCardIds.contains(cardIndex)) {
        _bookmarkedCardIds.remove(cardIndex);
        // 북마크된 카드 데이터에서도 제거
        _bookmarkedCards.removeWhere((card) => card['cardIndex'] == cardIndex);
      } else {
        _bookmarkedCardIds.add(cardIndex);
        // 북마크된 카드 데이터에 추가 (안전하게 복사)
        final cardWithIndex = <String, dynamic>{};

        // 필수 필드들을 안전하게 복사
        cardWithIndex['cardIndex'] = cardIndex;
        cardWithIndex['profileImage'] =
            cardData['profileImage'] ?? 'image/character1.png';
        cardWithIndex['userName'] = cardData['userName'] ?? '사용자';
        cardWithIndex['date'] = cardData['date'] ?? '';
        cardWithIndex['title'] = cardData['title'] ?? '';
        cardWithIndex['hashtags'] = cardData['hashtags'] ?? [];
        cardWithIndex['backgroundImage'] =
            cardData['backgroundImage'] ?? 'image/ex_photo.png';
        cardWithIndex['content'] = cardData['content'] ?? '';

        _bookmarkedCards.add(cardWithIndex);
      }
    } catch (e) {
      print('좋아요 토글 에러: $e');
    }
  }

  void toggleFavorite(int cardIndex, Map<String, dynamic> cardData) {
    try {
      if (_favoriteCardIds.contains(cardIndex)) {
        _favoriteCardIds.remove(cardIndex);
        // 북마크된 카드 데이터에서도 제거
        _favoriteCards.removeWhere((card) => card['cardIndex'] == cardIndex);
      } else {
        _favoriteCardIds.add(cardIndex);
        // 북마크된 카드 데이터에 추가 (안전하게 복사)
        final cardWithIndex = <String, dynamic>{};

        // 필수 필드들을 안전하게 복사
        cardWithIndex['cardIndex'] = cardIndex;
        cardWithIndex['profileImage'] =
            cardData['profileImage'] ?? 'image/character1.png';
        cardWithIndex['userName'] = cardData['userName'] ?? '사용자';
        cardWithIndex['date'] = cardData['date'] ?? '';
        cardWithIndex['title'] = cardData['title'] ?? '';
        cardWithIndex['hashtags'] = cardData['hashtags'] ?? [];
        cardWithIndex['backgroundImage'] =
            cardData['backgroundImage'] ?? 'image/ex_photo.png';
        cardWithIndex['content'] = cardData['content'] ?? '';

        _bookmarkedCards.add(cardWithIndex);
      }
    } catch (e) {
      print('북마크 토글 에러: $e');
    }
  }

  // 북마크된 카드 ID 목록 가져오기
  Set<int> get bookmarkedCardIds => _bookmarkedCardIds.toSet();
  Set<int> get favoriteCardIds => _favoriteCardIds.toSet();

  // 북마크된 카드 데이터 목록 가져오기
  List<Map<String, dynamic>> get bookmarkedCards => _bookmarkedCards.toList();
  List<Map<String, dynamic>> get favoriteCards => _favoriteCards.toList();

  // 북마크된 카드 개수
  int get bookmarkedCount => _bookmarkedCardIds.length;
  int get favoriteCount => _favoriteCardIds.length;
}
