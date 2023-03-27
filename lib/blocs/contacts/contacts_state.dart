import 'package:chat_app_elision/models/contact.dart';
import 'package:chat_app_elision/utils/exceptions.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ContactsState {
  ContactsState([List props = const <dynamic>[]]);
}

class InitialContactsState extends ContactsState {
  @override
  String toString() => 'InitialContactsState';
}

//Fetching contacts from firebase
class FetchingContactsState extends ContactsState {
  @override
  String toString() => 'FetchingContactsState';
}

//contacts fetched successfully
class FetchedContactsState extends ContactsState {
  final List<Contact> contacts;
  FetchedContactsState(this.contacts) : super([contacts]);
  @override
  String toString() => 'FetchedContactsState';
}

// Add Contact Clicked, show progressbar
class AddContactProgressState extends ContactsState {
  @override
  String toString() => 'AddContactProgressState';
}

// Add contact success
class AddContactSuccessState extends ContactsState {
  @override
  String toString() => 'AddContactSuccessState';
}

// Add contact failed
class AddContactFailedState extends ContactsState {
  final MessioException exception;
  AddContactFailedState(this.exception) : super([exception]);
  @override
  String toString() => 'AddContactFailedState';
}

// Handle errors
class ErrorState extends ContactsState {
  final MessioException exception;
  ErrorState(this.exception) : super([exception]);
  @override
  String toString() => 'ErrorState';
}
