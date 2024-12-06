import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MyHomePage has a title', (WidgetTester tester) async {
    // Build MyHomePage and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: MyHomePage(title: 'Welcome to HappyCart'),
      ),
    );

    // Verify if MyHomePage displays the correct title.
    expect(find.text('Welcome to HappyCart'), findsOneWidget);
    expect(find.text('Non-existent Title'), findsNothing);
  });
}
