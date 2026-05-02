import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:small_social_app/features/home/presentation/cubit/profile_cubit.dart';
import 'package:small_social_app/features/home/presentation/cubit/profile_states.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final bioTextController = TextEditingController();

  //BUILD UI
  @override
  Widget build(BuildContext context) {
    //SCAFFOLD
    return BlocConsumer<ProfileCubit, ProfileState>(
      builder: (BuildContext context, ProfileState state) {
        //profile loading...

        //profile error...

        //edit form...

        //return buildEditPage();
      },
      listener: (BuildContext context, ProfileState state) {},
    );
  }
}
