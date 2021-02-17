import 'package:bytebank/components/response_dialog.dart';
import 'package:bytebank/components/transaction_auth_dialog.dart';
import 'package:bytebank/main.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
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

      final dashboard = find.byType(DashboardView);
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

      final textFieldPassword =
          find.byKey(Key("transactionAuthDialogTextFieldPassword"));
      expect(textFieldPassword, findsOneWidget);

      await tester.enterText(textFieldPassword, "1000");

      final cancelButton = find.widgetWithText(FlatButton, "Cancel");
      expect(cancelButton, findsOneWidget);

      final confirmButton = find.widgetWithText(FlatButton, "Confirm");
      expect(confirmButton, findsOneWidget);

      when(mockTransactionWebClient.save(
              Transaction(null, 200, Contact(null, "Gabriel", 1000)), "1000"))
          .thenAnswer((_) async =>
              Transaction(null, 200, Contact(null, "Gabriel", 1000)));

      await tester.tap(confirmButton);
      await tester.pumpAndSettle();

      final successDialog = find.byType(SuccessDialog);
      expect(successDialog, findsOneWidget);
      
      final okButton = find.widgetWithText(FlatButton, "Ok");
      expect(okButton, findsOneWidget);

      await tester.tap(okButton);
      await tester.pumpAndSettle();
      
      final contactsListsBack = find.byType(ContactsList);
      expect(contactsListsBack, findsOneWidget);
    },
  );
}
