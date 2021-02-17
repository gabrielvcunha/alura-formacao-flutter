import 'package:bytebank/screens/contacts_list.dart';
import 'package:bytebank/screens/name.dart';
import 'package:bytebank/screens/transactions_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NameCubit("Gabriel"),
      child: DashboardView(),
    );
  }
}

class DashboardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<NameCubit, String>(
          builder: (context, state) => Text("Welcome $state"),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset("images/bytebank_logo.png"),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: <FeatureItem>[
                      FeatureItem(
                        "Transfer",
                        Icons.monetization_on,
                        onClick: () => _showContactsList(context),
                      ),
                      FeatureItem(
                        "Transaction Feed",
                        Icons.description,
                        onClick: () => _showTransactionsList(context),
                      ),
                      FeatureItem(
                        "Change name",
                        Icons.person_outline,
                        onClick: () => _showChangeName(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showContactsList(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => ContactsList()),
    );
  }

  void _showTransactionsList(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => TransactionsList()),
    );
  }

  void _showChangeName(blocBontext) {
    Navigator.of(blocBontext).push(
      MaterialPageRoute(
          builder: (context) => BlocProvider.value(
                value: BlocProvider.of<NameCubit>(blocBontext),
                child: NameContainer(),
              )),
    );
  }
}

class FeatureItem extends StatelessWidget {
  final String name;
  final IconData icon;
  final Function onClick;

  FeatureItem(this.name, this.icon, {@required this.onClick})
      : assert(icon != null),
        assert(onClick != null);

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          color: Theme.of(context).primaryColor,
          child: InkWell(
            onTap: () => onClick(),
            child: Container(
              padding: EdgeInsets.all(8.0),
              height: 100,
              width: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Icon(
                    icon,
                    color: Colors.white,
                    size: 24.0,
                  ),
                  Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
