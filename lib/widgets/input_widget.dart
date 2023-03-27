import 'dart:io';

import 'package:chat_app_elision/blocs/chats/chat_bloc.dart';
import 'package:chat_app_elision/blocs/chats/chat_event.dart';
import 'package:chat_app_elision/blocs/chats/chat_state.dart';
import 'package:chat_app_elision/config/constants.dart';
import 'package:chat_app_elision/models/chat.dart';
import 'package:chat_app_elision/models/contact.dart';
import 'package:chat_app_elision/utils/shared_objects.dart';
import 'package:chat_app_elision/widgets/gradient_snack_bar.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class InputWidget extends StatefulWidget {
  final Contact contact;

  InputWidget({this.contact});
  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  final TextEditingController textEditingController = TextEditingController();
  ChatBloc chatBloc;
  bool showEmojiKeyboard = false;
  Chat chat;
  @override
  void initState() {
    chatBloc = BlocProvider.of<ChatBloc>(context);
    chat = Chat(widget.contact.username, widget.contact.chatId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        elevation: 60.0,
        child: Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Material(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 1.0),
                      child: IconButton(
                        icon: Icon(Icons.face),
                        color: Theme.of(context).accentColor,
                        onPressed: () => chatBloc
                            .add(ToggleEmojiKeyboardEvent(!showEmojiKeyboard)),
                      ),
                    ),
                    color: Theme.of(context).primaryColor,
                  ),

                  // Text input
                  Flexible(
                    child: Material(
                        child: Container(
                      color: Theme.of(context).primaryColor,
                      child: TextField(
                        style: Theme.of(context).textTheme.bodyText1,
                        controller: textEditingController,
                        autofocus: true,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(Icons.attach_file),
                            onPressed: () => showAttachmentBottomSheet(context),
                            color: Theme.of(context).accentColor,
                          ),
                          hintText: 'Type a message',
                          hintStyle:
                              TextStyle(color: Theme.of(context).hintColor),
                        ),
                      ),
                    )),
                  ),

                  // Send Message Button
                  Material(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8.0),
                      child: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () => sendMessage(context),
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                    color: Theme.of(context).primaryColor,
                  ),
                ],
              ),
              BlocBuilder<ChatBloc, ChatState>(builder: (context, state) {
                showEmojiKeyboard = state is ToggleEmojiKeyboardState &&
                    state.showEmojiKeyboard;
                if (!showEmojiKeyboard) return Container();
                //hide keyboard
                FocusScope.of(context).requestFocus(new FocusNode());
                //create emojipicker
                return SizedBox(
                  height: 200,
                  child: EmojiPicker(
                    config: Config(
                      columns: 7,
                      bgColor: Theme.of(context).backgroundColor,
                      indicatorColor: Theme.of(context).accentColor,
                    ),
                    onEmojiSelected: (Category category, Emoji emoji) {
                      textEditingController.text =
                          textEditingController.text + emoji.emoji;
                    },
                  ),
                );
              })
            ],
          ),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border(
                top:
                    BorderSide(color: Theme.of(context).hintColor, width: 0.5)),
            color: Theme.of(context).primaryColor,
          ),
        ));
  }

  void sendMessage(context) {
    if (textEditingController.text.isEmpty) return;
    chatBloc.add(SendTextMessageEvent(textEditingController.text));
    textEditingController.clear();
  }

  showAttachmentBottomSheet(context) {
    showModalBottomSheet<Null>(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            color: Theme.of(context).backgroundColor,
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: Icon(Icons.image),
                    title: Text('Image'),
                    onTap: () => showFilePicker(FileType.image)),
                ListTile(
                    leading: Icon(Icons.videocam),
                    title: Text('Video'),
                    onTap: () => showFilePicker(FileType.video)),
                ListTile(
                  leading: Icon(Icons.insert_drive_file),
                  title: Text('File'),
                  onTap: () => showFilePicker(FileType.any),
                ),
              ],
            ),
          );
        });
  }

  //TODO: Verify if this migration works properly
  showFilePicker(FileType fileType) async {
    File file;
    if (fileType == FileType.image &&
        SharedObjects.prefs.getBool(Constants.configImageCompression)) {
      final pickedFile = await ImagePicker.platform
          .pickImage(source: ImageSource.gallery, imageQuality: 70);
      file = File(pickedFile.path);
    } else {
      final pickedFiles = await FilePicker.platform.pickFiles(type: fileType);
      if (pickedFiles.isSinglePick) {
        file = File(pickedFiles.files.first.path);
      } else if (pickedFiles.count == 0) {
        return;
      } else {
        GradientSnackBar.showMessage(
            context, 'Multiple files not supported yet!');
        return;
      }
    }
    if (file == null) return;
    chatBloc.add(SendAttachmentEvent(chat.chatId, file, fileType));
    Navigator.pop(context);
    GradientSnackBar.showMessage(context, 'Sending attachment..');
  }
}
