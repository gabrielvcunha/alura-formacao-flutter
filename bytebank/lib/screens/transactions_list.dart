import 'package:bytebank/components/centered_message.dart';
import 'package:bytebank/components/progress.dart';
import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:bytebank/models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionsList extends StatelessWidget {
  final TransactionWebClient _webClient = new TransactionWebClient();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text('Transactions')),
        body: FutureBuilder<List<Transaction>>(
          future: _webClient.findAll(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                return Progress(
                  message: "Loading Transactions",
                );
                break;
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                if (snapshot.hasData) {
                  final List<Transaction> transactions = snapshot.data;
                  if (transactions.isNotEmpty) {
                    return ListView.builder(
                      itemCount: transactions.length,
                      itemBuilder: (context, index) {
                        final Transaction transaction = transactions[index];
                        return Card(
                          child: ListTile(
                            leading: Icon(Icons.monetization_on),
                            title: Text(
                              transaction.value.toString(),
                              style: TextStyle(
                                  fontSize: 24.0, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              transaction.contact.accountNumber.toString(),
                              style: TextStyle(fontSize: 16.0),
                            ),
                          ),
                        );
                      },
                    );
                  }
                }

                return CenteredMessage("No transactions found",
                    icon: Icons.warning);
                break;
            }
            return CenteredMessage("Unknown error", icon: Icons.error);
          },
        ),
      );
}
