import 'package:bytebank/models/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    "Should return correct transaction value when creating a transaction",
    () {
      final transaction = Transaction(null, 200, null);
      expect(transaction.value, 200);
    },
  );
  test(
    "Should display error when creating a transaction with value equals to zero",
    () {
      expect(() => Transaction(null, 0, null), throwsAssertionError);
    },
  );
}
