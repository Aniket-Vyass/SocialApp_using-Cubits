import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:small_social_app/features/storage/domain/storage_repo.dart';

class FirebaseStorageRepo implements StorageRepo {
  final FirebaseStorage storage = FirebaseStorage.instance;

  @override
  Future<String> uploadProfileImageMobile(String path, String fileName) {
    // TODO: implement uploadProfileImageWeb
    throw UnimplementedError();
  }

  @override
  Future<String> uploadProfileImageWeb(Uint8List fileBytes, String fileName) {
    // TODO: implement uploadProfileImageWeb
    throw UnimplementedError();
  }

  /*

  HELPER METHODS - to upload files to storage

  */

  //mobile platform(file)
  Future<String?> _uploadFile(
    String path,
    String filename,
    String folder,
  ) async {
    try {} catch (e) {}
  }

  //web platform(bytes)
}
