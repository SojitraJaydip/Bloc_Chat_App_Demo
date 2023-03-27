import 'dart:io';

import 'package:chat_app_elision/providers/storage_provider.dart';
import 'package:chat_app_elision/repositories/base_repository.dart';

class StorageRepository extends BaseRepository {
  StorageProvider storageProvider = StorageProvider();
  Future<String> uploadFile(File file, String path) =>
      storageProvider.uploadFile(file, path);

  @override
  void dispose() {
    storageProvider.dispose();
  }
}
