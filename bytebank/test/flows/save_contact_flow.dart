import 'package:bytebank/main.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contact_form.dart';
import 'package:bytebank/screens/contacts_list.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../matchers/matchers.dart';
import '../mocks/mocks.dart';
import 'actions.dart';

void main() {
  testWidgets(
    "Should save a contact",
    (tester) async {
      final MockContactDao mockContactDao = MockContactDao();
      await tester.pumpWidget(BytebankApp(
        transactionWebClient: null,
        contactDAO: mockContactDao,
      ));

      final dashboard = find.byType(DashboardView);
      expect(dashboard, findsOneWidget);

      await clickOnTransferFeatureItem(tester);
      await tester.pumpAndSettle();

      final contactsList = find.byType(ContactsList);
      expect(contactsList, findsOneWidget);

      verify(mockContactDao.findAll()).called(1);

      final newContactButton =
          find.widgetWithIcon(FloatingActionButton, Icons.add);
      expect(newContactButton, findsOneWidget);

      await tester.tap(newContactButton);
      await tester.pumpAndSettle();

      final contactForm = find.byType(ContactForm);
      expect(contactForm, findsOneWidget);

      final nameTextField = find.byWidgetPredicate(
          (widget) => textFieldByLabelTextMatcher(widget, "Full name"));
      expect(nameTextField, findsOneWidget);

      await tester.enterText(nameTextField, "Eduardo");

      final accountNumberTextField = find.byWidgetPredicate(
          (widget) => textFieldByLabelTextMatcher(widget, "Account number"));
      expect(accountNumberTextField, findsOneWidget);

      await tester.enterText(accountNumberTextField, "9999");

      final createButton = find.widgetWithText(RaisedButton, "Create");
      expect(createButton, findsOneWidget);

      await tester.tap(createButton);
      await tester.pumpAndSettle();

      verify(mockContactDao.save(Contact(0, "Eduardo", 9999)));

      final contactsListBack = find.byType(ContactsList);
      expect(contactsListBack, findsOneWidget);

      verify(mockContactDao.findAll());
    },
  );
}
