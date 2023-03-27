import 'package:chat_app_elision/models/conversation.dart';
import 'package:chat_app_elision/utils/document_snapshot_extension.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Contact {
  String username;
  String name;
  String photoUrl;
  String documentId;
  String chatId;
  Contact(
      this.documentId, this.username, this.name, this.photoUrl, this.chatId);

  factory Contact.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.dataAsMap;
    return Contact(doc.id, data['username'], data['name'], data['photoUrl'],
        data['chatId']);
  }

  @override
  String toString() {
    return '{ documentId: $documentId, name: $name, username: $username, photoUrl: $photoUrl , chatId: $chatId}';
  }

  String getFirstName() => name.split(' ')[0];

  String getLastName() {
    List names = name.split(' ');
    return names.length > 1 ? names[1] : '';
  }

  factory Contact.fromConversation(Conversation conversation) {
    return Contact(
      conversation.user.documentId,
      conversation.user.username,
      conversation.user.name,
      conversation.user.photoUrl,
      conversation.chatId,
    );
  }
}
