import 'dart:nativewrappers/_internal/vm/lib/internal_patch.dart';

import 'package:dio/dio.dart';
import 'dart:io';

Future<void> uploadImage(File imageFile) async {
  String uploadURL = 'http://your-local-server-ip:5000/upload';
  FormData formData = FormData.fromMap({
    "imageFile":
        await MultipartFile.fromFile(imageFile.path, filename: "upload.jpg"),
  });

  Dio dio = Dio();

  try {
    var response = await dio.post(uploadURL, data: formData);
    printToConsole('File uploaded: ${response.data}');
  } catch (e) {
    printToConsole('Error occurred while uploading: $e');
  }
}
