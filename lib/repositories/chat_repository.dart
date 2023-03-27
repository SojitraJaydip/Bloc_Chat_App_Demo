import 'dart:async';

import 'package:chat_app_elision/models/chat.dart';
import 'package:chat_app_elision/models/conversation.dart';
import 'package:chat_app_elision/models/message.dart';
import 'package:chat_app_elision/models/messio_user.dart';
import 'package:chat_app_elision/providers/base_providers.dart';
import 'package:chat_app_elision/providers/chat_provider.dart';

import 'base_repository.dart';

class ChatRepository extends BaseRepository {
  BaseChatProvider chatProvider = ChatProvider();
  Stream<List<Conversation>> getConversations() =>
      chatProvider.getConversations();
  Stream<List<Chat>> getChats() => chatProvider.getChats();
  Stream<List<Message>> getMessages(String chatId) =>
      chatProvider.getMessages(chatId);
  Future<List<Message>> getPreviousMessages(
          String chatId, Message prevMessage) =>
      chatProvider.getPreviousMessages(chatId, prevMessage);

  Future<List<Message>> getAttachments(String chatId, int type) =>
      chatProvider.getAttachments(chatId, type);

  Future<void> sendMessage(String chatId, Message message) =>
      chatProvider.sendMessage(chatId, message);

  Future<String> getChatIdByUsername(String username) =>
      chatProvider.getChatIdByUsername(username);

  Future<void> createChatIdForContact(MessioUser user) =>
      chatProvider.createChatIdForContact(user);

  @override
  void dispose() {
    chatProvider.dispose();
  }
}
