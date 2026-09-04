import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:naghdeno/main.dart';

void main() {
  testWidgets('App renders main navigation and navigation items',
      (WidgetTester tester) async {
    await tester.pumpWidget(const NaghdENoApp());
    await tester.pumpAndSettle();

    expect(find.text('نقد نو | نقد و بررسی کتاب'), findsOneWidget);
    expect(find.byIcon(Icons.explore), findsOneWidget);
    expect(find.byIcon(Icons.collections_bookmark), findsOneWidget);
    expect(find.byIcon(Icons.forum), findsOneWidget);
    expect(find.byIcon(Icons.person), findsOneWidget);
  });
}
