import 'dart:io';

import 'package:meta/meta.dart';

@immutable
abstract class ConfigEvent {
  ConfigEvent([List props = const <dynamic>[]]);
}

class ConfigValueChanged extends ConfigEvent {
  final String key;
  final bool value;
  ConfigValueChanged(this.key, this.value) : super([key, value]);
}

class UpdateProfilePicture extends ConfigEvent {
  final File file;
  UpdateProfilePicture(this.file) : super([file]);
  @override
  String toString() => 'UpdateProfilePicture';
}

class RestartApp extends ConfigEvent {
  @override
  String toString() => 'RestartApp';
}
