import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:bytebank/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'components/theme.dart';

void main() {
  runApp(BytebankApp(
    contactDAO: ContactDAO(),
    transactionWebClient: TransactionWebClient(),
  ));
}

class LogObserver extends BlocObserver {
  @override
  void onChange(Cubit cubit, Change change) {
    print("${cubit.runtimeType} > $change");
    super.onChange(cubit, change);
  }
}

class BytebankApp extends StatelessWidget {
  final ContactDAO contactDAO;
  final TransactionWebClient transactionWebClient;

  BytebankApp({
    @required this.contactDAO,
    @required this.transactionWebClient,
  });

  @override
  Widget build(BuildContext context) {
    Bloc.observer = LogObserver();
    return AppDependencies(
        contactDAO: contactDAO,
        transactionWebClient: transactionWebClient,
        child: MaterialApp(
          theme: byteBankTheme,
          home: DashboardContainer(),
        ),
      );
  }
}
