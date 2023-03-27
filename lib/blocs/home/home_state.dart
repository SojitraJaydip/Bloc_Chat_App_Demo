import 'package:chat_app_elision/models/conversation.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeState {
  HomeState([List props = const <dynamic>[]]);
  @override
  List<Object> get props => [];
}

class InitialHomeState extends HomeState {}

class FetchingHomeChatsState extends HomeState {
  @override
  String toString() => 'FetchingHomeChatsState';
}

class FetchedHomeChatsState extends HomeState {
  final List<Conversation> conversations;

  FetchedHomeChatsState(this.conversations);

  @override
  String toString() => 'FetchedHomeChatsState';
}
