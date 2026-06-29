import 'package:flutter_test/flutter_test.dart';

import 'package:yab_flutter/main.dart';

void main() {
  testWidgets('renders the Home tab on launch', (WidgetTester tester) async {
    await tester.pumpWidget(const YabApp());
    await tester.pumpAndSettle();

    expect(find.text('Home'), findsWidgets);
    expect(find.text('Welcome to YAB. This is your starting point.'), findsOneWidget);
  });
}
