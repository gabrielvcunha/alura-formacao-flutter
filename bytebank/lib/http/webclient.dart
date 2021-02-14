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

Future<List<Transaction>> findAll() async {
  final Client client =
      HttpClientWithInterceptor.build(interceptors: [LoggingInterceptor()]);
  final Response response =
      await client.get("http://192.168.0.5:8080/transactions");

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
