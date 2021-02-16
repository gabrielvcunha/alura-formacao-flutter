import 'dart:convert';

import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart';

class TransactionWebClient {
  Future<List<Transaction>> findAll() async {
    final Response response =
        await client.get("http://192.168.0.5:8080/transactions");

    final List<dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson.map((json) => Transaction.fromJson(json)).toList();
  }

  Future<Transaction> save(Transaction transaction, String password) async {
    final String transactionJson = jsonEncode(transaction.toJson());

    await Future.delayed(Duration(seconds: 10));

    final Response response = await client.post(
        "http://192.168.0.5:8080/transactions",
        headers: {"Content-type": "application/json", "password": password},
        body: transactionJson);

    if (response.statusCode == 200)
      return Transaction.fromJson(jsonDecode(response.body));

    throw HttpException(_statusCodeResponses[response.statusCode]);
  }

  static final Map<int, String> _statusCodeResponses = {
    400: "There was an error on submitting the transaction",
    401: "Authentication failed"
  };
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
