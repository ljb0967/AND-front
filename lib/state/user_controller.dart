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
  RxString quest1 = ''.obs;
  RxString quest2 = ''.obs;
  RxString quest3 = ''.obs;
  List<RxBool> questComplete = [false.obs, false.obs, false.obs];
  RxString qna = ''.obs;
  RxInt qnaId = 0.obs;
  RxInt coin = 10.obs;

  void setuserId(int value) => userId.value = value;
  void setEmail(String value) => userEmail.value = value;
  void setuserName(String value) => userName.value = value;
  void setuserAge(int value) => userAge.value = value;
  void setuserGender(String value) => userGender.value = value;
  void setquest1(String value) => quest1.value = value;
  void setquest2(String value) => quest2.value = value;
  void setquest3(String value) => quest3.value = value;
  void setquestComplete(int index, bool value) =>
      questComplete[index].value = value;
  void setqna(String value) => qna.value = value;
  void setqnaId(int value) => qnaId.value = value;
  void setcoin(int value) => coin.value = value;

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
