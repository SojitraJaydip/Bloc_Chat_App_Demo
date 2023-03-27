import 'package:chat_app_elision/models/message.dart';
import 'package:chat_app_elision/models/video_wrapper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AttachmentsState {
  AttachmentsState([List props = const <dynamic>[]]);
}

class InitialAttachmentsState extends AttachmentsState {}

class FetchedAttachmentsState extends AttachmentsState {
  final List<Message> attachments;
  final FileType fileType;

  FetchedAttachmentsState(this.fileType, this.attachments)
      : super([attachments, fileType]);

  @override
  String toString() =>
      'FetchedAttachmentsState { attachments : $attachments , fileType : $fileType}';
}

class FetchedVideosState extends AttachmentsState {
  final List<VideoWrapper> videos;

  FetchedVideosState(this.videos) : super([videos]);

  @override
  String toString() => 'FetchedVideosState { videos : $videos }';
}
