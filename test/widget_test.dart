import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:kulinarent_2026/main.dart';

void main() {
  testWidgets('KulinaRent app loads successfully',
      (WidgetTester tester) async {
    // Build app
    await tester.pumpWidget(const KulinaRentApp());

    // Pastikan MaterialApp ada
    expect(find.byType(MaterialApp), findsOneWidget);

    // Pastikan SplashScreen tampil (logo/text)
    expect(find.text('KulinaRent'), findsOneWidget);
  });
}
