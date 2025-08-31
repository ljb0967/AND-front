import 'package:get/get.dart';

class ChatController extends GetxController {
  // chat 데이터
  RxInt id = 0.obs;
  RxInt chatRoomId = 0.obs;
  RxString sender = ''.obs;
  RxString text = ''.obs;
  Rx<DateTime> createAt = DateTime.now().obs;
  Rx<DateTime> updateAt = DateTime.now().obs;
  RxString profileName = '사랑하는 우리 아빠'.obs;
  RxString profileImage = ''.obs;

  // chat 데이터 설정
  void setId(int value) => id.value = value;
  void setChatRoomId(int value) => chatRoomId.value = value;
  void setSender(String value) => sender.value = value;
  void setText(String value) => text.value = value;
  void setCreatedAt(DateTime value) => createAt.value = value;
  void setUpdatedAt(DateTime value) => updateAt.value = value;
  void setProfileName(String value) => profileName.value = value;
  void setProfileImage(String value) => profileImage.value = value;

  // // 사용자 정보 설정
  // void setUserInfo({
  //   int? usersId,
  //   String? email,
  //   String? pw,
  //   String? name,
  //   int? age,
  //   String? gender,
  // }) {
  //   if (usersId != null) this.usersId.value = usersId;
  //   if (email != null) this.email.value = email;
  //   if (pw != null) this.pw.value = pw;
  //   if (name != null) this.name.value = name;
  //   if (age != null) this.age.value = age;
  //   if (gender != null) this.gender.value = gender;
  // }

  // API 요청용 데이터 생성
  Map<String, dynamic> toJson() {
    return {'sender': sender.value, 'text': text.value};
  }

  // 데이터 초기화
  void reset() {
    id.value = 0;
    chatRoomId.value = 0;
    sender.value = '';
    text.value = '';
    createAt.value = DateTime.now();
    updateAt.value = DateTime.now();
  }

  // 현재 데이터 상태 출력
  void printCurrentData() {
    print('=== Chat Data ===');
    print('ID: $id');
    print('Chat Room ID: $chatRoomId');
    print('Sender: $sender');
    print('Text: $text');
    print('Created At: $createAt');
    print('Updated At: $updateAt');
    print('Profile Name: $profileName');
  }
}
