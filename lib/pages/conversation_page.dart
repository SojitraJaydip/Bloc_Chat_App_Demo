import 'dart:ui';

import 'package:chat_app_elision/blocs/chats/bloc.dart';
import 'package:chat_app_elision/blocs/chats/chat_bloc.dart';
import 'package:chat_app_elision/models/chat.dart';
import 'package:chat_app_elision/models/contact.dart';
import 'package:chat_app_elision/widgets/chat_app_bar.dart';
import 'package:chat_app_elision/widgets/chat_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ConversationPage extends StatefulWidget {
  Chat chat;
  Contact contact;
  @override
  _ConversationPageState createState() => _ConversationPageState(chat, contact);

  ConversationPage({this.chat, this.contact});
}

class _ConversationPageState extends State<ConversationPage>
    with AutomaticKeepAliveClientMixin {
  Chat chat;
  Contact contact;
  _ConversationPageState(this.chat, this.contact);

  ChatBloc chatBloc;

  @override
  void initState() {
    super.initState();
    if (contact != null) chat = Chat(contact.username, contact.chatId);
    chatBloc = BlocProvider.of<ChatBloc>(context);
    chatBloc.add(FetchConversationDetailsEvent(chat));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 100),
          color: Theme.of(context).backgroundColor,
          child: ChatListWidget(chat),
        ),
        SizedBox.fromSize(
            size: Size.fromHeight(100),
            child: ChatAppBar(contact: contact, chat: chat))
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
