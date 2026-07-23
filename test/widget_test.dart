import 'package:app_test/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('업데이트 디자인이 표시되고 확인 버튼이 동작한다', (tester) async {
    await tester.pumpWidget(const AppTestApp());

    expect(find.text('UPDATE TEST  •  v1.2.0'), findsOneWidget);
    expect(find.text('새로운 화면으로\n업데이트됐어요'), findsOneWidget);
    expect(find.text('현재 버전'), findsOneWidget);
    expect(find.text('1.2.0'), findsOneWidget);
    expect(find.text('업데이트 완료 확인'), findsOneWidget);

    await tester.tap(find.byKey(const Key('verify-button')));
    await tester.pump();

    expect(find.text('확인 완료 (1)'), findsOneWidget);
    expect(find.text('1.2.0 업데이트가 정상적으로 적용됐습니다.'), findsOneWidget);
  });
}
