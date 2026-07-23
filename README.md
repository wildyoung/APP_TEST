# APP_TEST

Flutter로 만든 Firebase App Distribution 배포 테스트 앱입니다. GitHub Actions가 앱을 검사하고 Android release APK를 빌드하며, 수동 실행 시 등록된 Firebase 테스터 그룹으로 APK를 배포합니다.

## 구성

- Flutter 3.44.7 / Dart 3.12
- Android 애플리케이션 ID: `com.wildyoung.app_test`
- Firebase CLI 15.24.0
- GitHub Actions 수동 배포(`workflow_dispatch`)
- Firebase App Distribution Android SDK 인앱 업데이트 알림
- 위젯 테스트 및 정적 분석

`android/` 폴더는 Flutter 버전과의 불일치를 방지하기 위해 저장소에 커밋하지 않습니다. CI가 고정된 Flutter 버전으로 공식 Android runner를 생성한 후 APK를 빌드합니다.

## 현재 배포 상태

2026-07-23에 Firebase 프로젝트 구성과 첫 App Distribution 배포를 완료했습니다.

| 항목 | 값 |
| --- | --- |
| Firebase 프로젝트 ID | `wildyoung-app-test-20260723` |
| Android 패키지 | `com.wildyoung.app_test` |
| 테스터 그룹 별칭 | `app-test-testers` |
| CI 서비스 계정 | `app-distribution-ci@wildyoung-app-test-20260723.iam.gserviceaccount.com` |
| 첫 배포 결과 | [GitHub Actions 실행 #29971667388](https://github.com/wildyoung/APP_TEST/actions/runs/29971667388) |
| Firebase 릴리스 | [App Distribution Console](https://console.firebase.google.com/project/wildyoung-app-test-20260723/appdistribution/app/android:com.wildyoung.app_test/releases/4ti1lu1o1n6jg) |

## Firebase 설정

다음 초기 설정은 완료된 상태입니다.

1. Firebase 프로젝트 `wildyoung-app-test-20260723` 생성
2. Android 앱 `com.wildyoung.app_test` 등록
3. App Distribution 테스터 그룹 `app-test-testers` 생성
4. CI 서비스 계정에 **Firebase App Distribution Admin** 역할 부여
5. GitHub Actions Secret과 Variable 등록

배포용 `firebase` Android flavor에는 Firebase App Distribution Android SDK가 연결되어 있습니다. 앱이 실행될 때 테스터 로그인을 확인하고 새 릴리스가 있으면 기본 업데이트 대화상자를 표시합니다. 이 SDK에는 자동 업데이트 기능이 포함되어 있으므로 Google Play 배포용 flavor에는 포함하지 않아야 합니다.

인앱 업데이트 알림을 처음 사용하기 전에 Google Cloud Console에서 Firebase App Testers API를 한 번 활성화해야 합니다. [Firebase App Distribution 알림 설정 안내](https://firebase.google.com/docs/app-distribution/set-up-alerts?platform=android)

## GitHub Actions 값 등록

저장소의 **Settings → Secrets and variables → Actions**에 다음 값이 등록되어 있습니다.

| 종류 | 이름 | 값 |
| --- | --- | --- |
| Repository secret | `FIREBASE_APP_ID` | Firebase 프로젝트 설정에 표시되는 Android App ID (`1:...:android:...`) |
| Repository secret | `FIREBASE_SERVICE_ACCOUNT` | App Distribution Admin 역할을 가진 CI 서비스 계정 JSON |
| Repository variable | `FIREBASE_TESTER_GROUPS` | `app-test-testers` |

서비스 계정 키의 로컬 임시 파일은 Secret 등록 직후 삭제했습니다.

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
flutter build apk --flavor firebase --release --build-number=1
```

`firebase` flavor는 CI가 `tool/configure-firebase-app-distribution.sh`로 Android runner와 `google-services.json`을 구성한 뒤 빌드합니다. 앱 실행 시 업데이트 확인은 Firebase App Distribution에서 배포한 APK에서만 동작하며, 일반 Flutter debug 빌드에서는 동작하지 않습니다.

테스트용 release 빌드는 GitHub Actions 캐시에 보관되는 전용 테스트 키로 서명합니다. 같은 키를 계속 사용하므로 Firebase App Distribution에서 내려받은 새 APK가 기존 테스트 앱 위에 업데이트됩니다. 실제 스토어 출시용 앱으로 전환할 때는 별도의 upload keystore와 안전한 CI Secret 구성을 추가해야 합니다.
