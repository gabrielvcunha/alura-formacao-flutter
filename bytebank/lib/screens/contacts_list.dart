import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contact_form.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text("Contacts")),
        body: FutureBuilder<List<Contact>>(
          initialData: [],
          future: findAll(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Text("Loading"),
                    ],
                  ),
                );
                break;
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                final List<Contact> contacts = snapshot.data;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final Contact contact = contacts[index];
                    return _ContactItem(contact);
                  },
                  itemCount: contacts.length,
                );
                break;
            }
            return Text("Unknow error");
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context)
                .push(
                  MaterialPageRoute(builder: (context) => ContactForm()),
                )
                .then((newContact) => debugPrint(newContact.toString()));
          },
        ),
      );
}

class _ContactItem extends StatelessWidget {
  final Contact contact;

  _ContactItem(this.contact);

  @override
  Widget build(BuildContext context) => Card(
        child: ListTile(
          title: Text(contact.name, style: TextStyle(fontSize: 24.0)),
          subtitle: Text(contact.accountNumber.toString(),
              style: TextStyle(fontSize: 16.0)),
        ),
      );
}
