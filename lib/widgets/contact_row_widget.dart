import 'package:chat_app_elision/blocs/config/config_bloc.dart';
import 'package:chat_app_elision/blocs/config/config_state.dart';
import 'package:chat_app_elision/config/constants.dart';
import 'package:chat_app_elision/config/transitions.dart';
import 'package:chat_app_elision/models/contact.dart';
import 'package:chat_app_elision/pages/conversation_page_slide.dart';
import 'package:chat_app_elision/pages/single_conversation_page.dart';
import 'package:chat_app_elision/utils/shared_objects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class ContactRowWidget extends StatelessWidget {
  ContactRowWidget({
    Key key,
    @required this.contact,
  }) : super(key: key);
  final Contact contact;
  bool configMessagePaging = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigBloc, ConfigState>(builder: (context, state) {
      if (state is UnConfigState)
        configMessagePaging =
            SharedObjects.prefs.getBool(Constants.configMessagePaging);
      if (state is ConfigChangeState) if (state.key ==
          Constants.configMessagePaging) configMessagePaging = state.value;

      return InkWell(
        onTap: () => Navigator.push(
            context,
            SlideLeftRoute(
                page: configMessagePaging
                    ? ConversationPageSlide(startContact: contact)
                    : SingleConversationPage(
                        contact: contact,
                      ))),
        child: Container(
            color: Theme.of(context).primaryColor,
            child: Padding(
                padding: const EdgeInsets.only(left: 30, top: 10, bottom: 10),
                child: RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyText1,
                    children: <TextSpan>[
                      TextSpan(text: contact.getFirstName()),
                      TextSpan(
                          text: ' ' + contact.getLastName(),
                          style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                ))),
      );
    });
  }
}
