//
import 'dart:typed_data';

abstract class StorageRepo {
  //upload profile image on mobile platforms
  Future<String?> uploadProfileImageMobile(String path, String fileName);

  //upload profile image on web platforms
  Future<String?> uploadProfileImageWeb(Uint8List fileBytes, String fileName);
}
