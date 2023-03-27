import 'package:chat_app_elision/models/contact.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ContactsEvent {
  ContactsEvent([List props = const <dynamic>[]]);
}

// Fetch the contacts from firebase
class FetchContactsEvent extends ContactsEvent {
  @override
  String toString() => 'FetchContactsEvent';
}

// Dispatch received contacts from stream
class ReceivedContactsEvent extends ContactsEvent {
  final List<Contact> contacts;
  ReceivedContactsEvent(this.contacts) : super([contacts]);
  @override
  String toString() => 'ReceivedContactsEvent';
}

//Add a new contact
class AddContactEvent extends ContactsEvent {
  final String username;
  AddContactEvent({@required this.username}) : super([username]);
  @override
  String toString() => 'AddContactEvent';
}
