import 'package:bytebank/components/transaction_auth_dialog.dart';
import 'package:bytebank/main.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contacts_list.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:bytebank/screens/transaction_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../matchers/matchers.dart';
import '../mocks/mocks.dart';
import 'actions.dart';

void main() {
  testWidgets(
    "Should transfer to a contact",
    (tester) async {
      final MockContactDao mockContactDao = MockContactDao();
      final MockTransactionWebClient mockTransactionWebClient =
          MockTransactionWebClient();
      await tester.pumpWidget(BytebankApp(
        transactionWebClient: mockTransactionWebClient,
        contactDAO: mockContactDao,
      ));

      final dashboard = find.byType(Dashboard);
      expect(dashboard, findsOneWidget);

      when(mockContactDao.findAll()).thenAnswer((realInvocation) async {
        return <Contact>[Contact(0, "Gabriel", 1000)];
      });

      await clickOnTransferFeatureItem(tester);
      await tester.pumpAndSettle();

      final contactsList = find.byType(ContactsList);
      expect(contactsList, findsOneWidget);

      verify(mockContactDao.findAll()).called(1);

      final contactItem = find.byWidgetPredicate(
        (widget) {
          if (widget is ContactItem) {
            return widget.contact.name == "Gabriel" &&
                widget.contact.accountNumber == 1000;
          }
          return false;
        },
      );
      expect(contactItem, findsOneWidget);

      await tester.tap(contactItem);
      await tester.pumpAndSettle();

      final transactionForm = find.byType(TransactionForm);
      expect(transactionForm, findsOneWidget);

      final contactName = find.text("Gabriel");
      expect(contactName, findsOneWidget);

      final accountNumber = find.text("1000");
      expect(accountNumber, findsOneWidget);

      final textFieldValue = find.byWidgetPredicate(
        (widget) {
          return textFieldByLabelTextMatcher(widget, "Value");
        },
      );
      expect(textFieldValue, findsOneWidget);
      
      await tester.enterText(textFieldValue, "200");
      
      final transferButton = find.widgetWithText(RaisedButton, "Transfer");
      expect(transferButton, findsOneWidget);

      await tester.tap(transferButton);
      await tester.pumpAndSettle();

      final transactionAuthDialog = find.byType(TransactionAuthDialog);
      expect(transactionAuthDialog, findsOneWidget);
    },
  );
}
