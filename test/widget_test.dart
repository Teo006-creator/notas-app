import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:appmovilwidgets/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const NotaApp());
    expect(find.text('Mis Notas'), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });
}