import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LossCaseController extends GetxController {
  // Loss Case 데이터
  RxString subject = ''.obs;
  RxString withTime = ''.obs;
  Rx<DateTime> lossDate = DateTime.now().obs;
  RxString lossReason = ''.obs;
  RxString copeWay = ''.obs;
  RxString photo = ''.obs;

  // 사용자 정보 (UserController에서 가져올 예정)
  RxInt usersId = 0.obs;
  RxString email = ''.obs;
  RxString pw = ''.obs;
  RxString name = ''.obs;
  RxInt age = 0.obs;
  RxString gender = ''.obs;

  // Loss Case ID
  RxInt lossCaseId = 0.obs;

  // Loss Case 데이터 설정
  void setSubject(String value) => subject.value = value;
  void setWithTime(String value) => withTime.value = value;
  void setLossDate(DateTime value) => lossDate.value = value;
  void setLossReason(String value) => lossReason.value = value;
  void setCopeWay(String value) => copeWay.value = value;
  void setPhoto(String value) => photo.value = value;
  void setLossCaseId(int value) => lossCaseId.value = value;

  // 사용자 정보 설정
  void setUserInfo({
    int? usersId,
    String? email,
    String? pw,
    String? name,
    int? age,
    String? gender,
  }) {
    if (usersId != null) this.usersId.value = usersId;
    if (email != null) this.email.value = email;
    if (pw != null) this.pw.value = pw;
    if (name != null) this.name.value = name;
    if (age != null) this.age.value = age;
    if (gender != null) this.gender.value = gender;
  }

  // API 요청용 데이터 생성
  Map<String, dynamic> toJson() {
    return {
      "lossCaseId": lossCaseId.value,
      "subject": subject.value,
      "withTime": withTime.value,
      "lossDate": DateFormat('yyyy-MM-dd').format(lossDate.value),
      "lossReason": lossReason.value,
      "copeWay": copeWay.value,
      "photo": photo.value.isEmpty ? null : photo.value,
      "users": {
        "usersId": usersId.value,
        "email": email.value,
        "pw": pw.value,
        "name": name.value,
        "age": age.value,
        "gender": gender.value,
      },
    };
  }

  // 데이터 초기화
  void reset() {
    subject.value = '';
    withTime.value = '';
    lossDate.value = DateTime.now();
    lossReason.value = '';
    copeWay.value = '';
    photo.value = '';
    usersId.value = 0;
    email.value = '';
    pw.value = '';
    name.value = '';
    age.value = 0;
    gender.value = '';
  }

  // 현재 데이터 상태 출력
  void printCurrentData() {
    print('=== Loss Case Data ===');
    print('Subject: ${subject.value}');
    print('With Time: ${withTime.value}');
    print('Loss Date: ${lossDate.value}');
    print('Loss Reason: ${lossReason.value}');
    print('Cope Way: ${copeWay.value}');
    print('Photo: ${photo.value}');
    print('=== User Info ===');
    print('User ID: ${usersId.value}');
    print('Email: ${email.value}');
    print('Name: ${name.value}');
    print('Age: ${age.value}');
    print('Gender: ${gender.value}');
  }
}
