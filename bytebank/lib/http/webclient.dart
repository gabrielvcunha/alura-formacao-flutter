import 'dart:convert';

import 'package:bytebank/models/contact.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

class LoggingInterceptor implements InterceptorContract {
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    print("Request");
    print("method: ${data.method}");
    print("url: ${data.url}");
    print("headers: ${data.headers}");
    print("body: ${data.body}");
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
    print("Response");
    print("status: ${data.statusCode}");
    print("headers: ${data.headers}");
    print("body: ${data.body}");
    return data;
  }
}

final Client client =
HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);

Future<List<Transaction>> findAll() async {
  final Response response = await client
      .get("http://192.168.0.5:8080/transactions")
      .timeout(Duration(seconds: 5));

  final List<dynamic> decodedJson = jsonDecode(response.body);

  final List<Transaction> transactions = [];
  for (Map<String, dynamic> element in decodedJson) {
    transactions.add(Transaction(
      element['value'],
      Contact(
        0,
        element['contact']['name'],
        element['contact']['accountNumber'],
      ),
    ));
  }
  return transactions;
}

Future<Transaction> save(Transaction transaction) async {
  final Map<String, dynamic> transactionMap = {
    "value": transaction.value,
    "contact": {
      "name": transaction.contact.name,
      "accountNumber": transaction.contact.accountNumber
    }
  };
  final String transactionJson = jsonEncode(transactionMap);

  final Response response = await client.post(
      "http://192.168.0.5:8080/transactions",
      headers: {"Content-type": "application/json", "password": "1000"},
      body: transactionJson
  );

  Map<String, dynamic> json = jsonDecode(response.body);

  return Transaction(
    json['value'],
    Contact(
      0,
      json['contact']['name'],
      json['contact']['accountNumber'],
    ),
  );
}
