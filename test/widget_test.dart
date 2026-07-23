import 'package:app_test/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('앱 화면이 표시되고 실행 확인 버튼이 동작한다', (tester) async {
    await tester.pumpWidget(const AppTestApp());

    expect(find.text('Firebase App Distribution'), findsOneWidget);
    expect(find.text('Flutter 배포 테스트 앱'), findsOneWidget);
    expect(find.text('실행 확인'), findsOneWidget);

    await tester.tap(find.byKey(const Key('verify-button')));
    await tester.pump();

    expect(find.text('실행 확인 1회'), findsOneWidget);
    expect(find.text('앱이 정상적으로 실행 중입니다.'), findsOneWidget);
  });
}
