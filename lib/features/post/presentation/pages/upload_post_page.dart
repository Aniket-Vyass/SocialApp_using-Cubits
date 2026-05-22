import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:small_social_app/features/auth/domain/entities/app_user.dart';
import 'package:small_social_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:small_social_app/features/post/domain/enitites/post.dart';

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

  //current user
  AppUser? currentUser;

  @override
  void intiState() {
    super.initState();

    getCurrentUser;
  }

  // get current user
  void getCurrentUser() {
    final authCubit = context.read<AuthCubit>();
    currentUser = authCubit.currentUser;
  }

  //select image
  // pick image
  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      withData: kIsWeb,
    );

    if (result != null) {
      setState(() {
        imagePickedFile = result.files.first;

        if (kIsWeb) {
          webImage = imagePickedFile!.bytes;
        }
      });
    }
  }

  // create and upload the post
  void uploadPost() {
    //check if both the image and caption are provided
    if (imagePickedFile == null || textController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Both image and Caption are required')),
      );
      return;
    }

    //create a new post object
    // final newPost = Post(id: DateTime.now().millisecondsSinceEpoch.toString(), userId: currentUser!.uid, userName: '', text: '', imageUrl: '', timestamp: null)
  }

  // Build UI
  @override
  Widget build(BuildContext context) {
    //Scaffold
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Post"),
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
