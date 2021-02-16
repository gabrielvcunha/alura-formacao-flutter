import 'package:bytebank/main.dart';
import 'package:bytebank/screens/contacts_list.dart';
import 'package:bytebank/screens/dashboard.dart';
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

      await clickOnTransferFeatureItem(tester);
      await tester.pumpAndSettle();

      final contactsList = find.byType(ContactsList);
      expect(contactsList, findsOneWidget);

      verify(mockContactDao.findAll()).called(1);
    },
  );
}
