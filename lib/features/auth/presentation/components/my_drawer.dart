import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:small_social_app/features/auth/presentation/components/my_drawer_tile.dart';
import 'package:small_social_app/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:small_social_app/features/profile/presentation/pages/profile_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Icon(
                  Icons.person,
                  size: 80,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),

              //Divider line
              Divider(color: Theme.of(context).colorScheme.secondary),

              //home tile
              MyDrawerTile(
                title: 'H O M E',
                icon: Icons.home,
                onTap: () => Navigator.of(context).pop(),
              ),

              //Profile tile
              MyDrawerTile(
                title: 'P R O F I L E',
                icon: Icons.home,
                onTap: () {
                  //pop menu drawer
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(
                        uid: context.read<AuthCubit>().currentUser!.uid,
                      ),
                    ),
                  );

                  //get current user id
                  final user = context.read<AuthCubit>().currentUser;
                  String? uid = user!.uid;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(uid: ''),
                    ),
                  );
                },
              ),

              //search tiles
              MyDrawerTile(
                title: 'S E A R C H',
                icon: Icons.search,
                onTap: null,
              ),

              //settings tile
              MyDrawerTile(
                title: 'S E T T I N G S',
                icon: Icons.settings,
                onTap: () {},
              ),

              //spacer
              const Spacer(),

              //logout tile
              MyDrawerTile(
                title: 'L O G O U T',
                icon: Icons.logout,
                onTap: () {
                  final authCubit = context.read<AuthCubit>();
                  authCubit.logout();
                },
              ),

              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
