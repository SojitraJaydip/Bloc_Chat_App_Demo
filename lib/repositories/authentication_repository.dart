import 'package:chat_app_elision/providers/authentication_provider.dart';
import 'package:chat_app_elision/providers/base_providers.dart';
import 'package:chat_app_elision/repositories/base_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationRepository extends BaseRepository {
  BaseAuthenticationProvider authenticationProvider = AuthenticationProvider();

  Future<User> signInWithGoogle() => authenticationProvider.signInWithGoogle();

  Future<void> signOutUser() => authenticationProvider.signOutUser();

  User getCurrentUser() => authenticationProvider.getCurrentUser();

  bool isLoggedIn() => authenticationProvider.isLoggedIn();

  @override
  void dispose() {
    authenticationProvider.dispose();
  }
}
