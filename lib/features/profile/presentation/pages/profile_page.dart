// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:small_social_app/features/auth/domain/entities/app_user.dart';
import 'package:small_social_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:small_social_app/features/home/presentation/cubit/profile_cubit.dart';
import 'package:small_social_app/features/home/presentation/cubit/profile_states.dart';

class ProfilePage extends StatefulWidget {
  final String uid;
  const ProfilePage({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //cubits
  late final authCubit = context.read<AuthCubit>();
  late final profileCubit = context.read<ProfileCubit>();

  //current user
  late AppUser? currentUser = authCubit.currentUser;

  //on startup,
  @override
  void initState() {
    super.initState();

    //load user profile
    profileCubit.fetchUserProfile(widget.uid);
  }

  //Build UI
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        //loaded
        if (state is ProfileLoaded) {
          return Scaffold(
            //APP BAR
            appBar: AppBar(
              title: Text(currentUser!.email),
              foregroundColor: Theme.of(context).colorScheme.primary,
            ),
          );
        }
        //loading..
        else if (state is ProfileLoading) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else {
          return const Center(child: Text('no profile found'));
        }
      },
    );
  }
}
