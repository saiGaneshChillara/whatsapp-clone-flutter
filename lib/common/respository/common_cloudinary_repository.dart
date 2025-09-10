import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:riverpod/riverpod.dart';

final commonCloudinaryRepositoryProvider = Provider(
  (ref) => CommonCloudinaryRepository(),
);

class CommonCloudinaryRepository {
  final cloudinary = CloudinaryPublic("dpfrwxe1r", "whatsa-app-backend");

  Future<String> storeFileToCloudinary(String folder, File file) async {
    try {
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(file.path, folder: folder),
      );
      return response.secureUrl;
    } catch (e) {
      throw Exception("Upload failed : $e");
    }
  }
}
