import 'package:chat_app_elision/models/contact.dart';
import 'package:chat_app_elision/models/messio_user.dart';
import 'package:chat_app_elision/providers/base_providers.dart';
import 'package:chat_app_elision/providers/user_data_provider.dart';
import 'package:chat_app_elision/repositories/base_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserDataRepository extends BaseRepository {
  BaseUserDataProvider userDataProvider = UserDataProvider();

  Future<MessioUser> saveDetailsFromGoogleAuth(User user) =>
      userDataProvider.saveDetailsFromGoogleAuth(user);

  Future<MessioUser> saveProfileDetails(
          String uid, String profileImageUrl, int age, String username) =>
      userDataProvider.saveProfileDetails(profileImageUrl, age, username);

  Future<bool> isProfileComplete() => userDataProvider.isProfileComplete();

  Stream<List<Contact>> getContacts() => userDataProvider.getContacts();

  Future<void> addContact(String username) =>
      userDataProvider.addContact(username);

  Future<MessioUser> getUser(String username) =>
      userDataProvider.getUser(username);
  Future<void> updateProfilePicture(String profilePictureUrl) =>
      userDataProvider.updateProfilePicture(profilePictureUrl);

  @override
  void dispose() {
    userDataProvider.dispose();
  }
}
