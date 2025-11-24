import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_skip/main.dart';

void main() {
  testWidgets('App initialization test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that the app starts (we might be in SplashScreen)
    // Just checking if we have a Material App structure
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
