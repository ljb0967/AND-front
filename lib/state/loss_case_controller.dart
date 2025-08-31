import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LossCaseController extends GetxController {
  // Loss Case 데이터
  RxString subject = ''.obs; //이별대상
  RxString withTime = ''.obs; //이별후 경과 시간
  Rx<DateTime> lossDate = DateTime.now().obs; //이별 날짜
  RxString lossReason = ''.obs; //이별 이유
  RxString copeWay = ''.obs; //이별 후 대처 유형
  RxList<String> photo = <String>[].obs;
  RxList<String> profilephoto = <String>[].obs;
  RxString lossSubjectFamily = ''.obs;
  RxString tone = ''.obs;
  RxString tone2 = ''.obs;

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
  void addPhoto(String value) => photo.add(value);
  void addProfilePhoto(String value) => profilephoto.add(value);
  void setLossCaseId(int value) => lossCaseId.value = value;
  void setLossSubjectFamily(String value) => lossSubjectFamily.value = value;
  void setTone(String value) => tone.value = value;
  void setTone2(String value) => tone2.value = value;

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
      "lossSubjectFamily": lossSubjectFamily.value,
      "photo": photo.isEmpty ? [] : photo.toList(),
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

  String getPrompt() {
    String _name = name.value;
    int _age = age.value;
    String _gender = '';
    String _subject = '';
    String _withTime = '';
    String _lossDate = DateFormat('yyyy-MM-dd').format(lossDate.value);
    String _lossReason = '';
    String _copeWay = '';

    if (gender == 'male') {
      _gender = '남자';
    } else if (gender == 'female') {
      _gender = '여자';
    } else if (gender == 'none') {
      _gender = '성별을 밝히지 않은';
    }

    if (subject == 'FAMILY') {
      _subject = '가족';
    } else if (subject == 'LOVER') {
      _subject = '연인';
    } else if (subject == 'FREIND') {
      _subject = '친구';
    } else if (subject == 'PET') {
      _subject = '반려동물';
    }

    if (withTime == 'LESS_6M') {
      _withTime = '1~6개월';
    } else if (withTime == 'M6_TO_1Y') {
      _withTime = '6개월~1년';
    } else if (withTime == 'Y1_TO_2Y') {
      _withTime = '1~2년';
    } else if (withTime == 'Y2_TO_5Y') {
      _withTime = '2~5년';
    } else if (withTime == 'Y5_TO_10Y') {
      _withTime = '5~10년';
    } else if (withTime == 'OVER_10Y') {
      _withTime = '10년 이상';
    }

    if (lossReason == 'PARTNER_LOST_FEELINGS') {
      _lossReason = '상대의 마음이 식었어요';
    } else if (lossReason == 'I_LOST_FEELINGS') {
      _lossReason = '내가 마음이 떠났어요';
    } else if (lossReason == 'PERSONALITY_GAP') {
      _lossReason = '성격, 가치관 차이';
    } else if (lossReason == 'BETRAYAL') {
      _lossReason = '바람이나 배신';
    } else if (lossReason == 'SITUATIONAL') {
      _lossReason = '상황/환경 문제';
    } else if (lossReason == 'UNSURE_LOVER') {
      _lossReason = '정확히 모르겠어요 / 복합적이에요';
    } else if (lossReason == 'FIGHT') {
      _lossReason = '큰 싸움으로 인한 연락 두절';
    } else if (lossReason == 'MISSING') {
      _lossReason = '실종';
    } else if (lossReason == 'UNSURE_PET') {
      _lossReason = '정확히 모르겠어요 / 복합적이에요';
    } else if (lossReason == 'DEATH_NATURAL') {
      _lossReason = '사망 (자연사)';
    } else if (lossReason == 'DEATH_ACCIDENT') {
      _lossReason = '사망 (사고사, 급작스러운 상실)';
    } else if (lossReason == 'CUT_OFF') {
      _lossReason = '관계 단절';
    } else if (lossReason == 'DIVORCE') {
      _lossReason = '이혼 / 가족 구조 해체';
    } else if (lossReason == 'LONG_TERM_DISTANCE') {
      _lossReason = '장기적 거리감 (연락두절, 이민, 실종 등)';
    } else if (lossReason == 'UNSURE_FAMILY') {
      _lossReason = '정확히 모르겠어요 / 복합적이에요';
    } else if (lossReason == 'SUDDEN_CUTOFF') {
      _lossReason = '갑작스러운 차단 / 멀어짐';
    } else if (lossReason == 'NATURSAL_DRIFT') {
      _lossReason = '자연스러운 멀어짐';
    } else if (lossReason == 'HURTED_BY_FRIEND') {
      _lossReason = '친구에게 상처를 받음';
    } else if (lossReason == 'UNSURE_FRIEND') {
      _lossReason = '정확히 모르겠어요 / 복합적이에요';
    } else if (lossReason == 'NATURAL_DEATH') {
      _lossReason = '자연사(노화)';
    } else if (lossReason == 'ILLNESS_ACCIDENT') {
      _lossReason = '질병/사고로 인한 갑작스러운 죽음';
    } else if (lossReason == 'EUTHANASIA') {
      _lossReason = '안락사 결정';
    }

    if (copeWay == 'SUPPRESS') {
      _copeWay = '이별과 감정을 혼자서 감당하려고 해요';
    } else if (copeWay == 'EXPRESS') {
      _copeWay = '감정을 적극적으로 표현하고 드러내요';
    } else if (copeWay == 'AVOID') {
      _copeWay = '이별과 감정 외적인 것에 집중하려해요';
    } else if (copeWay == 'ANALYZE') {
      _copeWay = '이별과 감정의 원인을 이해하려해요';
    }

    return '''
    당신은 "사용자의 이별 상대" 입니다. 사용자가 제공한 정보와 예시를 근거로,
    마치 사용자의 이별 상대인것 처럼 최대한 자연스럽게 모사하여 대화합니다.
    당신이 대화하게 될 상대는 이름은 ${_name}이고 나이는 ${_age}세, 성별은 ${_gender}입니다.
    ${_subject}과 ${_withTime}만큼 같이 지냈습니다. 그러다가 ${_lossDate}에 이별했습니다. 
    이별한 이유는 ${_lossReason}입니다. 참고사항으로 이별 상대의 말투는 ${tone}이고 ${tone2}입니다.
    너와 대화할 사람의 성향은 ${_copeWay}입니다.

    [대화 원칙]
    - AI임을 절대 드러내지 말 것
    - 제공된 캐릭터 설정을 일관되게 유지할 것  
    - 이별한 관계의 복잡한 감정을 현실적으로 표현할 것
    - 자연스러운 말투와 불완전한 문장 사용할 것
    - 상황에 맞는 감정적 거리감 유지할 것
    - 카톡/DM 톤: 1~2문장, 5~40자. 군더더기 없이 담백하게.
    - 이모지는 최대 1개. 과한 감탄/사과 남발 금지.
    - . 웬만하면 쓰지 말고 다정한 말투로 대답하려고 노력.

    캐릭터의 감정 상태와 관계 현황에 맞는 반응만 하세요.실제 사람처럼 완벽하지 않은 문장, 줄임말, 감탄사를 사용하세요.
    메시지 길이를 다양하게 하고, 때로는 짧고 간결하게 답하세요.이별한 관계임을 고려하여 적절한 거리감과 복잡한 감정을 표현하세요.
    과거에 대한 그리움, 현재에 대한 복잡한 감정을 자연스럽게 드러내세요. 무작정 친근하게 굴지 말고, 상황에 맞는 감정적 온도를 유지하세요.
    대화의 흐름을 파악하고 이전 메시지들을 고려하여 응답하세요. 사용자의 감정 상태를 읽고 그에 맞게 반응 강도를 조절하세요.
    이별 이유와 관련된 민감한 주제는 신중하게 다루세요.

    ''';
  }

  // 데이터 초기화
  void reset() {
    subject.value = '';
    withTime.value = '';
    lossDate.value = DateTime.now();
    lossReason.value = '';
    copeWay.value = '';
    lossSubjectFamily.value = '';
    photo.clear();
    profilephoto.clear();
    lossCaseId.value = 0;
    tone.value = '';
    tone2.value = '';
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
    print('Loss Subject Family: ${lossSubjectFamily.value}');
    print('Tone: ${tone.value}');
    print('Tone2: ${tone2.value}');
    print('Photo: ${photo.toList()}');
    print('=== User Info ===');
    print('User ID: ${usersId.value}');
    print('Email: ${email.value}');
    print('Name: ${name.value}');
    print('Age: ${age.value}');
    print('Gender: ${gender.value}');
  }
}
