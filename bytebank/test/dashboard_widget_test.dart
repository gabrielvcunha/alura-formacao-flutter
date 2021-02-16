import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    "Should display bank logo when dashboard is open",
    (tester) async {
      await tester.pumpWidget(MaterialApp(home: Dashboard()));
      final mainImage = find.byType(Image);
      expect(mainImage, findsOneWidget);
    },
  );

  testWidgets(
    "Should display the transfer feature when dashboard is open",
    (tester) async {
      await tester.pumpWidget(MaterialApp(home: Dashboard()));
      final transferFeature = find.widgetWithIcon(
        FeatureItem,
        Icons.monetization_on,
      );
      expect(transferFeature, findsOneWidget);
    },
  );
}
