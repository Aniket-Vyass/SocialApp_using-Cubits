import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class UploadPostPage extends StatefulWidget {
  const UploadPostPage({super.key});

  @override
  State<UploadPostPage> createState() => _UploadPostPageState();
}

class _UploadPostPageState extends State<UploadPostPage> {
  // mobile image pick
  PlatformFile? imagePickedFile;

  //web picked pick
  Uint8List? webImage;

  // text controller -> caption
  final textController = TextEditingController();

  // Build UI
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
