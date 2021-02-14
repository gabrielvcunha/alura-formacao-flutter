import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/models/contact.dart';
import 'package:sqflite/sqflite.dart';

class ContactDAO {
  static const String tableSQL = "CREATE TABLE contacts("
      "id INTEGER PRIMARY KEY, "
      "name TEXT, "
      "account_number INTEGER)";

  Future<int> save(Contact contact) async {
    final Database db = await getDatabase();
    Map<String, dynamic> contactMap = _toMap(contact);
    return db.insert("contacts", contactMap);
  }

  Future<List<Contact>> findAll() async {
    final Database db = await getDatabase();
    List<Contact> contacts = await _toList(db);
    return contacts;
  }

  Map<String, dynamic> _toMap(Contact contact) {
    final Map<String, dynamic> contactMap = Map();
    contactMap['name'] = contact.name;
    contactMap['account_number'] = contact.accountNumber;
    return contactMap;
  }

  Future<List<Contact>> _toList(Database db) async {
    final List<Contact> contacts = [];
    for (Map<String, dynamic> row in await db.query("contacts")) {
      final Contact contact =
      Contact(row['id'], row['name'], row['account_number']);
      contacts.add(contact);
    }
    return contacts;
  }
}