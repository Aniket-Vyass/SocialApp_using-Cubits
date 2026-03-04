import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:small_social_app/features/auth/presentation/components/my_drawer_tile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: Column(
          children: [
            const SizedBox(height: 50),
            Icon(
              Icons.person,
              size: 80,
              color: Theme.of(context).colorScheme.primary,
            ),

            //home tile
            MyDrawerTile(title: 'H O M E', icon: Icons.home),

            //search tiles
            Icon(Icons.search, color: Theme.of(context).colorScheme.primary),

            //settings tile
            Icon(Icons.settings, color: Theme.of(context).colorScheme.primary),

            //logout tile
            Icon(Icons.logout, color: Theme.of(context).colorScheme.primary),
          ],
        ),
      ),
    );
  }
}
