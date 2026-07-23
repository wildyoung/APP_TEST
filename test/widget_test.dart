import 'package:app_test/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('version 1.4 design is visible and confirm button works', (
    tester,
  ) async {
    await tester.pumpWidget(const AppTestApp());

    expect(find.text('LIVE UPDATE'), findsOneWidget);
    expect(find.text('A fresh update\nhas landed!'), findsOneWidget);
    expect(find.text('VERSION 1.4.3'), findsOneWidget);
    expect(find.text('Current version'), findsOneWidget);
    expect(find.text('1.4.3'), findsOneWidget);
    expect(find.text('Confirm version 1.4.3'), findsOneWidget);

    await tester.ensureVisible(find.byKey(const Key('verify-button')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('verify-button')));
    await tester.pump();

    expect(find.text('Confirmed (1)'), findsOneWidget);
    expect(find.text('Version 1.4.3 is installed and ready.'), findsOneWidget);
  });
}
