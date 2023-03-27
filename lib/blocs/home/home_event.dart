import 'package:chat_app_elision/models/conversation.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeEvent {
  HomeEvent([List props = const <dynamic>[]]);
  @override
  List<Object> get props => [];
}

class FetchHomeChatsEvent extends HomeEvent {
  @override
  String toString() => 'FetchHomeChatsEvent';
}

class ReceivedChatsEvent extends HomeEvent {
  final List<Conversation> conversations;
  ReceivedChatsEvent(this.conversations);

  @override
  String toString() => 'ReceivedChatsEvent';
}
