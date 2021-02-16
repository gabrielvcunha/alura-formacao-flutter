
import 'package:bytebank/main.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contacts_list.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:bytebank/screens/transaction_form.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mocks/mocks.dart';
import 'actions.dart';

void main() {
  testWidgets(
    "Should transfer to a contact",
    (tester) async {
      final MockContactDao mockContactDao = MockContactDao();
      await tester.pumpWidget(BytebankApp(
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
    },
  );
}