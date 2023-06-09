import 'dart:io';
import 'package:chat_app_elision/models/messio_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationState {
  AuthenticationState([List props = const <dynamic>[]]);
}

class Uninitialized extends AuthenticationState {
  @override
  String toString() => 'Uninitialized';
}

class AuthInProgress extends AuthenticationState {
  @override
  String toString() => 'AuthInProgress';
}

class Authenticated extends AuthenticationState {
  final User user;
  Authenticated(this.user);
  @override
  String toString() => 'Authenticated';
}

class PreFillData extends AuthenticationState {
  final MessioUser user;
  PreFillData(this.user);
  @override
  String toString() => 'PreFillData';
}

class UnAuthenticated extends AuthenticationState {
  @override
  String toString() => 'UnAuthenticated';
}

class ReceivedProfilePicture extends AuthenticationState {
  final File file;
  ReceivedProfilePicture(this.file);
  @override
  toString() => 'ReceivedProfilePicture';
}

class ProfileUpdateInProgress extends AuthenticationState {
  @override
  String toString() => 'ProfileUpdateInProgress';
}

class ProfileUpdated extends AuthenticationState {
  @override
  String toString() => 'ProfileComplete';
}
