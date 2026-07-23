# APP_TEST

Flutter로 만든 Firebase App Distribution 배포 테스트 앱입니다. GitHub Actions가 앱을 검사하고 Android release APK를 빌드하며, 수동 실행 시 등록된 Firebase 테스터 그룹으로 APK를 배포합니다.

## 구성

- Flutter 3.44.7 / Dart 3.12
- Android 애플리케이션 ID: `com.wildyoung.app_test`
- Firebase CLI 15.24.0
- GitHub Actions 수동 배포(`workflow_dispatch`)
- 위젯 테스트 및 정적 분석

`android/` 폴더는 Flutter 버전과의 불일치를 방지하기 위해 저장소에 커밋하지 않습니다. CI가 고정된 Flutter 버전으로 공식 Android runner를 생성한 후 APK를 빌드합니다.

## Firebase 최초 설정

1. [Firebase Console](https://console.firebase.google.com/)에서 프로젝트를 생성합니다.
2. Android 앱을 추가하고 패키지 이름을 정확히 `com.wildyoung.app_test`로 입력합니다. 패키지 이름은 대소문자를 구분하며 등록 후 변경할 수 없습니다.
3. Firebase Console의 **App Distribution** 메뉴에서 시작하기를 누릅니다.
4. **테스터 및 그룹**에서 테스터를 추가하고 그룹을 만듭니다. 그룹 별칭(예: `qa-team`)을 기억합니다.
5. Google Cloud Console에서 서비스 계정을 만들고 **Firebase App Distribution Admin** 역할을 부여한 뒤 JSON 키를 생성합니다.

이 앱은 Firebase 제품을 런타임에 사용하지 않으므로 `google-services.json`은 필요하지 않습니다. App Distribution 업로드에는 Firebase App ID와 CI 서비스 계정만 사용합니다.

## GitHub Actions 값 등록

저장소의 **Settings → Secrets and variables → Actions**에서 다음 값을 등록합니다.

| 종류 | 이름 | 값 |
| --- | --- | --- |
| Repository secret | `FIREBASE_APP_ID` | Firebase 프로젝트 설정에 표시되는 Android App ID (`1:...:android:...`) |
| Repository secret | `FIREBASE_SERVICE_ACCOUNT` | App Distribution Admin 역할을 가진 서비스 계정 JSON 전체 내용 |
| Repository variable | `FIREBASE_TESTER_GROUPS` | Firebase 테스터 그룹 별칭. 여러 개는 쉼표로 구분 |

서비스 계정 JSON은 가능하면 한 줄로 축소해서 Secret에 저장합니다.

```bash
jq -c . service-account.json
```

## 배포 실행

1. GitHub 저장소의 **Actions** 탭을 엽니다.
2. **Flutter Firebase App Distribution** 워크플로를 선택합니다.
3. **Run workflow**를 누르고 `distribute`를 체크한 채 실행합니다.
4. 빌드가 끝나면 Firebase App Distribution에서 릴리스와 테스터 초대 상태를 확인합니다.

`main` 브랜치 push와 Pull Request에서는 분석·테스트·APK 빌드만 수행하고 Firebase 배포는 하지 않습니다. APK는 각 Actions 실행의 Artifact에서도 내려받을 수 있습니다.

## 로컬 실행

Flutter 3.44.7 이상이 설치된 환경에서 최초 한 번 Android runner를 생성합니다.

```bash
flutter create --platforms=android --android-language=kotlin --org=com.wildyoung --project-name=app_test .
flutter pub get
flutter run
```

검사와 빌드는 다음 명령으로 실행합니다.

```bash
flutter analyze
flutter test
flutter build apk --release
```

테스트용 release 빌드는 Flutter 기본 템플릿의 debug signing key를 사용합니다. 실제 스토어 출시용 앱으로 전환할 때는 별도의 upload keystore와 안전한 CI Secret 구성을 추가해야 합니다.
