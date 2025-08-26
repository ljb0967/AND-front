import 'package:get/get.dart';

class UserController extends GetxController {
  // 사용자 정보
  RxString accessToken = ''.obs;
  RxString tokenType = 'Bearer'.obs;
  RxInt userId = 0.obs;
  RxString userPassword = ''.obs;
  RxString userEmail = ''.obs;
  RxString userName = ''.obs;
  RxInt userAge = 0.obs;
  RxString userGender = ''.obs;
  RxBool isLoggedIn = false.obs;

  // 로그인 정보 저장
  void setLoginData(Map<String, dynamic> responseData, String userPassword) {
    this.userPassword.value = userPassword;
    if (responseData['accessToken'] != null) {
      accessToken.value = responseData['accessToken'];
      tokenType.value = responseData['tokenType'] ?? 'Bearer';
    }

    if (responseData['user'] != null) {
      final user = responseData['user'];
      userId.value = user['userId'] ?? 0;
      userEmail.value = user['email'] ?? '';
      userName.value = user['name'] ?? '';
      userAge.value = user['age'] ?? 0;
      userGender.value = user['gender'] ?? '';
    }

    isLoggedIn.value = true;

    print('사용자 정보 저장 완료: ${userEmail.value}');
  }

  // 로그아웃
  void logout() {
    accessToken.value = '';
    tokenType.value = 'Bearer';
    userId.value = 0;
    userEmail.value = '';
    userName.value = '';
    userAge.value = 0;
    userGender.value = '';
    isLoggedIn.value = false;

    print('사용자 정보 초기화 완료');
  }

  // 인증 헤더 가져오기
  Map<String, String> getAuthHeaders() {
    if (accessToken.value.isNotEmpty) {
      return {
        'Authorization': '${tokenType.value} ${accessToken.value}',
        'Content-Type': 'application/json',
      };
    }
    return {'Content-Type': 'application/json'};
  }

  // 로그인 상태 확인
  bool get isUserLoggedIn => isLoggedIn.value;
}
