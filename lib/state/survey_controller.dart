import 'package:get/get.dart';

class SurveyController extends GetxController {
  static SurveyController get to {
    if (Get.isRegistered<SurveyController>()) {
      return Get.find<SurveyController>();
    }
    return Get.put(SurveyController(), permanent: true);
  }

  String? relationshipCategory; // '가족' | '연인' | '반려동물' | '친구'
  String? relationshipDetail; // 가족 세부 선택 등
  String? desiredWords; // 이별 상대에게 듣고 싶은 말
  DateTime? breakupDate; // 선택한 이별 날짜
}
