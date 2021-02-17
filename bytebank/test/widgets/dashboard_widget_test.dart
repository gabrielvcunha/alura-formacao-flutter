import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../matchers/matchers.dart';

void main() {
  group('When Dashboard is opened', () {
    testWidgets(
      "Should display bank logo",
          (tester) async {
        await tester.pumpWidget(MaterialApp(home: DashboardContainer()));
        final mainImage = find.byType(Image);
        expect(mainImage, findsOneWidget);
      },
    );

    testWidgets(
      "Should display the transfer feature",
          (tester) async {
        await tester.pumpWidget(MaterialApp(home: DashboardContainer()));

        final transferFeatureItem = find.byWidgetPredicate(
              (widget) =>
              featureItemMatcher(widget, "Transfer", Icons.monetization_on),
        );

        expect(transferFeatureItem, findsOneWidget);
      },
    );

    testWidgets(
      "Should display the transaction feed feature",
          (tester) async {
        await tester.pumpWidget(MaterialApp(home: DashboardContainer()));

        final transferFeatureItem = find.byWidgetPredicate(
              (widget) =>
              featureItemMatcher(widget, "Transaction Feed", Icons.description),
        );

        expect(transferFeatureItem, findsOneWidget);
      },
    );
  });


}
