// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:small_social_app/features/auth/presentation/components/my_textfield.dart';
import 'package:small_social_app/features/home/presentation/cubit/profile_cubit.dart';
import 'package:small_social_app/features/home/presentation/cubit/profile_states.dart';
import 'package:small_social_app/profile/domain/entities/profile_user.dart';

class EditProfilePage extends StatefulWidget {
  final ProfileUser user;
  const EditProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final bioTextController = TextEditingController();

  //update profile button pressed
  void updateProfile() async {
    //Profile Cubit
    final profileCubit = context.read<ProfileCubit>();

    if (bioTextController.text.isNotEmpty) {
      profileCubit.updateProfile(
        uid: widget.user.uid,
        newBio: bioTextController.text,
      );
    }
  }

  //BUILD UI
  @override
  Widget build(BuildContext context) {
    //SCAFFOLD
    return BlocConsumer<ProfileCubit, ProfileState>(
      builder: (BuildContext context, ProfileState state) {
        //profile loading...
        if (state is ProfileLoading) {
          return const Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [CircularProgressIndicator(), Text("Uploading...")],
              ),
            ),
          );
        } else {
          //edit form
          return buildEditPage();
        }

        //profile error...

        //edit form...

        return buildEditPage();
      },
      listener: (BuildContext context, ProfileState state) {
        if (state is ProfileLoaded) {
          Navigator.pop(context);
        }
      },
    );
  }

  Widget buildEditPage({double uploadProgress = 0.0}) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        foregroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          //save button
          IconButton(onPressed: updateProfile, icon: const Icon(Icons.upload)),
        ],
      ),

      body: Column(
        children: [
          // profile picture

          // bio
          const Text('bio'),

          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: MyTextfield(
              hintText: widget.user.bio,
              obscureText: false,
              controller: bioTextController,
            ),
          ),
        ],
      ),
    );
  }
}
