import 'package:bytebank/main.dart';
import 'package:bytebank/screens/contact_form.dart';
import 'package:bytebank/screens/contacts_list.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'matchers.dart';
import 'mocks.dart';

void main() {
  testWidgets(
    "Should save a contact",
    (tester) async {
      await tester.pumpWidget(BytebankApp(contactDAO: MockContactDao(),));

      final dashboard = find.byType(Dashboard);
      expect(dashboard, findsOneWidget);

      final transferFeatureItem = find.byWidgetPredicate((widget) =>
          featureItemMatcher(widget, "Transfer", Icons.monetization_on));
      expect(transferFeatureItem, findsOneWidget);

      await tester.tap(transferFeatureItem);
      await tester.pumpAndSettle();

      final contactsList = find.byType(ContactsList);
      expect(contactsList, findsOneWidget);

      final newContactButton =
          find.widgetWithIcon(FloatingActionButton, Icons.add);
      expect(newContactButton, findsOneWidget);

      await tester.tap(newContactButton);
      await tester.pumpAndSettle();

      final contactForm = find.byType(ContactForm);
      expect(contactForm, findsOneWidget);
    },
  );
}
